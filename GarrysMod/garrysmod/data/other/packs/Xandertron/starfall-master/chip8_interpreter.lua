--@name chip8 interpreter
--@author Xandertron
--@shared

/*
    Cant get it to run steady, but oh well
    store roms in garrysmod/data/sf_filedata/
    
    place chip on a starfall screen
    link a hud to the chip to be able to lock controls with !lock, exit with alt
    you can stop the interpreter with !stop
*/

local romFile = "chip8/4-flags.ch8" --path to the rom at gamedir/data/sf_filedata/ ie chip8/pong.ch8
local freq = 500 --between 1 and 1000 hz, will try and run at that many instructions per second
local quotaPercentage = 0.5 --between 0 and 1

if SERVER then
    local screen = chip():isWeldedTo()
    if screen then
        screen:linkComponent(chip())
    end
else
    --memory

    local memory = {}
    for i=1, 4096 do
        memory[i] = 0
    end
    
    --display
    
    local sx = 64
    local sy = 32
    local off = Color(30,30,30)
    local on = Color(0,255,0)
    
    local framebuffer = {}
    for i=1, sx*sy do
        framebuffer[i] = 0
    end
    
    --keyboard
    
    /*
    chip 8 gamepad, my layout
    1    2    3    C  1 2 3 4
    4    5    6    D  Q W E R
    7    8    9    E  A S D F
    A    0    B    F  Z X C V
    */

    local inputs = {
        [1] = 2,    --1
        [2] = 3,    --2
        [3] = 4,    --3
        [0xC] = 5,  --4
        [4] = 27,   --Q
        [5] = 33,   --W
        [6] = 15,   --E
        [0xD] = 28, --R
        [7] = 11,   --A
        [8] = 29,   --S
        [9] = 14,   --D
        [0xE] = 16, --F
        [0xA] = 36, --Z
        [0] = 35,   --X
        [0xB] = 13, --C
        [0xF] = 32  --V
    }
    
    --registers
    
    local v = {}
    for i=0,15 do v[i] = 0 end
    
    local ri = 0
    local dt = 0
    local st = 0
    
    --load font
    
    local font = {
      0xF0, 0x90, 0x90, 0x90, 0xF0, /* 0 */
      0x20, 0x60, 0x20, 0x20, 0x70, /* 1 */
      0xF0, 0x10, 0xF0, 0x80, 0xF0, /* 2 */
      0xF0, 0x10, 0xF0, 0x10, 0xF0, /* 3 */
      0x90, 0x90, 0xF0, 0x10, 0x10, /* 4 */
      0xF0, 0x80, 0xF0, 0x10, 0xF0, /* 5 */
      0xF0, 0x80, 0xF0, 0x90, 0xF0, /* 6 */
      0xF0, 0x10, 0x20, 0x40, 0x40, /* 7 */
      0xF0, 0x90, 0xF0, 0x90, 0xF0, /* 8 */
      0xF0, 0x90, 0xF0, 0x10, 0xF0, /* 9 */
      0xF0, 0x90, 0xF0, 0x90, 0x90, /* A */
      0xE0, 0x90, 0xE0, 0x90, 0xE0, /* B */
      0xF0, 0x80, 0x80, 0x80, 0xF0, /* C */
      0xE0, 0x90, 0x90, 0x90, 0xE0, /* D */
      0xF0, 0x80, 0xF0, 0x80, 0xF0, /* E */
      0xF0, 0x80, 0xF0, 0x80, 0x80, /* F */
    }
    
    for i,v in ipairs(font) do
        memory[i+50-1] = v
    end
    
    --stack things
    
    local counter = 0x200
    local stack = {}
    local stackPointer = 0
    
    local function incCounter(cycles)
        counter = counter + cycles
    end
    
    --explode 124E into 1, 2, 4, E, 24E, 4E
    
    local function explodeInstr(instr)
        return {
            [1] =   bit.rshift(bit.band(instr,0xF000),12),
            [2] =   bit.rshift(bit.band(instr,0x0F00),8),
            [3] =   bit.rshift(bit.band(instr,0x00F0),4),
            [4] =   bit.rshift(bit.band(instr,0x000F),0),
            ["nnn"] = bit.rshift(bit.band(instr,0x0FFF),0),
            ["kk"] =  bit.rshift(bit.band(instr,0x00FF),0)
        } 
    end
    
    --explode number into binary representation
    
    local function getBits(number)
        if number == 0 then return {0} end
        
        local bits = {}
        
        while number > 0 do
            table.insert(bits, 1, number % 2)
            number = math.floor(number / 2)
        end
        
        --pad
        while #bits < 8 do
            table.insert(bits, 1, 0)
        end
        
        return bits
    end
    
    --instructions for 8__X
    
    local instrTableSub8 = {
        [0] = function(instr) v[instr[2]] = v[instr[3]] return "8xy0 - LD Vx, Vy" end,
        [1] = function(instr) v[instr[2]] = bit.bor(v[instr[2]],v[instr[3]]) v[0xF] = 0 return "8xy1 - OR Vx, Vy" end,
        [2] = function(instr) v[instr[2]] = bit.band(v[instr[2]],v[instr[3]]) v[0xF] = 0 return "8xy2 - AND Vx, Vy" end,
        [3] = function(instr) v[instr[2]] = bit.bxor(v[instr[2]],v[instr[3]]) v[0xF] = 0 return "8xy3 - XOR Vx, Vy" end,
        [4] = function(instr)
            temp = v[instr[2]] + v[instr[3]]
            v[instr[2]] = temp % 256
            v[0xF] = (temp > 255) and 1 or 0
            return "8xy4 - ADD Vx, Vy"
        end,
        [5] = function(instr) 
            local temp = v[instr[2]] - v[instr[3]]
            v[instr[2]] = temp % 256
            v[0xF] = (temp < 0) and 0 or 1
            return "8xy5 - SUB Vx, Vy"
        end,
        [6] = function(instr)
            v[instr[2]] = v[instr[3]]
            local temp = v[instr[2]]
            local shift = bit.rshift(temp,1)
            v[instr[2]] = shift % 256
            v[0xF] = (bit.band(temp, 0x1) == 0x1) and 1 or 0
            return "8xy6 - SHR Vx {, Vy}"
        end,
        [7] = function(instr) 
            local temp = v[instr[3]] - v[instr[2]]
            v[instr[2]] = temp % 256
            v[0xF] = (temp < 0) and 0 or 1
            return "8xy7 - SUBN Vx, Vy"
        end,
        [14] = function(instr)
            v[instr[2]] = v[instr[3]]
            local temp = v[instr[2]]
            local shift = bit.lshift(temp,1)
            v[instr[2]] = shift % 256
            v[0xF] = (bit.band(temp, 0x80) == 0x80) and 1 or 0
            
            --v[0xF] = (bit.band(v[instr[2]], 0x80) == 0x80) and 1 or 0
            --v[instr[2]] = bit.lshift(v[instr[2]], 1) % 256
            return "8xyE - SHL Vx {, Vy}"
        end,
    }
    
    --instructions for F_XX
    
    local instrTableSub15 = {
        [0x07] = function(instr) v[instr[2]] = dt return "Fx07 - LD Vx, DT" end,
        [0x0A] = function(instr) hook.remove("think","run") return "Fx0A - LD Vx, K" end, --wait for keyboard
        [0x15] = function(instr) dt = v[instr[2]] return "Fx15 - LD DT, Vx" end,
        [0x18] = function(instr) st = v[instr[2]] return "Fx18 - LD ST, Vx" end,
        [0x1E] = function(instr) ri = ri + v[instr[2]] return "Fx1E - ADD I, Vx" end,
        [0x29] = function(instr) ri = 50+5*v[instr[2]] return "Fx29 - LD F, Vx" end,
        [0x33] = function(instr) 
            local n = v[instr[2]]
            memory[ri] = math.floor(n / 100)
            memory[ri+1] = math.floor((n % 100) / 10)
            memory[ri+2] = n % 10
            return "Fx33 - LD B, Vx"
        end,
        [0x55] = function(instr)
            for i = 0, instr[2] do
                memory[ri+i] = v[i]
            end
            return "Fx55 - LD [I], Vx"
        end,
        [0x65] = function(instr)
            for i = 0, instr[2] do
                v[i] = memory[ri+i]
            end
            return "Fx65 - LD Vx, [I]"
        end
    }
    
    --top level instructions, X___
    
    local instrTable = {
        [0] = function(instr)
            if instr.kk == 0xEE then
                counter = table.remove(stack)
                return "00EE - RET"
            elseif instr.kk == 0xE0 then
                for i=1, sx*sy do
                    framebuffer[i] = 0
                end
                return "00E0 - CLS"
            end
            
        end,
        [1] = function(instr) counter = (instr.nnn % 2^16)-2 return "1nnn - JP addr" end,
        [2] = function(instr)
            table.insert(stack, counter)
            counter = instr.nnn-2
            return "2nnn - CALL addr"
        end,
        [3] = function(instr)
            if v[instr[2]] == instr.kk then
                incCounter(2)
            end
            return "3xkk - SE Vx, byte"
        end,
        [4] = function(instr)
            if v[instr[2]] ~= instr.kk then
                incCounter(2)
            end
            return "4xkk - SNE Vx, byte"
        end,
        [5] = function(instr)
            if v[instr[2]] == v[instr[3]] then
                incCounter(2)
            end
            return "5xy0 - SE Vx, Vy"
        end,
        [6] = function(instr)
            v[instr[2]] = instr.kk % 256
            return "6xkk - LD Vx, byte"
        end,
        [7] = function(instr)
            v[instr[2]] = (v[instr[2]] + instr.kk) % 256
            return "7xkk - ADD Vx, byte"
        end,
        [8] = function(instr)
            return instrTableSub8[instr[4]](instr)
        end,
        [9] = function(instr) 
            if v[instr[2]] ~= v[instr[3]] then
                incCounter(2)
            end
            return "9xy0 - SNE Vx, Vy"
        end,
        [10] = function(instr) ri = instr.nnn % 2^16 return "Annn - LD I, addr" end,
        [11] = function(instr) counter = (instr.nnn + v[0])-2 return "Bnnn - JP V0, addr" end, --todo remove 200
        [12] = function(instr) v[instr[2]] = bit.band(math.round(math.random(0,255)),instr.kk) return "Cxkk - RND Vx, byte" end,
        [13] = function(instr)
            local x = v[instr[2]]
            local y = v[instr[3]]
            local height = instr[4]
            local spriteAddress = ri
            local sprite = {}
            
            for i=0, height-1 do
                table.insert(sprite,i+1,memory[spriteAddress+i])
            end
            
            for spriteLayer,data in ipairs(sprite) do
                local s = getBits(data)
                for i=1,8 do
                    fbIdx = ((y%sy) - 1 + spriteLayer) * sx + math.clamp((x%64)+i,0,sx)
                    if framebuffer[fbIdx] == 1 then v[0xF] = 1 end
                    framebuffer[fbIdx] = bit.bxor(s[i] or 0,framebuffer[fbIdx] or 0)
                end
            end
            
            return "Dxyn - DRW Vx, Vy, nibble"
        end,
        [14] = function(instr) 
            if instr.kk == 0x9E then
                if input.isKeyDown(inputs[v[instr[2]]]) then
                    incCounter(2)
                end
                return "Ex9E - SKP Vx"
            elseif instr.kk == 0xA1 then
                if not input.isKeyDown(inputs[v[instr[2]]]) then
                    incCounter(2)
                end
                return "ExA1 - SKNP Vx"
            end
        end,
        [15] = function(instr) return instrTableSub15[instr.kk](instr) end
    }
    
    local rom = file.read(romFile)
    print("Loaded "..romFile..", "..#rom.." bytes")
    local rom = string.split(rom,"")
    for k,v in ipairs(rom) do
        --local a = math.rand(0,100)
        --if a < 2 then a = 1 else a = 0 end
        memory[k+0x200-1] = string.byte(v)
    end
    
    --memory[0x1ff] = 1
    
    local function step(doDebug)
        if counter >= 4096 then return false end
        
        local instrIn = bit.lshift(memory[counter],8) + memory[counter+1]
        
        if doDebug then
            print(bit.tohex(instrIn))
        end
        
        local instruction = explodeInstr(instrIn)
        local result = instrTable[instruction[1]](instruction)
        counter = counter + 2
        
        if doDebug then
            print(result)
        end
    end
    
    --timer.create("run",0.01,0,function()
    --    step(false)
    --end)
    
    --local stepcounter = 1
    --timer.create("counter",1,0,function()
    --    print(stepcounter)
    --    stepcounter = 0
    --end)
    
    timer.create("timer",1/60,0,function()
        dt = math.clamp(dt - 1, 0, 1000000000000000)
        st = math.clamp(st - 1, 0, 1000000000000000)
    end)
    
    local function canRun()
        return quotaTotalUsed()<quotaMax()*quotaPercentage
    end
    
    local systime = timer.systime
    local time = systime()
    local freq = 1 / freq
    
    hook.add("think","run",function()
        while canRun() do
            if systime() >= time + freq then
                --stepcounter = stepcounter + 1
                step(false)
                time = systime()
            end
        end
    end)
    
    hook.add("playerchat","",function(ply,msg)
        if ply == owner() then
            if msg == ",stop" then
                timer.remove("run")
            elseif msg == ",lock" then
                input.lockControls(true)
            end
        end
    end)
    
    local cs = {}
    for i=0, 255 do
        cs[i] = Color(i,i,i)
    end
    
    local icolor = Color(50,50,255)
    local ccolor = Color(255,30,30)
    
    hook.add("render","draw",function()
        for i=1, sx*sy do
            local x = ((i - 1) % sx)
            local y = math.floor((i - 1) / sx)
            if i <= sx*sy then
                render.setColor(framebuffer[i]==1 and on or off)
                render.drawRect(x*8,y*8,8,8)
            end
        end
    end) 
    
end


