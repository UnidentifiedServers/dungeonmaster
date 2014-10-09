AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function GM:PlayerSpawn(ply)
    self.BaseClass:PlayerSpawn(ply)
    ply:StripWeapons()
    if ply:Team() == 2 then
    	ply:Give("weapon_fists")
    end
end

function GM:PlayerLoadout(ply)
end

function GM:PlayerInitialSpawn(ply)
	print('Player ' .. ply:Nick() .. " has joined the game.")
	ply:SetTeam(1)
end

function GM:PlayerDisconnected(ply)
	for _,pl in pairs(player.GetAll()) do
		pl:ChatPrint(ply:Nick() .. " disconnected.")
	end
end

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
			v:SetMoveType(MOVETYPE_PUSH)
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

// function SelectNewMaster()
//   local optedin = {}
//   for k,v in pairs(player.GetAll()) do
//     if v:GetNWBool("_MasterOptIn") then
//       optedin[k] == v
//     end
//   end

//   local newmaster = table.Random(optedin)

//   for _,v in pairs(player.GetAll()) do
//     if v != newmaster then
//       if v:Team() == 2 then
//         v:Spawn()
//         v:StripWeapons()
//         v:Give("weapon_fists")
//       elseif v:Team() == 1 then
//         v:SetTeam(2)
//         v:Spawn()
//         v:Give("weapon_fists")
//       elseif v:Team() == 3 then
//         v:SetTeam(2)
//         v:Spawn()
//         v:Give("weapon_fists")
//       end
//       v:SetNoDraw(false)
//     else
//       v:SetTeam(3)
//       v:Spawn()
//       v:SetMoveType(MOVETYPE_OBSERVER)
//       v:Spectate(OBS_MODE_ROAMING)
//       v:SetNoDraw(true)
//     end
//   end
// end
// concommand.Add("dm_selectnewmaster", SelectNewMaster)