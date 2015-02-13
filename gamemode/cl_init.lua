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

function draw.OutlinedBox( x, y, w, h, thickness, clr )
	surface.SetDrawColor( clr )
	for i=0, thickness - 1 do
		surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
	end
end

function draw.Circle( x, y, radius, seg, r, g, b, a)
	surface.SetDrawColor( r, g, b, a )
	
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is need for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

function PlayerHUD(ply)
  draw.RoundedBox(0, 0, 0, ScrW(), 30, Color(0, 0, 0, 200))
  
  // Info Graphic
  local poot = 150
  //draw.RoundedBox(1, 25, ScrH() - poot - 25, 300, poot, Color(0, 0, 0, 200))
  draw.NoTexture()
  
  // Health display
  local HP = ply:Health()
  
  // Circle health
  local circ = 100
  draw.Circle(circ, ScrH() - poot / 1.5, 75, HP / 5 + 5, 232, 12, 30, 200)
  draw.SimpleText( HP, "dmfont1", circ, ScrH() - poot / 1.5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(0, 0, 0, 255))
  
  // Bar health
  //draw.OutlinedBox(175 - HP * 1.25, ScrH() - poot, HP * 2.5, 20, 25, Color(0, 0, 0, 255))
  //draw.RoundedBox(1, 175 - HP * 1.25, ScrH() - poot, HP * 2.5, 20, Color(232, 12, 30, 255))
  //draw.SimpleTextOutlined( HP, "dmfont1", 175, ScrH() - poot + 9, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1.5, Color(0, 0, 0, 255))
  
  // Stamina Display
  local stam = 100
  for j,v in pairs(player.GetAll()) do
	stam = v:GetNWInt("stamina", 100)
  end
  //draw.OutlinedBox(175 - stam * 1.25, ScrH() - poot + 75, stam * 2.5, 20, 25, Color(0, 0, 0, 255))
  //draw.RoundedBox(1, 175 - stam * 1.25, ScrH() - poot + 75, stam * 2.5, 20, Color(12, 232, 30, 255))
  //draw.SimpleTextOutlined( stam, "dmfont1", 175, ScrH() - poot + 84, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1.5, Color(0, 0, 0, 255))
  
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

function HealthSlider()
	
	
	local frame = vgui.Create("DFrame")
	frame:SetSize(200, 100)
    frame:SetPos(ScrW()/2 - 100, ScrH()/2 - 50)
    frame:SetTitle("Health Debug Tool")
    frame:ShowCloseButton(true)
	frame:SetDraggable(false)
    frame:MakePopup()
	
	local slider = vgui.Create("Slider", frame)
	slider:SetWide(100)
	slider:SetMax(100)
	slider:SetMin(0)
	slider:SetDecimals(0)
	slider:SetPos(ScrW()/2-75, (ScrH()/2))
	slider:SetSize(175, 20)
	slider:MakePopup()
	slider.OnValueChanged = function(panel, value)
		RunConsoleCommand("dm_sethealth", value)
	end
end

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
usermessage.Hook("dm_health", HealthSlider)