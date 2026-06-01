SWEP.PrintName = "Asthma cure"
SWEP.Author = "SinningSaint"
SWEP.Purpose = "To fix your mistakes and do them once more."
SWEP.Category = "Sinful - Habits"
SWEP.DrawCrosshair = false 
SWEP.UseHands = true


SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.DrawAmmo = true

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
    self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    if owner.HasAsthma then
        owner.HasAsthma = false
        owner:SetRunSpeed(owner:GetRunSpeed() * 1.5)
        owner:ChatPrint("God breathing feels easier!")
    else
        hook.Call("PlayerIsOverDosing", nill, owner)
        if owner.ShotsTaken == nil then
            owner.ShotsTaken = 1
        else
            owner.ShotsTaken = owner.ShotsTaken + 1
        end
    end
    owner:StripWeapon("asthmacure")
end