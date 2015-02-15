AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("interface/cl_dmenu.lua")
-- AddCSLuaFile("player/inventory.lua")

include('shared.lua')
include('interface/cl_demnu.lua')
-- include('player/inventory.lua')

function GM:PlayerAuthed( ply, steamID, uniqueID )
	print(ply:Nick() .. " has been authed.")
end

function GM:PlayerSpawn(ply)
    self.BaseClass:PlayerSpawn(ply)
    ply:StripWeapons()
    if ply:Team() == 2 then
    	ply:Give("weapon_fists")
    	ply:AddItemToInventory(1, "badhammer")
    end
end

function GM:PlayerLoadout(ply)
end

function GM:PlayerInitialSpawn(ply)
	print('Player ' .. ply:Nick() .. " has joined the game.")
	ply:SetTeam(1)
	ply:SetNWString("SquadName", "None")
end

function GM:PlayerDisconnected(ply)
	for _,pl in pairs(player.GetAll()) do
		pl:ChatPrint(ply:Nick() .. " disconnected.")
	end
end

/* Function Key Mappings
----------------------*/

-- F1
function GM:ShowHelp(ply)
	umsg.Start("dm_inventory", ply)
	umsg.End()
end

-- F2
function GM:ShowTeam(ply)
	umsg.Start("dm_health", ply)
	umsg.End()
end

-- F3
function GM:ShowSpare1(ply)
	umsg.Start("dm_showmouse", ply)
	umsg.End()
end

-- F4
function GM:ShowSpare2(ply)
	umsg.Start("dm_dmenu", ply)
	umsg.End()
end

/* Item Spawns
------------*/

function SpawnItem()
	local itemspawns = ents.FindByName("dment_itemspawn_*")
end

concommand.Add("dm_dmenu", function(ply, cmd, args) umsg.Start("dm_dmenu", ply)
	umsg.End()end)

-- Sethealth Command
concommand.Add("dm_sethealth", function(ply, cmd, args) NewHealth(ply, args) end)

function NewHealth(ply, newHealth)
	local newHealth = table.GetFirstValue(newHealth)
	ply:SetHealth(newHealth)
end

--local stam = 100

--function StaminaBar(ply)
--	while ply:KeyDown(IN_SPEED) do
--		stam = stam - 5
--	end
--	ply:SetNWInt("stamina", stam)
--end

--local StamEnabled = 0

--while StamEnabled == 1 do
--	for j,v in pairs(player.GetAll()) do
--		StaminaBar(v)
--	end
--end

--concommand.Add("dm_stamina", function(ply, cmd, args) StamEnabled = args end)

function SetPlayerTeam(ply)
	ply:SetTeam(2)
	ply:Spawn()
end
concommand.Add("dm_setplayerteam", function(ply, cmd, args) SetPlayerTeam(ply) end)

function SelectMaster()
	local newmaster = table.Random(player.GetAll())

	for _,v in pairs(player.GetAll()) do
		if v == newmaster then
			v:SetTeam(3)
			v:Spawn()
			v:SetMoveType(MOVETYPE_OBSERVER)
			v:Spectate(OBS_MODE_ROAMING)
			v:SetNoDraw(true)
			v:ChatPrint(v:Nick() .. ", you are the new Dungeon Master.")
		else
			if v:Team() == 1 then
				SetPlayerTeam(v)
			elseif v:Team() == 2 then
				SetPlayerTeam(v)
			elseif v:Team() == 3 then
				SetPlayerTeam(v)
			end
			v:SetNoDraw(false)
			v:ChatPrint(newmaster:Nick() .. " is the new Dungeon Master.")
		end
	end
end
concommand.Add("dm_selectmaster", SelectMaster)

function SetCurrentQuest(name)
	for _,v in pairs(player.GetAll()) do
		v:SetNWString("CurrentQuest", name)
		v:SetNWBool("QuestComplete", false)
	end
end

function SetPlayerSquad(ply, squad)
	ply:SetNWString("SquadName", squad)
end
concommand.Add("dm_setsquad", function(ply, cmd, args)
	SetPlayerSquad(ply, args[0])
end)

function GetSquadMembers(ply)
	local squad = {}
	for k,v in pairs(player.GetAll()) do
		if v:GetNWString("SquadName") != "None" then
			if v:GetNWString("SquadName") == ply:GetNWString("SquadName") then
				squad[k] = v
			end
		end
	end
	return squad
end

function SetAllToSquad()
	for _,v in pairs(player.GetAll()) do
		v:SetNWString("SquadName", "Test")
	end
end
concommand.Add("dm_test_setsquadall", SetAllToSquad)

-- function SelectNewMaster()
--   local optedin = {}
--   for k,v in pairs(player.GetAll()) do
--     if v:GetNWBool("_MasterOptIn") then
--       optedin[k] == v
--     end
--   end

--   local newmaster = table.Random(optedin)

--   for _,v in pairs(player.GetAll()) do
--     if v != newmaster then
--       if v:Team() == 2 then
--         v:Spawn()
--         v:StripWeapons()
--         v:Give("weapon_fists")
--       elseif v:Team() == 1 then
--         v:SetTeam(2)
--         v:Spawn()
--         v:Give("weapon_fists")
--       elseif v:Team() == 3 then
--         v:SetTeam(2)
--         v:Spawn()
--         v:Give("weapon_fists")
--       end
--       v:SetNoDraw(false)
--     else
--       v:SetTeam(3)
--       v:Spawn()
--       v:SetMoveType(MOVETYPE_OBSERVER)
--       v:Spectate(OBS_MODE_ROAMING)
--       v:SetNoDraw(true)
--     end
--   end
-- end
-- concommand.Add("dm_selectnewmaster", SelectNewMaster)