game.AddAmmoType( {
name = "saints_cig_prim_ammo",
dmgtype = DMG_BULLET,
tracer = TRACER_LINE,
plydmg = 0,
npcdmg = 0,
force = 1,
minsplash = 1,
maxsplash = 1
} )

SWEP.PrintName = "Cig"
SWEP.Author = "SinningSaint"
SWEP.Purpose = "To take things off your mind."
SWEP.Category = "Sinful - Habits"
SWEP.DrawCrosshair = false 
SWEP.UseHands = true


SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "saints_cig_prim_ammo"

SWEP.DrawAmmo = true

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModel = "models/weapons/stalker/cigarette/v_cigarettestandalone.mdl"
SWEP.WorldModel = "models/weapons/stalker/cigarette/w_cigarettestandalone.mdl"
SWEP.ViewModelFOV = 90

function SWEP:Initialize()
    self:SetHoldType("pistol")
end 

function SWEP:Deploy()
    self:SetNextPrimaryFire(CurTime())
end

function SWEP:PrimaryAttack()
    local owner = self:GetOwner()
    if owner:GetAmmoCount(self.Primary.Ammo) > 0 then
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
        self:SetNextPrimaryFire(CurTime() + 36) -- 36 becuase that is how long it takes for the animation to finish
        self:CigEffects(owner,self)
        self:TakePrimaryAmmo(1)
    end
end

function SWEP:SecondaryAttack()
    local owner = self:GetOwner()
    owner:SetAmmo(0, "saints_cig_prim_ammo")
    owner:StripWeapon("cig")
end

function SWEP:CigEffects(ply, self)
    local id = self:EntIndex()
    local nameForCigEffects = id.."ForCigEffects"
    local nameIsCigActiveWeapon = id.."IsCigActiveWeapon"
    timer.Create(nameIsCigActiveWeapon, 0.1, 0, function()
        if ply:GetActiveWeapon() != self then
            ply:SetNW2Float("CigBlur", 0)
            timer.Remove(nameForCigEffects)
            timer.Remove(nameIsCigActiveWeapon)
        end
    end)
    timer.Create(nameForCigEffects, 8, 1, function()
        ply:ChatPrint("You inhale the smoke, it calms you for the moment.")
        timer.Create(nameForCigEffects, 5, 1, function()
            ply:SetNW2Float("CigBlur", CurTime() + 20)
            timer.Create(nameForCigEffects, 5, 1, function()
                local asthmachance = math.random(0,100)
                if asthmachance == 1 then
                    ply:ChatPrint("My airway feels tight... Maybe I should see a doctor...")
                    hook.Call("PlayerHasContractedAsthma",nil, ply)
                end
                timer.Create(nameForCigEffects, 18, 1, function()
                    ply:SetNW2Float("CigBlur", 0)
                end)
            end)
        end)
    end)
end
