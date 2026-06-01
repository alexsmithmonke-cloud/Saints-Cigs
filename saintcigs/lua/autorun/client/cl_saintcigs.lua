AddCSLuaFile()
if CLIENT then
    hook.Add("RenderScreenspaceEffects", "CigEffects", function()
        local ply = LocalPlayer()
        local CigBlurTime = ply:GetNW2Float("CigBlur", 0)

        if CigBlurTime > CurTime() then

            DrawMotionBlur(0.4, 0.8, 0.01)
        end
        
    end)
end