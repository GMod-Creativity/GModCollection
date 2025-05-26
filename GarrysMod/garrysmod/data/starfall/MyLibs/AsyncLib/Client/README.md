# Asynchronous Client Library For Starfall

## Example 1: Thread race game with 2 threads
In this example two threads will be made that are called ThreadA and ThreadB.
Both threads will count to ten. Each thread will have a random wait time before it counts up by one.
The first thread to get to ten wins.

```lua
--@name async_example_game_2_threads
--@author ESF
--@client
--@include Starfall/MyLibs/Async/Client/async_cl_lib.txt
--Source: Async Public Starfall Lib from Aeralius
--Note: Modified version of the example for the public Starfall Async Lib from Aeralius

--Get the library
Async = require("Starfall/MyLibs/Async/Client/async_cl_lib.txt")
Async.startThreading()

--This is for later
counterA = 0
counterB = 0

--First, we define the functions before we create the threads. We need to give them instructions.
function MessageA()
    local counter = 0 --We can use local variables ^^ 
    while true do --Set up your loop, but do not forget something to "throttle" it. perf, perf2, yield and wait are good ones
        Async.wait(math.random(0.1,1.5)) --Wait in seconds
        
        print("Message A: " .. counter)  
        
        counter = counter + 1 
        counterA = counter 
    end
end

function MessageB()
    local counter = 0 
    while true do
        Async.wait(math.random(0.1,1.5))
        
        print("   Message B: " .. counter)  
        
        counter = counter + 1  
        counterB = counter
    end
end


--Create the threads. They are still sleeping, so we have to wake them up with :run() later
ThreadA = Async.thread.create(MessageA)  
ThreadB = Async.thread.create(MessageB)

--Create the game thread, directly defining the function, running them at the same time.
Async.thread.create(function()
    print("Main thread started... See which thread will win this race by going over 10")
    
    --Lets run the threads!
    
    ThreadA:run() --You can actually pass data into the run(). run("Please read this") and this is passed to the function inside
    --You want to pass more data but this is later? :update("Please read this. It's different now") 
    ThreadA.name = "Player A" --You can name threads if you want. It's not required, but makes looking them up easier in thread.pool. The more you know
    print("Thread A, go") 
    
    ThreadB:run()
    ThreadA.name = "Player B"
    print("Thread B, go")
    
    
    while true do
        Async.perf2(20, false) --I only want 20uS of server time used. perf() without the 2 makes the thread wait in precentages. 
        if counterA > 10 then
            print("Thread A won!")
            break
        end
        if counterB > 10 then
            print("Thread B won!")
            break
        end         
    end
    
    --You can call stop() to stop the threads. Wow
    print("Closing all threads")
    ThreadA:stop()
    ThreadB:stop()
    
    --Thread closes automatically when it reached its end.
    print("Exiting main thread. Closing race")       
    
end):run() --Called :run() right after creation. No need to store this thread 

```

## Example 2: Thread race game with 10 threads
In example 1 we saw that 2 threads were made manually. This is usefull if we need a few threads but 
what if we need more like 10 or 100 or even more.
To solve this issue we use loops to create multiple threads and keep track of what their counts are.
In this example ten threads will try to count to ten. The first thread to get to ten first wins.
This example is the same as the first one except for the way it handles multiple threads.

```lua
--@name async_example_game_10_threads
--@author ESF
--@client
--@include Starfall/MyLibs/Async/Client/async_cl_lib.txt

--Get the library
Async = require("Starfall/MyLibs/Async/Client/async_cl_lib.txt")
Async.startThreading()

--This is for later
counters = {}  -- Table to hold counters for each type

--Define the function that will be used by all threads
function Message(type)
    if not counters[type] then
        counters[type] = 0  -- Initialize the counter for this type if it doesn't exist
    end
    
    while true do
        Async.wait(math.random(0.1,1.5)) --Wait in seconds
        print("Message " .. type .. ": " .. counters[type])  
        counters[type] = counters[type] + 1  -- Increment the counter for this type
    end
end

-- Function to create and run threads
function createAndRunThread(type)
    local thread = Async.thread.create(function() Message(type) end)
    thread:run()
    thread.name = "Player " .. type
    print("Thread " .. type .. ", go")
    return thread
end

--Create the game thread, directly defining the function, running them at the same time.
Async.thread.create(function()
    print("Main thread started... See which thread will win this race by going over 10")
    
    -- Create and run threads from A to J
    local threads = {}
    for i = 65, 74 do  -- ASCII values for A to J
        local type = string.char(i)
        threads[type] = createAndRunThread(type)
    end
    
    local winner = nil
    while true do
        Async.perf2(20, false) --I only want 20uS of server time used. perf() without the 2 makes the thread wait in percentages.
        for type, _ in pairs(counters) do
            if counters[type] > 10 then
                winner = type
                print("Thread " .. type .. " won!")
                break
            end
        end
        if winner then break end
    end
    
    -- Stop all threads
    print("Closing all threads")
    for _, thread in pairs(threads) do
        thread:stop()
    end
    
    --Thread closes automatically when it reached its end.
    print("Exiting main thread. Closing race")       
    
end):run() --Called :run() right after creation. No need to store this thread

```

## License

[MIT](https://choosealicense.com/licenses/mit/)
