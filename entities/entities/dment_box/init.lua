AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
  if (!tr.Hit) then return end
  local SpawnPos = tr.HitPos + tr.HitNormal * 25
  local ent = ents.Create(self.classname)
  ent:SetPos(SpawnPos)
  ent:Spawn()
  ent:Activate()
  ent:SetUseType(SIMPLE_USE)
  if self.ShouldSetOwner then
    ent.Owner = ply
  end
  return ent
end

function ENT:Initialize()
  self.Entity:SetModel(self.model)
  self.Entity:PhysicsInit(SOLID_VPHYSICS)
  self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
  self.Entity:SetSolid(SOLID_VPHYSICS)
  local phys = self.Entity:GetPhysicsObject()
  if (phys:IsValid()) then
    phys:Wake()
  end
end

function ENT:OnTakeDamage( dmginfo )
  self.Entity:TakePhysicsDamage( dmginfo )
end

function ENT:Use( activator, caller )
  if activator:IsPlayer() and activator:Team() == 2 then
    activator:PickupObject(self)
  end
end

-----------
-- Think --
-----------
function ENT:Think()

end

-----------
-- Touch --
-----------
function ENT:Touch(ent)
	ent:SetPos(self:GetPos()+Vector(0, 0, 30))
end

--------------------
-- PhysicsCollide -- 
--------------------
function ENT:PhysicsCollide( data, physobj )
  return false
end