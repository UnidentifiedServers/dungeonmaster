include('shared.lua')
//include('player/inventory.lua')

function GM:SpawnMenuEnabled()
  return false
end

surface.CreateFont('dmfont1', {
  font = "Roboto-Light",
  size = 24
})

surface.CreateFont('dmfont2', {
  font = "Roboto-Light",
  size = 18
})

hook.Add("HUDShouldDraw", "HideDefault", function(name)
  local items = {"CHudHealth", "CHudBattery"}
  for _,v in pairs(items) do
    if name == v then return false end
  end
end)

function PlayerHUD(ply)
  draw.RoundedBox(0, 0, 0, ScrW(), 30, Color(0, 0, 0, 200))

  // Left Side of Status Bar
  draw.SimpleText(team.GetName(ply:Team()), "dmfont1", 5, 15, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

  // Right Side of Status Bar
  draw.SimpleText("Players Left: " .. tostring(team.NumPlayers(2)), "dmfont1", ScrW()-5, 15, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

  // Draw Weapon Information
  DrawWeaponInfo(ply)
end

function DrawWeaponInfo(ply)
  local wep = ply:GetActiveWeapon()
  if IsValid(wep) and wep.IsDMWeapon then
    draw.SimpleText(wep:GetPrintName() .. " (" .. wep:GetNWInt("durability") .. ")", "dmfont1", ScrW()/2, 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  end
end

function DrawSquadInfo(ply)
  draw.RoundedBox(0, 0, 30, 150, 60, Color(0, 0, 0, 200))

  // SquadName Title
  draw.SimpleText(ply:GetNWString("SquadName") .. " Squad", "dmfont1", 5, 45, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

  // Display LocalPlayer First
  draw.SimpleText(ply:Nick(), "dmfont2", 15, 60, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

hook.Add("HUDPaint", "ShowHUD", function()
  local ply = LocalPlayer()
  PlayerHUD(ply)
  if ply:GetNWString("SquadName") != "None" then
    DrawSquadInfo(ply)
  end
  /* Disabled Functions
  ---------------------
  -------------------*/
end)



function ShowInventory()
  local ply = LocalPlayer()

  local inv = vgui.Create("DFrame")
  inv:SetSize(300, 600)
  inv:SetPos(ScrW()-350, (ScrH()/2)-300)
  inv:SetTitle("Inventory")
  inv:SetVisible(true)
  inv:SetDraggable(true)
  inv:ShowCloseButton(true)
  inv:MakePopup()

  local invlist = vgui.Create("DListView")
  invlist:SetParent(inv)
  invlist:SetPos(2, 25)
  invlist:SetSize(296, 573)
  invlist:SetMultiSelect(false)
  invlist:AddColumn("Item Name")
  invlist:AddColumn("Description")

  for _,v in pairs(ply:GetInventoryItems()) do
    invlist:AddLine(v.name, v.desc)
  end
end
usermessage.Hook("dm_inventory", ShowInventory)