---- All credits to sol https://discord.gg/PY9Vj8CrPf
Config = {}

-- פקודה להדלקה וכיבוי
Config.Command = 'tag'

-- הגדרות לכל דרגה בנפרד (ניתן להוסיף עוד דרגות פה)
-- הנהלה = הלנהה | צוות = תווצ
Config.Tags = {
    ['god'] = {
        Text = "~r~[ הלנהה ]~w~\nשנעי עירפיש ןקחש - טיס ןימדא",
        MarkerColor = { r = 255, g = 0, b = 0, a = 120 }
    },
    ['admin'] = {
        Text = "~b~[ תווצ ]~w~\nשנעי עירפיש ןקחש - טיס ןימדא",
        MarkerColor = { r = 0, g = 150, b = 255, a = 120 }
    },
    ['mod'] = {
        Text = "~g~[ דומ ]~w~\nשנעי עירפיש ןקחש - טיס ןימדא",
        MarkerColor = { r = 0, g = 255, b = 0, a = 120 }
    }
}

Config.DrawDistance = 20.0 -- מאיזה מרחק שחקנים אחרים יוכלו לראות את הטקסט
Config.TextScale = 0.55 -- גודל הטקסט

-- עיצוב טקסט מתקדם כדי שייראה איכותי מול השמש/שמיים
Config.TextColor = { r = 255, g = 255, b = 255, a = 255 }
Config.DropShadow = true
Config.Outline = true

-- תוספות לאיכות (זיהוי קל יותר לאדמין)
Config.EnableMarker = true -- האם לשים עיגול זוהר מתחת לאדמין כשהוא עם התג
Config.MarkerType = 1 -- 1 = עיגול על הרצפה
Config.MarkerScale = { x = 1.2, y = 1.2, z = 0.2 } -- גודל המרקר
