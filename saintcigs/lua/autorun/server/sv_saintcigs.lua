AddCSLuaFile()


hook.Add("PlayerHasContractedAsthma", "Saint'sAsthma", function(ply)
    if ply.HasAsthma then return end
    ply.HasAsthma = true 
    ply:SetRunSpeed(ply:GetRunSpeed() / 1.5)
    local id = ply:EntIndex()
    local nameForAsthmaEffects = id.."ForAsthmaEffects"
    local timetostarteffects = 10
    timer.Create(nameForAsthmaEffects, timetostarteffects, 0, function()
        if ply.HasAsthma then
            ply:ChatPrint("*Cough*")
            ply:EmitSound("scp_294_redux/cough/cough_2.wav", 75,100,1)
            timetostarteffects =  math.random(30,90)
        else
            timer.Remove(nameForAsthmaEffects)
        end
    end)
end)

hook.Add("PlayerIsOverDosing", "Saints Overdose", function(ply)

    ply:ChatPrint("My breathing feels so clear... so clear!")
    ply:SetRunSpeed(ply:GetRunSpeed() * 1.5)

    local id = ply:EntIndex()
    local nameForOverdoseEffects = id.."ForOverdoseEffects"
    timer.Create(nameForOverdoseEffects, 20, 1, function()
        ply:SetRunSpeed(ply:GetRunSpeed() / 1.5)
    end)
    timer.Create(nameForOverdoseEffects, 1, 20, function()
        ply:ViewPunch(Angle(-10,0,0))
        ply:SetHealth(ply:Health() - 2)
    end)



end)

hook.Add("PlayerDeath", "ToResetValues", function(ply)
    local id = ply:EntIndex()
    local nameForAsthmaEffects = id.."ForAsthmaEffects"
    local nameForOverdoseEffects = id.."ForOverdoseEffects"
    timer.Remove(nameForOverdoseEffects)
    timer.Remove(nameForAsthmaEffects)
    ply.HasAsthma = false
    ply.ShotsTaken = 0
end)