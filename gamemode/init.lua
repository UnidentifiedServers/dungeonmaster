AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

/*----------------------------------------+
| GM:PlayerSpawn                          |
|-----------------------------------------|
|                                         |
| Arguments: Player ply                   |
| Description:                            |
|   Runs when a Player (re)spawns.        |
+----------------------------------------*/
function GM:PlayerSpawn(ply)
    self.BaseClass:PlayerSpawn(ply)
    ply:StripWeapons()
end

/*----------------------------------------+
| GM:PlayerLoadout                        |
|-----------------------------------------|
|                                         |
| Arguments: Player ply                   |
| Description:                            |
|   Runs when a Player (re)spawns.        |
+----------------------------------------*/
function GM:PlayerLoadout(ply)
end

/*----------------------------------------+
| GM:PlayerInitialSpawn                   |
|-----------------------------------------|
|                                         |
| Arguments: Player ply                   |
| Description:                            |
|   Runs when a Player joins the server.  |
+----------------------------------------*/
function GM:PlayerInitialSpawn(ply)
	print('Player ' .. ply:Nick() .. " has joined the game.")
	ply:SetTeam(1)
  ply:SetNWBool("_MasterOptIn", true)
end

/*----------------------------------------+
| GM:PlayerDisconnect                     |
|-----------------------------------------|
|                                         |
| Arguments: Player ply                   |
| Description:                            |
|   Runs when a Player disconnects        |
|   from the active server.               |
+----------------------------------------*/
function GM:PlayerDisconnected(ply)
end

/*----------------------------------------+
| GM:PlayerUse                            |
|-----------------------------------------|
|                                         |
| Arguments: Player ply, Entity ent       |
| Description:                            |
|   Runs when a Player presses their      |
|   use key on an Entity.                 |
+----------------------------------------*/
function GM:PlayerUse(ply, ent)
end

/*----------------------------------------+
| SelectNewMaster                         |
|-----------------------------------------|
|                                         |
| Arguments: None                         |
| Returns: Player newmaster               |
| Description:                            |
|   Selects a new Master from the         |
|   active server for Players who         |
|   opt-in to be selected.                |
+----------------------------------------*/
function SelectNewMaster()
  local optedin = {}
  for k,v in pairs(player.GetAll()) do
    if v:GetNWBool("_MasterOptIn") then
      optedin[k] == v
    end
  end

  local newmaster = table.Random(optedin)

  for _,v in pairs(player.GetAll()) do
    if v != newmaster then
      if v:Team() == 2 then
        v:Spawn()
        v:StripWeapons()
        v:Give("weapon_fists")
      elseif v:Team() == 1 then
        v:SetTeam(2)
        v:Spawn()
        v:Give("weapon_fists")
      elseif v:Team() == 3 then
        v:SetTeam(2)
        v:Spawn()
        v:Give("weapon_fists")
      end
      v:SetNoDraw(false)
    else
      v:SetTeam(3)
      v:Spawn()
      v:SetMoveType(MOVETYPE_OBSERVER)
      v:Spectate(OBS_MODE_ROAMING)
      v:SetNoDraw(true)
    end
  end
end
concommand.Add("dm_selectnewmaster", SelectNewMaster)