local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()


local Window = WindUI:CreateWindow({
    Title = "Crystal Hub",
    Icon = "door-open",
    Author = "hac4er",
    Folder = "CrystalHub",
    Theme = "Dark",
    User = {
        Enabled = true,
        Anonymous = true,
        Callback = function()
            print("clicked")
        end,
    },
    KeySystem = { -- <- ↓ remove this all, if you dont neet the key system
        Key = { "giring", "tilio" },
        Note = "Crystals Key System.",
        -- Thumbnail = {
        --     Image = "rbxassetid://",
        --     Title = "Thumbnail",
        -- },
        URL = "your link to get key (like linkvertise, platoboost, etc.)",
        SaveKey = true, -- saves key and auto load it.
    },
})

Window:EditOpenButton({
    Title = "Open Crystal Hub",
    Icon = "door-open",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    OnlyMobile = false, -- pc and mobile
})

local MainSection = Window:Section({
    Title = "Main",
    Icon = "house",
    Opened = true,
})

local MainTab = MainSection:Tab({ -- Create tab in section 'MainSection'
    Title = "Main Tab",
    Icon = "house",
    Locked = false,
})

Window:SelectTab(1) -- Select Number of Tab

local Input = MainTab:Slider({ -- SLIDER!1!!!!!!1!1!1!1!1!
    Title = "Input Speed Value",
    Desc = "16-500 for the speed.",
    Value = {
        Min = 16,
        Max = 500,
        Default = 16,
    },
    Callback = function(input) 
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(input) or 16
    end
})


local Input = MainTab:Slider({ -- SLIDER!1!!!!!!1!1!1!1!1!
    Title = "Input JumpPower Value",
    Desc = "50-500 for the jumppower.",
    Value = {
        Min = 50,
        Max = 500,
        Default = 50,
    },
    Callback = function(input) 
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(input) or 50
    end
})
