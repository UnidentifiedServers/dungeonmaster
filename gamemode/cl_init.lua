include('shared.lua')

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
end

function DrawPropHalo(ply)
  if ply:Team() == 2 then
    local trace = ply:GetEyeTrace()

    if IsValid(trace.Entity) and trace.Entity:GetClass() == "prop_physics" then
      hook.Add("PreDrawHalos", "DrawPropHalos", function()
        halo.Add({trace.Entity}, Color(255, 255, 255), 2, 2, 1)
      end)
    end
  end
end

hook.Add("HUDPaint", "ShowHUD", function()
	local ply = LocalPlayer()
	PlayerHUD(ply)
  DrawPropHalo(ply)

	// if DM.Config.Game.debug then
	// 	draw.RoundedBox(0, 0, ScrH()-30, 150, 30, Color(0, 0, 0, 200))
 //    draw.SimpleText("Debug Mode Enabled", "dmfont2", 5, ScrH()-15, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	// end
end)