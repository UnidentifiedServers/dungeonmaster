GM.Name = "Dungeon Master"
GM.Author = "Identity_Kleptomaniac and Kurone"
GM.Email = "contact@dmerle.tk"
GM.Website = "http://dmerle.tk"

DeriveGamemode('sandbox')

team.SetUp(1, "Spectator", Color(255, 255, 255, 255))
team.SetUp(2, "Player", Color(0, 0, 255, 255))
team.SetUp(3, "Dungeon Master", Color(255, 0, 0, 255))
//team.SetUp(4, "AFK", Color(0, 0, 0, 255))

function GM:Initialize()
  print("[DM] Initializing gamemode " .. GM.Name)
  print("[DM] Created by " .. GM.Author)
end