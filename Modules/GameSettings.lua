local UserGameSettings = UserSettings():GetService("UserGameSettings")

local Module = {}

function Module.Settings()
    UserGameSettings.GraphicsQualityLevel = 1
    UserGameSettings.MasterVolume = 0
end

return Module
