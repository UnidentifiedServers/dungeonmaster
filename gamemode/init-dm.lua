AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function GM:PlayerSpawn(ply)
    self.BaseClass:PlayerSpawn(ply)
    ply:StripWeapons()
end

function GM:PlayerLoadout(ply)
end

function GM:PlayerInitialSpawn(ply)
	print('Player ' .. ply:Nick() .. " has joined the game.")
end

function GM:PlayerDisconnected(ply)
	for _,pl in pairs(player.GetAll()) do
		pl:ChatPrint(ply:Nick() .. " disconnected.")
	end

	print(ply:Nick() .. " disconnected. Removing all registered cars from map.")

	for _,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if v:GetNWString("owner") == ply:Nick() then
			v:Remove()
		end
	end
end

hook.Add("PlayerSpawnedVehicle", "DMVehSpawn", function(ply, ent)
	ply:ChatPrint("Spawned a " .. ent:GetClass())
	//ply:EnterVehicle(ent)
	ent:SetNWString("name", "Vehicle_Name")
	ent:SetColor(Color(math.Rand(0, 255), math.Rand(0, 255), math.Rand(0, 255), 255))
	ent:SetNWInt("accel", math.Rand(0, 10))
	ent:SetNWInt("speed", math.Rand(0, 10))
	ent:SetNWString("status", ply:Nick())
end)

function GM:ShowTeam(ply)
	local trace = ply:GetEyeTrace()
	local ent = trace.Entity
	if trace.HitNonWorld and ent:IsValid() and ent:IsVehicle() then 
		if ent:GetNWString("status") == "Unregistered" then
			ent:SetNWString("status", ply:Nick())
			ply:ChatPrint("[DriveMod] You now own this vehicle. Press [USE] to drive it!")
			if ply:GetNWEntity("curcar") == nil then
				ply:SetNWEntity("curcar", ent)
			else
				//ply:GetNWEntity("curcar"):Remove()
				ply:SetNWEntity("curcar", ent)
			end
		end
	end
end

function GM:PlayerUse(ply, ent)
	if ent:IsValid() and ent:IsVehicle() then
		if ent:GetNWString("status") == "Unregistered" then
			ply:ChatPrint("[DriveMod] You must register this car first before driving it. Press [F2] to register it!")
			return false
		elseif ent:GetNWString("status") != ply:Nick() then
			ply:ChatPrint("[DriveMod] This vehicle is not registered to you!")
			return false
		else
			return true
		end
	end
end

concommand.Add("dm_changecolor", function(ply, cmd, args)
	if DriveMod.Config.Game.debug then
		if ply:InVehicle() and ply:GetVehicle():IsValid() then
			ply:GetVehicle():SetColor(Color(args[1], args[2], args[3], 255))
		end
	else
		ply:ChatPrint("[DriveMod] Debug mode is not enabled, ignoring.")
	end
end)

concommand.Add("dm_changename", function(ply, cmd, args)
	if DriveMod.Config.Game.debug then
		if ply:InVehicle() and ply:GetVehicle():IsValid() then
			ply:GetVehicle():SetNWString("name", args[1])
		end
	else
		ply:ChatPrint("[DriveMod] Debug mode is not enabled, ignoring.")
	end
end)

concommand.Add("dm_spawncar", function(ply, cmd, args)
	if ply:IsAdmin() or ply:IsSuperAdmin() then
		local ent = ents.Create("prop_vehicle_jeep")
		ent:SetPos(ply:GetEyeTrace().HitPos)
		ent:SetColor(Color(math.Rand(0, 255), math.Rand(0, 255), math.Rand(0, 255), 255))
		ent:SetModel("models/tdmcars/" .. args[1] .. ".mdl")
		ent:SetKeyValue("vehiclescript", "scripts/vehicles/tdmcars/" .. args[2] .. ".txt")
		ent:SetNWInt("accel", args[3])
		ent:SetNWInt("speed", args[4])
		ent:SetNWString("name", args[5])
		ent:SetNWString("status", "Unregistered")
		ent:Spawn()
		ply:ChatPrint("[DriveMod] " .. args[5] .. " has been spawned at " .. ply:GetEyeTrace().HitPos .. ".")
	else
		ply:ChatPrint("[DriveMod] You cannot spawn vehicles!")
	end
end)