---- All credits to sol https://discord.gg/PY9Vj8CrPf
local QBCore = exports['qb-core']:GetCoreObject()

-- טעינת הפונט בעברית מהסקריפט החיצוני
local customFontId = nil
CreateThread(function()
    RegisterFontFile('out')
    customFontId = RegisterFontId('MyFont')
end)

-- פונקציה חכמה לציור טקסט תלת ממדי באיכות גבוהה
local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vec3(px, py, pz) - vec3(x, y, z))

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * Config.TextScale

    if onScreen then
        SetTextScale(0.0 * scale, 1.1 * scale)
        SetTextFont(customFontId or Config.Font)
        SetTextProportional(1)
        SetTextColour(Config.TextColor.r, Config.TextColor.g, Config.TextColor.b, Config.TextColor.a)
        
        -- הוספת צל וקו מתאר כדי שהטקסט יהיה קריא בכל מצב תאורה
        if Config.DropShadow then
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(2, 0, 0, 0, 150)
            SetTextDropShadow()
        end
        if Config.Outline then
            SetTextOutline()
        end
        
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

CreateThread(function()
    while true do
        local sleep = 1000
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)

        -- מעבר על כל השחקנים המחוברים
        for _, player in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(player)
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(plyCoords - targetCoords)

            -- State Bags משיכת נתונים מ 
            -- זו הדרך הכי טובה כיום לסנכרן דברים בלי להעמיס על השרת
            local playerId = GetPlayerServerId(player)
            local hasTag = Player(playerId).state.adminTag

            if hasTag and Config.Tags[hasTag] and distance <= Config.DrawDistance then
                sleep = 0
                
                local tagData = Config.Tags[hasTag]
                
                -- ציור הטקסט קצת מעל הראש
                DrawText3D(targetCoords.x, targetCoords.y, targetCoords.z + 1.1, tagData.Text)

                -- תוספת המרקר מתחת לרגליים נותנת תחושה מאוד נקייה
                if Config.EnableMarker then
                    DrawMarker(
                        Config.MarkerType, 
                        targetCoords.x, targetCoords.y, targetCoords.z - 0.95, 
                        0.0, 0.0, 0.0, 
                        0.0, 0.0, 0.0, 
                        Config.MarkerScale.x, Config.MarkerScale.y, Config.MarkerScale.z, 
                        tagData.MarkerColor.r, tagData.MarkerColor.g, tagData.MarkerColor.b, tagData.MarkerColor.a, 
                        false, true, 2, false, nil, nil, false
                    )
                end
            end
        end

        Wait(sleep)
    end
end)
