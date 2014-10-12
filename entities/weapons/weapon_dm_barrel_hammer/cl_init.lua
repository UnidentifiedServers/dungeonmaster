include('shared.lua')

SWEP.PrintName = "Barrel Hammer"
SWEP.Slot = 3
SWEP.SlotPos	= 1

// Override this in your SWEP to set the icon in the weapon selection
if (file.Exists("../materials/weapons/weapon_mad_deagle.vmt", "GAME")) then
SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_mad_deagle")
end