local Player = game:GetService("Players").LocalPlayer

local mouseClick = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Arroz-con/AdoptMe/main/Modules/MouseClick.lua")))()

local NewsAppConnection

local Module = {}

--// Main Adopt me Screen (Play! Button)
NewsAppConnection = Player.PlayerGui.NewsApp:GetPropertyChangedSignal("Enabled"):Connect(function()
    if Player.PlayerGui.NewsApp.Enabled then
        local AbsPlay = Player.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Contents.PlayButton
        mouseClick.ClickGuiButton(AbsPlay)
        --firesignal(Player.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Contents.PlayButton.MouseButton1Click)
        NewsAppConnection:Disconnect()
    end
end)

if Player.PlayerGui.NewsApp.Enabled then
    local AbsPlay = Player.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Contents.PlayButton
    mouseClick.ClickGuiButton(AbsPlay)
    --firesignal(Player.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Contents.PlayButton.MouseButton1Click)
    NewsAppConnection:Disconnect()
end

return Module