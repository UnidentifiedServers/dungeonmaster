GM.Name = "Dungeon Master"
GM.Author = "Identity_Kleptomaniac and Kurone"
GM.Email = "contact@dmerle.tk"
GM.Website = "http:--dmerle.tk"

DeriveGamemode('sandbox')

team.SetUp(1, "Spectator", Color(255, 255, 255, 255))
team.SetUp(2, "Player", Color(0, 0, 255, 255))
team.SetUp(3, "Dungeon Master", Color(255, 0, 0, 255))

-- InventoryItems = {}

-- InventoryItems["badhammer"] = {
--   name = "Barrel Hammer",
--   desc = "A good starting weapon. It has a sawblade stuck in it, I guess that is good.",
--   ent = "weapon_dm_barrel_hammer"
-- }

-- function GM:Initialize()
--   print("[[-----------------------------]]")
--   print("[[--- Dungeon Master v1.0.1 ---]]")
--   print("[[-----------------------------]]")
--   print("[[---      Created by:      ---]]")
--   print("[[---                       ---]]")
--   print("[[---      Kurone and       ---]]")
--   print("[[--- Identity_Kleptomaniac ---]]")
--   print("[[-----------------------------]]")
--   print("[[---        Visit us       ---]]")
--   print("[[---  at http:--dmerle.tk  ---]]")
--   print("[[-----------------------------]]")
-- end

function GM:Initialize()
  print("Gamemode Initialized.")
end