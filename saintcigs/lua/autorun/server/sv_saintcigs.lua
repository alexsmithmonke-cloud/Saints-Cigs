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

    if ply.ShotsTaken == nil then
        ply.ShotsTaken = 1
    else
        ply.ShotsTaken = ply.ShotsTaken + 1
    end
    if ply.ShotsTaken >= 3 then
        ply:Kill()
        return 
    end
    local id = ply:EntIndex() 
    local id2 = CurTime()
    local nameForOverdoseEffects = id.."ForOverdoseEffects"..id2
    local nameToCheckIfOverdose = id.."ToCheckIfOverdose"..id2
    local amountOfOverdoesDmg = {20, 50, 100}
    local shotstaken = ply.ShotsTaken
    local effectlength = 5
    timer.Create(nameForOverdoseEffects, 1, effectlength, function()
        if ply:Alive() then
            local dmg = (amountOfOverdoesDmg[shotstaken] / ply:GetMaxHealth()) * 100
            local dmgtotake = dmg / effectlength
            ply:ViewPunch(Angle(-1,0,0))
            ply:TakeDamage(dmgtotake)
            if ply:Health() < 1 then
                timer.Remove(nameToCheckIfOverdose)
                timer.Remove(nameForOverdoseEffects)
                ply:Kill()
            end
        else
            timer.Remove(nameToCheckIfOverdose)
            timer.Remove(nameForOverdoseEffects)
        end
    end)
    timer.Create(nameToCheckIfOverdose, effectlength, 1, function()
        if ply:Alive() then
            ply:SetRunSpeed(ply:GetRunSpeed() / 1.5)
        else
            timer.Remove(nameToCheckIfOverdose)
        end
    end)
end)

hook.Add("PlayerDeath", "ToResetValues", function(ply)
    local id = ply:EntIndex()
    local nameForAsthmaEffects = id.."ForAsthmaEffects"
    local nameForOverdoseEffects = id.."ForOverdoseEffects"
    local nameToCheckIfOverdose = id.."ToCheckIfOverdose"
    timer.Remove(nameToCheckIfOverdose)
    timer.Remove(nameForOverdoseEffects)
    timer.Remove(nameForAsthmaEffects)
    ply.HasAsthma = false
    ply.ShotsTaken = 0
end)
