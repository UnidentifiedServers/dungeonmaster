include('shared.lua')

surface.CreateFont('dmfont1', {
	font = "Roboto-Light",
	size = 24
})

surface.CreateFont('dmfont2', {
	font = "Roboto-Light",
	size = 18
})

function HideHud(name)
	local items = {"CHudHealth", "CHudBattery"}
	for _,v in pairs(items) do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideDefault", HideHud)

function DriveHUD()
	PlayerHUD()
	VehInfoHUD()
	VehMeterHUD()
end

function PlayerHUD()
	local ply = LocalPlayer()
	draw.RoundedBox(0, 0, 0, ScrW(), 30, Color(255, 255, 255, 120))
	if ply:GetNWEntity("curcar") != nil then
		draw.SimpleText(ply:Nick() .. " - " .. ply:GetNWEntity("curcar"):GetNWString("name"), "dmfont1", 5, 15, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	else
		draw.SimpleText(ply:Nick() .. " - No Car Registered", "dmfont1", 5, 15, Color(0, 0, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	draw.SimpleText("$1,345,252", "dmfont1", ScrW()-5, 15, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
end

function VehInfoHUD()
	local ply = LocalPlayer()
	//local trace = ply:GetEyeTrace()
	//local ent = trace.Entity

	local carents = ents.FindByClass("prop_vehicle_jeep")

	for _,ent in pairs(carents) do
		local pos = ent:GetPos():ToScreen()
		draw.SimpleText("Position: " .. tostring(ent:GetPos()) .. "; Angle: " .. tostring(ent:GetAngles()), "dmfont1", pos.x, pos.y-250, Color(0, 0, 0, 255))
		draw.SimpleText("Model: " .. tostring(ent:GetModel()), "dmfont1", pos.x, pos.y-220, Color(0, 0, 0, 255))
		if !ply:InVehicle() and ent:IsValid() and ply:GetPos():Distance(ent:GetPos()) <= 450 and ent:IsVehicle() then
			draw.RoundedBox(0, pos.x-185, pos.y-550, 360, 200, Color(40, 40, 40, 255))
			//draw.RoundedBox(0, pos.x-175, pos.y-550, 350, 200, Color(94, 94, 94, 255))
			//draw.RoundedBox(0, pos.x, pos.y-550, 350, 200, Color(255, 255, 255, 120))

			draw.RoundedBox(0, pos.x-182, pos.y-548, 6, 196, ent:GetColor())

			//=== Vehicle Name ===//
			draw.RoundedBox(0, pos.x-173, pos.y-548, 346, 30, Color(80, 80, 80, 255))
			draw.SimpleText(ent:GetNWString("name"), "dmfont1", pos.x-168, pos.y-547, Color(255, 255, 255, 255))

			//=== Acceleration ===//
			local accel = ent:GetNWInt("accel")
			local accelamt = Lerp((accel/10), 0, 200)

			draw.RoundedBox(0, pos.x-173, pos.y-516, 346, 40, Color(80, 80, 80, 255))
			draw.SimpleText("Acceleration", "dmfont2", pos.x-80, pos.y-497, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			draw.RoundedBox(0, pos.x-50, pos.y-497, 200, 5, Color(200, 200, 200, 255))
			draw.RoundedBox(0, pos.x-50, pos.y-497, accelamt, 5, Color(0, 153, 255, 255))

			//=== Top Speed ===//
			draw.RoundedBox(0, pos.x-173, pos.y-474, 346, 40, Color(80, 80, 80, 255))
			draw.SimpleText("Top Speed", "dmfont2", pos.x-80, pos.y-455, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			draw.RoundedBox(0, pos.x-50, pos.y-455, 200, 5, Color(200, 200, 200, 255))
			draw.RoundedBox(0, pos.x-50, pos.y-455, (ent:GetNWInt("speed")*10)*2, 5, Color(0, 153, 255, 255))

			//=== Registered To ===//
			draw.RoundedBox(0, pos.x-173, pos.y-432, 346, 80, Color(80, 80, 80, 255))
			draw.SimpleText("Registered to", "dmfont2", pos.x-80, pos.y-413, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			//draw.RoundedBox(0, pos.x-50, pos.y-413, 200, 5, Color(200, 200, 200, 255))
			//draw.RoundedBox(0, pos.x-50, pos.y-413, (ent:GetNWInt("speed")*10)*2, 5, Color(0, 153, 255, 255))
			draw.SimpleText(ent:GetNWString("status"), "dmfont1", pos.x-155, pos.y-382, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end
end

function VehMeterHUD()
	local ply = LocalPlayer()
	if ply:InVehicle() then
		local mph = (ply:InVehicle() and (ply:GetVehicle():GetVelocity():Length() / 17.6)) or (ply():GetVelocity():Length() / 17.6)
		draw.RoundedBox(0, 0, ScrH()-30, 400, 30, Color(255, 255, 255, 120))
		draw.SimpleText(math.Round(mph) .. " mph", "dmfont1", 85, ScrH()-15, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		draw.RoundedBox(0, 90, ScrH()-17, 300, 5, Color(80, 80, 80, 255))
		draw.RoundedBox(0, 90, ScrH()-17, mph, 5, Color(0, 153, 255, 255))
	end
end

hook.Add("HUDPaint", "DriveHUD", DriveHUD)