local CheckedCodeTable = {}
local VirusTable = {}

//local SomeTable = {}
//SomeTable["hello"] = 1

local function findKeyword(String, Query)
	local Find = (string.find( string.lower(String), string.lower(Query), 1, false )) 
	
	if (Find == nil) then
		return false
	else
		return true
	end
end

local function findInBrackets(String, BeforeBracket, InBracket) //Function looks for a word inside brackets after the query keyword
	local SearchStart = string.Explode(BeforeBracket, String)[2]
	local BracketSearch = string.Explode(")", SearchStart)
	if (findKeyword(BracketSearch[1],InBracket)) then
		return true
	else
		return false
	end
end

local function isStaff(Ply)
	if (Ply:IsSuperAdmin() ||  Ply:IsAdmin()) then
		return true
	else
		return false
	end
end

local function analyseCode(Chip, Code, Hash)
	//Heuristic Test Consists of Factors including: Name, known dsGroups, ect.
	//Heuristic cutoff point is 10 points
	
	local NoLBracketCode = string.Replace( Code, "(", "" )
	local NoBracketCode = string.Replace( NoLBracketCode, ")", "" )	
	local HeuristicValue = 0
	
	if (findKeyword(NoBracketCode,"dsJoinGroup"..'"'.."crynet"..'"')) then
		HeuristicValue = 10
		
	elseif (findKeyword(Code,"@name RECOVERED INFECTIOUS MEME")) then
		HeuristicValue = 10
		
	elseif (findKeyword(Code,"@name dupe stealer")) then
		HeuristicValue = 10
		
	elseif (findKeyword(NoBracketCode,"concmd"..'"'.."rcon")) then
		local Owner = Chip:CPPIGetOwner()
		if (isStaff(Owner) == false) then
			HeuristicValue = 10
		end
	end
		
	if (HeuristicValue >= 10) then
		VirusTable[Hash] = true
		SafeRemoveEntity(Chip)		
	end
	
	CheckedCodeTable[Hash] = true	
end

local function findE2s()
	
	local Chips = ents.FindByClass( "gmod_wire_expression2" )
		
	for i=1,table.Count(Chips) do		
		local Code = Chips[i]:GetCode()
		
		if (Code != nil) then
			local Hash = tostring(util.CRC(Code))
			
			if (VirusTable[Hash]==true) then
				SafeRemoveEntity(Chips[i])
			else
				if (CheckedCodeTable[Hash] == nil) then				
					analyseCode(Chips[i],Code,Hash)	
				end		
			end			
		end		
	end

end

local function CreateTimer()
	timer.Create( "e2check", 2.5, 0, findE2s )
end

hook.Add( "Initialize", "Timer Example", CreateTimer )