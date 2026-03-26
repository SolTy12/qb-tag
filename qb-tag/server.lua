---- All credits to sol https://discord.gg/PY9Vj8CrPf
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add(Config.Command, 'הדלק/כבה תג אדמין', {}, false, function(source, args)
    local src = source
    local qbPlayer = QBCore.Functions.GetPlayer(src)
    
    if qbPlayer then
        local currentState = Player(src).state.adminTag or false
        local newState = not currentState
        
        if newState then
            -- קבלת דרגות השחקן ישירות מקיובי כדי למנוע טעויות מובנות של HasPermission בגרסאות חדשות
            local playerPerms = QBCore.Functions.GetPermission(src)
            local rankPriority = { 'god', 'admin', 'mod' }
            local appliedTag = false
            
            -- עקר הבדיקה למצוא בדיוק את הדרגה שרשומה לשחקן (דרך טבלה או סטרינג) למנוע מצב שאדמין מקבל god
            for _, rank in ipairs(rankPriority) do
                if Config.Tags[rank] then
                    local isRank = false
                    if type(playerPerms) == "table" and playerPerms[rank] then isRank = true
                    elseif playerPerms == rank then isRank = true
                    elseif QBCore.Functions.HasPermission(src, rank) then isRank = true
                    elseif IsPlayerAceAllowed(src, 'group.' .. rank) then isRank = true end
                    
                    if isRank then
                        appliedTag = rank
                        break
                    end
                end
            end
            
            -- במידה והוספנו לקונפיג דרגה מיוחדת אישית (נבדוק אותה אם בסדר העדיפות חזר שלילי)
            if not appliedTag then
                for rank, data in pairs(Config.Tags) do
                    if rank ~= 'god' and rank ~= 'admin' and rank ~= 'mod' then
                        local isRank = false
                        if type(playerPerms) == "table" and playerPerms[rank] then isRank = true
                        elseif playerPerms == rank then isRank = true
                        elseif QBCore.Functions.HasPermission(src, rank) then isRank = true
                        elseif IsPlayerAceAllowed(src, 'group.' .. rank) then isRank = true end
                        
                        if isRank then
                            appliedTag = rank
                            break
                        end
                    end
                end
            end
            
            -- גיבוי חכם במיוחד: אם אין שום התאמה לחוקים אבל לשחקן עדיין יש גישת אדמין מלאה בשרת (Ace)
            if not appliedTag and IsPlayerAceAllowed(src, 'command') then
                if Config.Tags['god'] then appliedTag = 'god'
                elseif Config.Tags['admin'] then appliedTag = 'admin'
                else appliedTag = next(Config.Tags) end
            end
            
            if appliedTag then
                Player(src).state:set('adminTag', appliedTag, true)
                TriggerClientEvent('QBCore:Notify', src, 'תג הופעל בהצלחה (' .. appliedTag .. ')', 'success')
            else
                -- תיקון התצוגה של הטבלה למקרה שאין הרשאות כלל
                local permStr = "None"
                if type(playerPerms) == 'string' then permStr = playerPerms 
                elseif type(playerPerms) == 'table' then
                    permStr = next(playerPerms) and json.encode(playerPerms) or "Empty (Table)"
                end
                TriggerClientEvent('QBCore:Notify', src, 'דרגתך: "' .. permStr .. '". גישתך חסומה בשרת.', 'error', 7500)
            end
        else
            -- כיבוי התג
            Player(src).state:set('adminTag', false, true)
            TriggerClientEvent('QBCore:Notify', src, 'תג כובה', 'error')
        end
    end
end)

-- פקודה למפתחים (למטרת בדיקה על סמך הקונפיגורציה בלבד)
QBCore.Commands.Add('testtag', 'כפיית תג (מצב בדיקה)', {{name='rank', help='god / admin / mod'}}, false, function(source, args)
    local src = source
    local rank = args[1]
    
    if rank and Config.Tags[rank] then
        Player(src).state:set('adminTag', rank, true)
        TriggerClientEvent('QBCore:Notify', src, 'כפית הרצת תג מסוג: ' .. rank .. ' (מצב בדיקה)', 'success')
    else
        Player(src).state:set('adminTag', false, true)
        TriggerClientEvent('QBCore:Notify', src, 'התג כובה למצב פיתוח (אנא ציין דרגה תקינה)', 'error')
    end
end)

