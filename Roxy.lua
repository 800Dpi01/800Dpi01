	
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/lelo0002/hai../refs/heads/main/roxylinoria.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/lelo0002/hai../refs/heads/main/theme.lua'))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles
local L = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera
local PlayersFolder = workspace:WaitForChild("Players")
local HudGui = PlayerGui:WaitForChild("HudScreenGui")
local Hud = HudGui.Main.DisplayStatus
local player = LocalPlayer
L.HideSleevesEnabled = false
L.AimbotEnabled = false
L.AimbotPredDropEnabled = false
L.StickyAim = false
L.WallCheck = false
L.CachedTarget = nil
L.NextTargetUpdate = 0
L.MaxAimDistance = 500
L.CurrentFont = 2
L.SnapLineMethod = "Gun Barrel"
L.GunBarrel = nil
L.FovPositionMethod = "Mouse"
L.HasKnife = false
L.StartTime = tick()
L.AntiAimEnabled = false
L.AntiAimYawEnabled = false
L.AntiAimYawAngle = 0
L.AntiAimYawWaveRate = 1
L.AntiAimYawWaveDegree = 0
L.AntiAimYawType = "Custom"
L.AntiAimPitchEnabled = false
L.AntiAimPitchAngle = 0
L.AntiAimPitchWaveRate = 0
L.AntiAimPitchType = "Custom"
L.AntiAimSpinBotEnabled = false
L.AntiAimSpinBotType = "Custom"
L.AntiAimSpinBotDegreeRate = 0
L.AntiAimSpinBotWaveRate = 0
L.InstantAim = false
L.InstantEquip = false
local FontMap = {
	["UI"] = 0,
	["System"] = 1,
	["Plex"] = 2,
	["Monospace"] = 3
}
local SafeFonts = {0, 1, 2, 3}
L.NameCache = setmetatable({}, {__mode = "k"})
L.EntryCache = setmetatable({}, {__mode = "k"})
L.VisualHealth = setmetatable({}, {__mode = "k"})
L.HealthCache = L.HealthCache or setmetatable({}, {__mode = "k"})
L.FadeCache = setmetatable({}, {__mode = "k"})
L.HealthTextFadeCache = setmetatable({}, {__mode = "k"})
L.FadeTime = 0.15
L.AimbotType = "Closest To Mouse"
L.Smoothness = 0.1
L.HideArmsEnabled = false
L.ArmTransparencyOriginals = setmetatable({}, {__mode = "k"})
L.AimVelocity = 1200
L.TEAM = {
	PHANTOMS = Color3.fromRGB(155,182,255),
	GHOSTS = Color3.fromRGB(231,183,88)
}
L.BODY_COLOR = {
	PHANTOMS = Color3.fromRGB(54,75,90),
	GHOSTS = Color3.fromRGB(89,69,56)
}
L.SnapEnabled = false
L.ShowFOV = false
L.FOVRadius = 120
L.FOVColor = Color3.fromRGB(255,255,255)
L.AimKey = Enum.UserInputType.MouseButton2
L.HoldingKey = false
L.LockedTarget = nil
L.TARGET_UPDATE_RATE = 0.08
L.MESH_IDS = {
	Head = "128240072851827",
	Torso = "130888355860552"
}
L.OriginalClockTime = Lighting.ClockTime
L.CustomClockTimeEnabled = false
L.CustomClockTimeValue = 12
L.SelectedAimPart = "Head"
L.TARGET_MESH_ID = L.MESH_IDS[L.SelectedAimPart]
L.CurrentHumanoid = nil
L.DynamicFOVEnabled = false
L.DynamicFOVMultiplier = 1.85
L.DynamicFOVSpeedIn = 0.05
L.UnlockAll = false
L.UnlockCamos = false
L.UnlockKnives = false
L.UnlockAttachments = false
L.RealWeapons = {Assault = {}, Scout = {}, Support = {}, Recon = {}}
L.FakeWeapons = {Assault = {}, Scout = {}, Support = {}, Recon = {}}
L.DynamicFOVSpeedOut = 0.05
L.SelectedSleeveTexture = "rbxassetid://2163189692"
L.OriginalOffsets = {}
L.ViewmodelOffsetCFrame = CFrame.identity
function L:UpdateViewmodelOffset()
	self.ViewmodelOffsetCFrame = CFrame.new(self.ViewmodelOffsetX or 0, self.ViewmodelOffsetY or 0, -(self.ViewmodelOffsetZ or 0))
end
L.ViewmodelOffsetEnabled = false
L.ViewmodelOffsetRemoveOnAim = false
L.ViewmodelOffsetX = 0
L.ViewmodelOffsetY = 0
L.ViewmodelOffsetZ = 0
local SleeveTextureIds = {
	Default = "rbxassetid://2163189692",
	Beach = "rbxassetid://7582881674",
	Camo = "rbxassetid://819001409"
}
L.ChamsType = "Highlight"
L.ChamsBehavior = "AlwaysOnTop"
L.CurrentFOVRadius = L.FOVRadius
L.KillConnection = nil
L.LastLockedModel = nil
L.KillNotifyEnabled = false
L.SilentHeadshotChance = 100
L.RayParams = RaycastParams.new()
L.RayParams.FilterType = Enum.RaycastFilterType.Exclude
L.RayParams.IgnoreWater = true
L.TARGET_WALKSPEED = 16
L.WalkSpeedEnabled = false
L.newSpawnCache = {
	walkSpeed = 16,
	lastUpdate = nil,
	lastUpdateTime = 0,
	latency = 0,
	currentAddition = 0,
	updateDebt = 0
}
L.MasterEnabled = false
L.HighlightEnabled = false
L.WeaponMasterEnabled = false
L.ArmHighlights = setmetatable({}, {__mode = "k"})
L.ArmsMaterialEnabled = false
L.ArmsMaterialColor = Color3.fromRGB(84,132,171)
L.ArmsMaterialEnum = Enum.Material.ForceField
L.SelectedArmForcefieldTexture = "Honeycomb"
L.ArmOriginals = setmetatable({}, {__mode = "k"})
L.MaterialMap = {
	ForceField = Enum.Material.ForceField,
	Neon = Enum.Material.Neon,
	SmoothPlastic = Enum.Material.SmoothPlastic,
	Glass = Enum.Material.Glass,
	Metal = Enum.Material.Metal
}
L.FillColor = Color3.fromRGB(84,132,171)
L.OutlineColor = Color3.fromRGB(255,255,255)
L.HighlightFillTransparency = 0.4
L.WeaponHighlights = setmetatable({}, {__mode = "k"})
L.WeaponHighlightEnabled = false
L.WeaponMaterialEnabled = false
L.WeaponMaterialColor = Color3.fromRGB(84,132,171)
L.WeaponMaterialEnum = Enum.Material.ForceField
L.SelectedWeaponForcefieldTexture = "Honeycomb"
L.WeaponMaterialOriginals = setmetatable({}, {__mode = "k"})
L.HideGunEnabled = false
L.HideGunOriginals = setmetatable({}, {__mode = "k"})
L.HealthESPEnabled = false
L.HealthTextEnabled = false
L.HealthTextColor = Color3.fromRGB(255, 255, 255)
L.HealthHighColor = Color3.fromRGB(0,255,0)
L.HealthLowColor = Color3.fromRGB(255,0,0)
L.HealthGradientEnabled = false
L.WeaponMaterialMap = {
	ForceField = Enum.Material.ForceField,
	Neon = Enum.Material.Neon,
	SmoothPlastic = Enum.Material.SmoothPlastic,
	Glass = Enum.Material.Glass,
	Metal = Enum.Material.Metal
}
L.WeaponFillColor = Color3.fromRGB(84,132,171)
L.WeaponOutlineColor = Color3.fromRGB(255,255,255)
L.WeaponFillTransparency = 0.4
L.OriginalValues = {
	Ambient = Lighting.Ambient
}
L.CAmbientColor = Color3.fromRGB(84,132,171)
L.ChamsEnabled = false
L.ViewModelEnabled = false
L.Offset = Vector3.zero
L.Roots = {}
L.BaseCF = setmetatable({}, {__mode = "k"})
L.LastScan = 0
L.ScanInterval = 0.25
L.ChamsColor = Color3.fromRGB(84,132,171)
L.ChamsTransparency = 0.5
L.ChamsShrinkDefault = 1.2
L.DistanceESPEnabled = false
L.DistanceMax = 750
L.DistanceTextColor = Color3.fromRGB(255,255,255)
L.WeaponTextColor = Color3.fromRGB(255,255,255)
L.DistanceDrawings = {}
L.WeaponDrawings = {}
L.DistanceTorsoCache = setmetatable({}, {__mode = "k"})
L.DistanceTeamTick = 0
L.ActiveChams = setmetatable({}, {__mode = "k"})
L.ChamsLastTeamCheck = 0
L.NameESPEnabled = false
L.SkyboxEnabled = false
L.SelectedSky = "ElegantMorning"
L.Skyboxes = {
    Space = {
        Bk = "rbxassetid://159454299",
        Dn = "rbxassetid://159454296",
        Ft = "rbxassetid://159454293",
        Lf = "rbxassetid://159454286",
        Rt = "rbxassetid://159454300",
        Up = "rbxassetid://159454288"
    },
    Dark = {
        Bk = "rbxassetid://12064107",
        Dn = "rbxassetid://12064152",
        Ft = "rbxassetid://12064121",
        Lf = "rbxassetid://12063984",
        Rt = "rbxassetid://12064115",
        Up = "rbxassetid://12064131"
    },
    Pink = {
        Bk = "rbxassetid://11427769401",
        Dn = "rbxassetid://11427770685",
        Ft = "rbxassetid://11427769401",
        Lf = "rbxassetid://11427769401",
        Rt = "rbxassetid://11427769401",
        Up = "rbxassetid://11427771954"
    },
    PurpleNebula = {
        Bk = "rbxassetid://129876530632297",
        Dn = "rbxassetid://108406529909981",
        Ft = "rbxassetid://104400530594543",
        Lf = "rbxassetid://73372229972523",
        Rt = "rbxassetid://87408857415924",
        Up = "rbxassetid://137817405681365"
    },
    Red = {
        Bk = "rbxassetid://401664839",
        Dn = "rbxassetid://401664862",
        Ft = "rbxassetid://401664960",
        Lf = "rbxassetid://401664881",
        Rt = "rbxassetid://401664901",
        Up = "rbxassetid://401664936"
    },
    White = {
        Bk = "rbxassetid://6213159304",
        Dn = "rbxassetid://6213218651",
        Ft = "rbxassetid://6213159304",
        Lf = "rbxassetid://6213159304",
        Rt = "rbxassetid://6213159304",
        Up = "rbxassetid://6213176544"
    },
    Cartoon1 = {
        Bk = "rbxassetid://15114954171",
        Dn = "rbxassetid://15114958869",
        Ft = "rbxassetid://15114963740",
        Lf = "rbxassetid://15114957947",
        Rt = "rbxassetid://15114955238",
        Up = "rbxassetid://15114948718"
    },
    Cartoon2 = {
        Bk = "rbxassetid://6295671271",
        Dn = "rbxassetid://6295671382",
        Ft = "rbxassetid://6295671136",
        Lf = "rbxassetid://6295670996",
        Rt = "rbxassetid://6295671509",
        Up = "rbxassetid://6295671667"
    },
    PurpleClouds = {
        Bk = "rbxassetid://151165214",
        Dn = "rbxassetid://151165197",
        Ft = "rbxassetid://151165224",
        Lf = "rbxassetid://151165191",
        Rt = "rbxassetid://151165206",
        Up = "rbxassetid://151165227"
    },
    CloudySkies = {
        Bk = "rbxassetid://151165214",
        Dn = "rbxassetid://151165197",
        Ft = "rbxassetid://151165224",
        Lf = "rbxassetid://151165191",
        Rt = "rbxassetid://151165206",
        Up = "rbxassetid://151165227"
    },
    PurpleAndBlue = {
        Bk = "rbxassetid://149397692",
        Dn = "rbxassetid://149397686",
        Ft = "rbxassetid://149397697",
        Lf = "rbxassetid://149397684",
        Rt = "rbxassetid://149397688",
        Up = "rbxassetid://149397702"
    },
    VividSkies = {
        Bk = "rbxassetid://271042516",
        Dn = "rbxassetid://271077243",
        Ft = "rbxassetid://271042556",
        Lf = "rbxassetid://271042310",
        Rt = "rbxassetid://271042467",
        Up = "rbxassetid://271077958"
    },
    Twighlight = {
        Bk = "rbxassetid://264908339",
        Dn = "rbxassetid://264907909",
        Ft = "rbxassetid://264909420",
        Lf = "rbxassetid://264909758",
        Rt = "rbxassetid://264908886",
        Up = "rbxassetid://264907379"
    },
    Vaporwave = {
        Bk = "rbxassetid://1417494030",
        Dn = "rbxassetid://1417494146",
        Ft = "rbxassetid://1417494253",
        Lf = "rbxassetid://1417494402",
        Rt = "rbxassetid://1417494499",
        Up = "rbxassetid://1417494643"
    },
    Clouds = {
        Bk = "rbxassetid://570557514",
        Dn = "rbxassetid://570557775",
        Ft = "rbxassetid://570557559",
        Lf = "rbxassetid://570557620",
        Rt = "rbxassetid://570557672",
        Up = "rbxassetid://570557727"
    },
    NightSky = {
        Bk = "rbxassetid://12064107",
        Dn = "rbxassetid://12064152",
        Ft = "rbxassetid://12064121",
        Lf = "rbxassetid://12063984",
        Rt = "rbxassetid://12064115",
        Up = "rbxassetid://12064131"
    },
    SettingSun = {
        Bk = "rbxassetid://626460377",
        Dn = "rbxassetid://626460216",
        Ft = "rbxassetid://626460513",
        Lf = "rbxassetid://626473032",
        Rt = "rbxassetid://626458639",
        Up = "rbxassetid://626460625"
    },
    FadeBlue = {
        Bk = "rbxassetid://153695414",
        Dn = "rbxassetid://153695352",
        Ft = "rbxassetid://153695452",
        Lf = "rbxassetid://153695320",
        Rt = "rbxassetid://153695383",
        Up = "rbxassetid://153695471"
    },
    ElegantMorning = {
        Bk = "rbxassetid://153767241",
        Dn = "rbxassetid://153767216",
        Ft = "rbxassetid://153767266",
        Lf = "rbxassetid://153767200",
        Rt = "rbxassetid://153767231",
        Up = "rbxassetid://153767288"
    },
    Neptune = {
        Bk = "rbxassetid://218955819",
        Dn = "rbxassetid://218953419",
        Ft = "rbxassetid://218954524",
        Lf = "rbxassetid://218958493",
        Rt = "rbxassetid://218957134",
        Up = "rbxassetid://218950090"
    },
    Redshift = {
        Bk = "rbxassetid://401664839",
        Dn = "rbxassetid://401664862",
        Ft = "rbxassetid://401664960",
        Lf = "rbxassetid://401664881",
        Rt = "rbxassetid://401664901",
        Up = "rbxassetid://401664936"
    },
    AestheticNight = {
        Bk = "rbxassetid://1045964490",
        Dn = "rbxassetid://1045964368",
        Ft = "rbxassetid://1045964655",
        Lf = "rbxassetid://1045964655",
        Rt = "rbxassetid://1045964655",
    }
}
L.ForceFieldTextures = {
    ["Off"] = "rbxassetid://0",
    ["Web"] = "rbxassetid://301464986",
    ["Webbed"] = "rbxassetid://2179243880",
    ["Scanning"] = "rbxassetid://5843010904",
    ["Pixelated"] = "rbxassetid://140652787",
    ["Swirl"] = "rbxassetid://8133639623",
    ["Checkerboard"] = "rbxassetid://5790215150",
    ["Christmas"] = "rbxassetid://6853532738",
    ["Player"] = "rbxassetid://4494641460",
    ["Shield"] = "rbxassetid://361073795",
    ["Dots"] = "rbxassetid://5830615971",
    ["Bubbles"] = "rbxassetid://1461576423",
    ["Matrix"] = "rbxassetid://10713189068",
    ["Honeycomb"] = "rbxassetid://179898251",
    ["Groove"] = "rbxassetid://10785404176",
    ["Cloud"] = "rbxassetid://5176277457",
    ["Sky"] = "rbxassetid://1494603972",
    ["Smudge"] = "rbxassetid://6096634060",
    ["Scrapes"] = "rbxassetid://6248583558",
    ["Galaxy"] = "rbxassetid://1120738433",
    ["Galaxies"] = "rbxassetid://5101923607",
    ["Stars"] = "rbxassetid://598201818",
    ["Rainbow"] = "rbxassetid://10037165803",
    ["Wires"] = "rbxassetid://14127933",
    ["Camo"] = "rbxassetid://3280937154",
    ["Hexagon"] = "rbxassetid://6175083785",
    ["Particles"] = "rbxassetid://1133822388",
    ["Triangular"] = "rbxassetid://4504368932",
    ["Wall"] = "rbxassetid://4271279"
}
L.NameDrawings = {}
L.NameHeadCache = setmetatable({}, {__mode = "k"})
L.NoJumpCooldownEnabled = false
L.HoldingJump = false
L.NoFallDamageEnabled = false
L.movementCache = {time = {}, position = setmetatable({}, {__mode = "k"})}
L.BoxESPEnabled = false
L.BoxDrawings = {}
L.BoxOutlineDrawings = {}
L.HealthDrawings = {}
L.HealthOutlineDrawings = {}
L.HealthTextDrawings = {}
L.BoxColor = Color3.fromRGB(255,255,255)
L.BoxThickness = 0.5
L.BoxOutlineThickness = 3
L.BoxMaxDistance = L.DistanceMax
L.GunshotOverride = false
L.SelectedSound = "Minecraft experience"
L.SoundVolume = 1
L.SoundBackup = setmetatable({}, {__mode = "k"})
L.ValidSoundIds = {}
L.SoundMap = {
	["Minecraft experience"] = "rbxassetid://7151570575",
	Neverlose = "rbxassetid://8726881116",
	Gamesense = "rbxassetid://4817809188",
	One = "rbxassetid://7380502345",
	Bell = "rbxassetid://6534947240",
	Rust = "rbxassetid://1255040462",
	TF2 = "rbxassetid://2868331684",
	Slime = "rbxassetid://6916371803",
	["Among Us"] = "rbxassetid://5700183626",
	Minecraft = "rbxassetid://4018616850",
	["CS:GO"] = "rbxassetid://6937353691",
	Saber = "rbxassetid://8415678813",
	Baimware = "rbxassetid://3124331820",
	Osu = "rbxassetid://7149255551",
	["TF2 Critical"] = "rbxassetid://296102734",
	Bat = "rbxassetid://3333907347",
	["Call of Duty"] = "rbxassetid://5952120301",
	Bubble = "rbxassetid://6534947588",
	Pick = "rbxassetid://1347140027",
	Pop = "rbxassetid://198598793",
	Bruh = "rbxassetid://4275842574",
	["[Bamboo]"] = "rbxassetid://3769434519",
	Crowbar = "rbxassetid://546410481",
	Weeb = "rbxassetid://6442965016",
	Beep = "rbxassetid://8177256015",
	Bambi = "rbxassetid://8437203821",
	Stone = "rbxassetid://3581383408",
	["Old Fatality"] = "rbxassetid://6607142036",
	Click = "rbxassetid://8053704437",
	Ding = "rbxassetid://7149516994",
	Snow = "rbxassetid://6455527632",
	Laser = "rbxassetid://7837461331",
	Mario = "rbxassetid://2815207981",
	Steve = "rbxassetid://4965083997",
	Snowdrake = "rbxassetid://7834724809",
	Default = "rbxassetid://4581728529"
}
L.HitSoundSelected = "rbxassetid://8726881116"
L.HitSoundVolume = 1
L.HitSoundOverride = false
L.HitSoundBackup = setmetatable({}, {__mode = "k"})
L.HitSoundMap = {
	["Minecraft experience"] = "rbxassetid://7151570575",
	Neverlose = "rbxassetid://8726881116",
	Gamesense = "rbxassetid://4817809188",
	One = "rbxassetid://7380502345",
	Bell = "rbxassetid://6534947240",
	Rust = "rbxassetid://1255040462",
	TF2 = "rbxassetid://2868331684",
	Slime = "rbxassetid://6916371803",
	["Among Us"] = "rbxassetid://5700183626",
	Minecraft = "rbxassetid://4018616850",
	["CS:GO"] = "rbxassetid://6937353691",
	Saber = "rbxassetid://8415678813",
	Baimware = "rbxassetid://3124331820",
	Osu = "rbxassetid://7149255551",
	["TF2 Critical"] = "rbxassetid://296102734",
	Bat = "rbxassetid://3333907347",
	["Call of Duty"] = "rbxassetid://5952120301",
	Bubble = "rbxassetid://6534947588",
	Pick = "rbxassetid://1347140027",
	Pop = "rbxassetid://198598793",
	Bruh = "rbxassetid://4275842574",
	["[Bamboo]"] = "rbxassetid://3769434519",
	Crowbar = "rbxassetid://546410481",
	Weeb = "rbxassetid://6442965016",
	Beep = "rbxassetid://8177256015",
	Bambi = "rbxassetid://8437203821",
	Stone = "rbxassetid://3581383408",
	["Old Fatality"] = "rbxassetid://6607142036",
	Click = "rbxassetid://8053704437",
	Ding = "rbxassetid://7149516994",
	Snow = "rbxassetid://6455527632",
	Laser = "rbxassetid://7837461331",
	Mario = "rbxassetid://2815207981",
	Steve = "rbxassetid://4965083997",
	Snowdrake = "rbxassetid://7834724809",
	Default = "rbxassetid://4581728529"
}
L.KillSoundSelected = "rbxassetid://4817809188"
L.KillSoundVolume = 1
L.KillSoundOverride = false
L.KillSoundBackup = setmetatable({}, {__mode = "k"})
L.KillSoundMap = {
	["Minecraft experience"] = "rbxassetid://7151570575",
	Neverlose = "rbxassetid://8726881116",
	Gamesense = "rbxassetid://4817809188",
	One = "rbxassetid://7380502345",
	Bell = "rbxassetid://6534947240",
	Rust = "rbxassetid://1255040462",
	TF2 = "rbxassetid://2868331684",
	Slime = "rbxassetid://6916371803",
	["Among Us"] = "rbxassetid://5700183626",
	Minecraft = "rbxassetid://4018616850",
	["CS:GO"] = "rbxassetid://6937353691",
	Saber = "rbxassetid://8415678813",
	Baimware = "rbxassetid://3124331820",
	Osu = "rbxassetid://7149255551",
	["TF2 Critical"] = "rbxassetid://296102734",
	Bat = "rbxassetid://3333907347",
	["Call of Duty"] = "rbxassetid://5952120301",
	Bubble = "rbxassetid://6534947588",
	Pick = "rbxassetid://1347140027",
	Pop = "rbxassetid://198598793",
	Bruh = "rbxassetid://4275842574",
	["[Bamboo]"] = "rbxassetid://3769434519",
	Crowbar = "rbxassetid://546410481",
	Weeb = "rbxassetid://6442965016",
	Beep = "rbxassetid://8177256015",
	Bambi = "rbxassetid://8437203821",
	Stone = "rbxassetid://3581383408",
	["Old Fatality"] = "rbxassetid://6607142036",
	Click = "rbxassetid://8053704437",
	Ding = "rbxassetid://7149516994",
	Snow = "rbxassetid://6455527632",
	Laser = "rbxassetid://7837461331",
	Mario = "rbxassetid://2815207981",
	Steve = "rbxassetid://4965083997",
	Snowdrake = "rbxassetid://7834724809",
	Default = "rbxassetid://4581728529"
}
if not L.HitSoundSelected then
	L.HitSoundSelected = "rbxassetid://8726881116"
end
if not L.KillSoundSelected then
	L.KillSoundSelected = "rbxassetid://4817809188"
end
local WeaponRoots = {
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase["TWO HAND BLUNT"],
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase["ASSAULT RIFLE"],
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase["BATTLE RIFLE"],
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.CARBINE,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.DMR,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.FRAGMENTATION,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase["HIGH EXPLOSIVE"],
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.IMPACT,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.LMG,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase["MACHINE PISTOLS"],
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase["ONE HAND BLADE"],
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase["ONE HAND BLUNT"],
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.OTHER,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.PDW,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.PISTOLS,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.REVOLVERS,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase.SHOTGUN,
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase["SNIPER RIFLE"],
	ReplicatedStorage.Content.ProductionContent.WeaponDatabase["TWO HAND BLADE"]
}
L.CrosshairTop = true
L.CrosshairRight = true
L.CrosshairBottom = true
L.CrosshairLeft = true
local STYLE_SIDES = {
	["1"] = {Top=true, Right=true, Bottom=true, Left=true},
	["2"] = {Top=true, Right=false, Bottom=true, Left=false},
	["3"] = {Top=true, Right=true, Bottom=true, Left=false}
}
L.CrosshairEnabled = false
L.CrosshairColor = Color3.fromRGB(255,255,255)
L.CrosshairSpin = false
L.CrosshairSize = 25
L.CrosshairSpinSpeed = 25
L.CrosshairThickness = 2
L.CrosshairGap = 6
L.CrosshairSides = {Top=true, Bottom=true, Left=true, Right=true}
L.CrosshairPositionMode = "Center Of Screen"
L.SilentEnabled = false
L.SilentHolding = false
L.SilentSticky = false
L.SilentWallCheck = false
L.SilentHitChance = 50
L.SilentPriority = "Closest To Mouse"
L.SilentShowFOV = false
L.SilentDynamicFOV = false
L.SilentFOVRadius = 120
L.SilentCurrentFOV = 120
L.SilentFOVColor = Color3.fromRGB(255,255,255)
L.SilentSnapEnabled = false
L.SilentSnapColor = Color3.fromRGB(255,255,255)
L.SilentSnapOriginMethod = "Gun Barrel"
L.SilentFOVOriginMethod = "Gun Barrel"
L.SilentLockedPart = nil
L.SilentMaxAimDistance = 500
L.SilentOriginalCF = nil
L.SilentHeartbeat = nil
L.SILENT_MESH_IDS = {
	Head = "128240072851827",
	Torso = "130888355860552"
}
L.SilentAimPart = "Head"
L.SILENT_TARGET_MESH = L.SILENT_MESH_IDS[L.SilentAimPart]
				local function ClearAll()
					for _, h in pairs(L.ArmHighlights) do pcall(function() h:Destroy() end) end
					table.clear(L.ArmHighlights)
				end
				local function SetSleeveSlotsTransparency(value)
					for _, obj in ipairs(Camera:GetChildren()) do
						if obj:IsA("Model") then
							local sleeves = obj:FindFirstChild("Sleeves", true)
							if sleeves and sleeves:IsA("MeshPart") then
								if sleeves.Transparency ~= value then
									sleeves.Transparency = value
								end
								for _, tex in ipairs(sleeves:GetChildren()) do
									if tex:IsA("Texture") and tex.Name == "Slot1" and tex.Transparency ~= value then
										tex.Transparency = value
									end
								end
							end
						end
					end
				end
				local function CreateHighlight(part)
					if L.ArmHighlights[part] or not L.HighlightEnabled then return end
					if not part:IsA("MeshPart") or part.Name ~= "SkinTone" then return end
					local h = Instance.new("Highlight")
					h.Adornee = part
					h.FillColor = L.FillColor
					h.OutlineColor = L.OutlineColor
					h.FillTransparency = L.HighlightFillTransparency
					h.OutlineTransparency = 0
					h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					h.Parent = part
					L.ArmHighlights[part] = h
				end
				local function getArmModels()
					local arms = {}
					for _, obj in ipairs(Camera:GetChildren()) do
						if obj:IsA("Model") then
							if obj:FindFirstChild("SkinTone", true) then
								table.insert(arms, obj)
							end
						end
					end
					return arms
				end
				local function applyArmMaterial()
					local texture = L.ForceFieldTextures[L.SelectedArmForcefieldTexture or "Off"]
					for _, model in ipairs(getArmModels()) do
						for _, part in ipairs(model:GetDescendants()) do
							if part:IsA("MeshPart") then
								if not L.ArmOriginals[part] then
									L.ArmOriginals[part] = { Material = part.Material, Color = part.Color, TextureId = part.TextureID }
								end
								if part.Material ~= L.ArmsMaterialEnum then
									part.Material = L.ArmsMaterialEnum
								end
								if part.Color ~= L.ArmsMaterialColor then
									part.Color = L.ArmsMaterialColor
								end
								local targetTex = (L.ArmsMaterialEnum == Enum.Material.ForceField) and texture or ""
								if part.TextureID ~= targetTex then
									part.TextureID = targetTex
								end
							elseif part:IsA("SpecialMesh") then
								if not L.ArmOriginals[part] then
									L.ArmOriginals[part] = { TextureId = part.TextureId }
								end
								local targetTex = (L.ArmsMaterialEnum == Enum.Material.ForceField) and texture or ""
								if part.TextureId ~= targetTex then
									part.TextureId = targetTex
								end
							end
						end
					end
				end
				local function restoreArmMaterial()
					for part, data in pairs(L.ArmOriginals) do
						if part and (part:IsDescendantOf(Camera) or part:IsDescendantOf(workspace)) then
							if part:IsA("BasePart") then
								part.Material = data.Material
								part.Color = data.Color
								if part:IsA("MeshPart") then
									part.TextureID = data.TextureId
								end
							elseif part:IsA("SpecialMesh") then
								part.TextureId = data.TextureId
							end
						end
					end
					table.clear(L.ArmOriginals)
				end
				local function applyHideArms()
					for _, model in ipairs(getArmModels()) do
						for _, part in ipairs(model:GetDescendants()) do
							if part:IsA("BasePart") and part.Name ~= "Sleeves" then
								if not L.ArmTransparencyOriginals[part] and part.Transparency < 0.9 then
									L.ArmTransparencyOriginals[part] = {
										Trans = part.Transparency,
										LTrans = part.LocalTransparencyModifier
									}
								end
								if part.Transparency ~= 1 then
									part.Transparency = 1
								end
								if part.LocalTransparencyModifier ~= 1 then
									part.LocalTransparencyModifier = 1
								end
							end
						end
					end
				end
				local function restoreHideArms()
					for part, data in pairs(L.ArmTransparencyOriginals) do
						if part and (part:IsDescendantOf(Camera) or part:IsDescendantOf(workspace)) then
							if type(data) == "table" then
								part.Transparency = data.Trans
								part.LocalTransparencyModifier = data.LTrans
							else
								part.Transparency = data
							end
						end
					end
					table.clear(L.ArmTransparencyOriginals)
				end
RunService.Heartbeat:Connect(function()
	if not L.MasterEnabled and not L.ThirdPersonHideChar then
		if next(L.ArmOriginals) then restoreArmMaterial() end
		if next(L.ArmTransparencyOriginals) then restoreHideArms() end
		SetSleeveSlotsTransparency(0)
		for part, h in pairs(L.ArmHighlights) do
			pcall(function() h:Destroy() end)
			L.ArmHighlights[part] = nil
		end
		return
	end
	if L.ArmsMaterialEnabled or L.ThirdPersonHideChar then
		applyArmMaterial()
	else
		restoreArmMaterial()
	end
	if L.HideSleevesEnabled or L.ThirdPersonHideChar then
		SetSleeveSlotsTransparency(1)
	else
		SetSleeveSlotsTransparency(0)
	end
	if L.HideArmsEnabled or L.ThirdPersonHideChar then
		applyHideArms()
	elseif next(L.ArmTransparencyOriginals) then
		restoreHideArms()
	end
	for part, h in pairs(L.ArmHighlights) do
		if not part or not part:IsDescendantOf(Camera) or not L.HighlightEnabled then
			pcall(function() h:Destroy() end)
			L.ArmHighlights[part] = nil
		end
	end
	if L.HighlightEnabled then
		for _, obj in ipairs(Camera:GetDescendants()) do
			if obj:IsA("MeshPart") and obj.Name == "SkinTone" then
				CreateHighlight(obj)
			end
		end
	end
end)
local function modelHasSleeves(model)
	return model:FindFirstChild("Sleeves", true) ~= nil
end
local function getWeaponModel()
	for _, model in ipairs(Camera:GetChildren()) do
		if model:IsA("Model") and not modelHasSleeves(model) then
			return model
		end
	end
	return nil
end
				local function clearWeaponHighlights()
					for _, h in pairs(L.WeaponHighlights) do pcall(function() h:Destroy() end) end
					table.clear(L.WeaponHighlights)
				end
				local function applyWeaponHighlight(model)
					if not model or L.WeaponHighlights[model] or not L.WeaponHighlightEnabled then return end
					local h = Instance.new("Highlight")
					h.Adornee = model
					h.FillColor = L.WeaponFillColor
					h.OutlineColor = L.WeaponOutlineColor
					h.FillTransparency = L.WeaponFillTransparency
					h.OutlineTransparency = 0
					h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					h.Parent = model
					L.WeaponHighlights[model] = h
				end
				RunService.Heartbeat:Connect(function()
					if not L.WeaponMasterEnabled then return end
					local weaponModel = getWeaponModel()
					for model, h in pairs(L.WeaponHighlights) do
						if not model or not model:IsDescendantOf(Camera) or not L.WeaponHighlightEnabled or model ~= weaponModel then
							pcall(function() h:Destroy() end)
							L.WeaponHighlights[model] = nil
						end
					end
					if not L.WeaponHighlightEnabled then return end
					if weaponModel then applyWeaponHighlight(weaponModel) end
				end)
				local function applyWeaponMaterial(model)
					if not model then return end
					local texture = L.ForceFieldTextures[L.SelectedWeaponForcefieldTexture or "Off"]
					for _, part in ipairs(model:GetDescendants()) do
						if part:IsA("MeshPart") then
							if not L.WeaponMaterialOriginals[part] then
								L.WeaponMaterialOriginals[part] = {
									Material = part.Material,
									Color = part.Color,
									TextureId = part.TextureID
								}
							end
							if part.Material ~= L.WeaponMaterialEnum then
								part.Material = L.WeaponMaterialEnum
							end
							if part.Color ~= L.WeaponMaterialColor then
								part.Color = L.WeaponMaterialColor
							end
							local targetTex = (L.WeaponMaterialEnum == Enum.Material.ForceField) and texture or ""
							if part.TextureID ~= targetTex then
								part.TextureID = targetTex
							end
						elseif part:IsA("BasePart") then
							if not L.WeaponMaterialOriginals[part] then
								L.WeaponMaterialOriginals[part] = {
									Material = part.Material,
									Color = part.Color
								}
							end
							if part.Material ~= L.WeaponMaterialEnum then
								part.Material = L.WeaponMaterialEnum
							end
							if part.Color ~= L.WeaponMaterialColor then
								part.Color = L.WeaponMaterialColor
							end
						elseif part:IsA("SpecialMesh") then
							if not L.WeaponMaterialOriginals[part] then
								L.WeaponMaterialOriginals[part] = { TextureId = part.TextureId }
							end
							local targetTex = (L.WeaponMaterialEnum == Enum.Material.ForceField) and texture or ""
							if part.TextureId ~= targetTex then
								part.TextureId = targetTex
							end
						end
					end
				end
				local function restoreWeaponMaterial()
					for part, data in pairs(L.WeaponMaterialOriginals) do
						if part and (part:IsDescendantOf(Camera) or part:IsDescendantOf(workspace)) then
							if part:IsA("BasePart") then
								part.Material = data.Material
								part.Color = data.Color
								if part:IsA("MeshPart") then
									part.TextureID = data.TextureId
								end
							elseif part:IsA("SpecialMesh") then
								part.TextureId = data.TextureId
							end
						end
					end
					table.clear(L.WeaponMaterialOriginals)
				end
				local function applyHideGun(model)
					if not model then return end
					for _, part in ipairs(model:GetDescendants()) do
						if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Texture") then
							if not L.HideGunOriginals[part] and part.Transparency < 0.9 then
								L.HideGunOriginals[part] = {
									Trans = part.Transparency,
									LTrans = part:IsA("BasePart") and part.LocalTransparencyModifier or nil
								}
							end
							if part.Transparency ~= 1 then
								part.Transparency = 1
							end
							if part:IsA("BasePart") and part.LocalTransparencyModifier ~= 1 then
								part.LocalTransparencyModifier = 1
							end
						end
					end
				end
				local function restoreHideGun()
					for part, data in pairs(L.HideGunOriginals) do
						if part and part:IsDescendantOf(Camera) then
							if type(data) == "table" then
								part.Transparency = data.Trans
								if part:IsA("BasePart") and data.LTrans then
									part.LocalTransparencyModifier = data.LTrans
								end
							else
								part.Transparency = data
							end
						end
					end
					table.clear(L.HideGunOriginals)
				end
				RunService.Heartbeat:Connect(function()
					if L.WeaponMasterEnabled then
						local weaponModel = getWeaponModel()
						if weaponModel then
							if L.WeaponMaterialEnabled then
								applyWeaponMaterial(weaponModel)
							end
						end
					end
					if not L.WeaponMasterEnabled or not L.WeaponMaterialEnabled then
						if next(L.WeaponMaterialOriginals) then restoreWeaponMaterial() end
					end
					if not L.WeaponMasterEnabled or not L.HideGunEnabled then
						if next(L.HideGunOriginals) then restoreHideGun() end
					end
				end)
				RunService.RenderStepped:Connect(function()
					if L.WeaponMasterEnabled and L.HideGunEnabled then
						local weaponModel = getWeaponModel()
						if weaponModel then
							applyHideGun(weaponModel)
						end
					end
				end)
				local SnapOutline = Drawing.new("Line")
				SnapOutline.Thickness = 3
				SnapOutline.Color = Color3.new(0, 0, 0)
				SnapOutline.Transparency = 1
				SnapOutline.Visible = false
				local SnapLine = Drawing.new("Line")
				SnapLine.Thickness = 1
				SnapLine.Color = Color3.fromRGB(255, 255, 255)
				SnapLine.Transparency = 1
				SnapLine.Visible = false
				local FOVOutline = Drawing.new("Circle")
				FOVOutline.Filled = false
				FOVOutline.Thickness = 3
				FOVOutline.Color = Color3.new(0,0,0)
				FOVOutline.Transparency = 1
				FOVOutline.Visible = false
				local FOVCircle = Drawing.new("Circle")
				FOVCircle.Filled = false
				FOVCircle.Thickness = 1
				FOVCircle.Color = L.FOVColor
				FOVCircle.Transparency = 1
				FOVCircle.Visible = false
				L.FOVFill = Drawing.new("Circle")
				L.FOVFill.Filled = true
				L.FOVFill.Thickness = 0
				L.FOVFill.Color = Color3.fromRGB(83,132,171)
				L.FOVFill.Transparency = 0.5
				L.FOVFill.Visible = false
				local function isOnScreen(part)
					local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
					return onScreen
				end
				local function isVisible(part)
					if not L.WallCheck then
						return true
					end
					if not part or not part:IsA("BasePart") or not part:IsDescendantOf(workspace) then
						return false
					end
					if not isOnScreen(part) then
						return false
					end
					local origin = Camera.CFrame.Position
					local targetPos = part.Position
					local direction = targetPos - origin
					local distance = direction.Magnitude
					direction = direction.Unit * (distance + 0.5)
					local params = RaycastParams.new()
					params.FilterType = Enum.RaycastFilterType.Exclude
					params.FilterDescendantsInstances = {
						LocalPlayer.Character,
						Camera
					}
					params.IgnoreWater = true
					local result = workspace:Raycast(origin, direction, params)
					if not result then
						return true
					end
					if result.Instance:IsDescendantOf(part.Parent) then
						return true
					end
					local tolerance = part.Size.Magnitude * 0.75
					if (result.Position - targetPos).Magnitude <= tolerance then
						return true
					end
					return false
				end
				local LocalTeam = nil
				local validPatternSleeves = nil
				local function getLocalTeam()
					if validPatternSleeves and validPatternSleeves:IsDescendantOf(Camera) then
						local tex = validPatternSleeves:FindFirstChild("Slot1")
						if tex and tex:IsA("Texture") then
							local c = tex.Color3
							if c == L.TEAM.PHANTOMS then return "PHANTOMS"
							elseif c == L.TEAM.GHOSTS then return "GHOSTS" end
						end
					end
					for _, obj in ipairs(Camera:GetDescendants()) do
						if obj:IsA("MeshPart") and obj.Name == "Sleeves" then
							validPatternSleeves = obj
							for _, tex in ipairs(obj:GetChildren()) do
								if tex:IsA("Texture") and tex.Name == "Slot1" then
									local c = tex.Color3
									if c == L.TEAM.PHANTOMS then
										return "PHANTOMS"
									elseif c == L.TEAM.GHOSTS then
										return "GHOSTS"
									end
								end
							end
						end
					end
					return nil
				end
				local function isEnemy(part)
					if not LocalTeam then return false end
					if not part or not part:IsDescendantOf(workspace) then return false end
					local pparent = part.Parent
					local torso
					for _, p in ipairs(pparent:GetChildren()) do
						if p:IsA("MeshPart") and p.MeshId and p.MeshId:find(L.MESH_IDS.Torso) then
							torso = p
							break
						end
					end
					if not torso then return false end
					local torsoColor = torso.Color
					if LocalTeam == "PHANTOMS" then
						return torsoColor == L.BODY_COLOR.GHOSTS
					elseif LocalTeam == "GHOSTS" then
						return torsoColor == L.BODY_COLOR.PHANTOMS
					end
					return false
				end
				local function checkEnemyByModel(model)
					local torso = L.DistanceTorsoCache and L.DistanceTorsoCache[model]
					if torso == false then return false end
					if not torso or not torso:IsDescendantOf(model) then
						for _,v in ipairs(model:GetDescendants()) do
							if v:IsA("MeshPart") and v.MeshId and v.MeshId:find(L.MESH_IDS.Torso) then
								torso = v
								if L.DistanceTorsoCache then L.DistanceTorsoCache[model] = v end
								break
							end
						end
					end
					if not torso then 
						if L.DistanceTorsoCache then L.DistanceTorsoCache[model] = false end
						return false 
					end
					if not LocalTeam then return true end
					local c = torso.Color
					if LocalTeam == "PHANTOMS" then return c == L.BODY_COLOR.GHOSTS
					elseif LocalTeam == "GHOSTS" then return c == L.BODY_COLOR.PHANTOMS end
					return false
				end
				L.AimPartCache = L.AimPartCache or setmetatable({}, {__mode = "k"})
				local function getCachedTargetPart(model)
					local c = L.AimPartCache[model]
					if c == false then return nil end
					if c and c:IsDescendantOf(model) and c.MeshId:find(L.TARGET_MESH_ID) then return c end
					for _, v in ipairs(model:GetDescendants()) do
						if v:IsA("MeshPart") and v.MeshId and v.MeshId:find(L.TARGET_MESH_ID) then
							L.AimPartCache[model] = v
							return v
						end
					end
					L.AimPartCache[model] = false
					return nil
				end
				local function getTargetParts()
					local t = {}
					for model, _ in pairs(L.NameDrawings or {}) do
						if checkEnemyByModel(model) then
							local part = getCachedTargetPart(model)
							if part then
								t[#t+1] = part
							end
						end
					end
					return t
				end
local function getClosestTarget()
	local camPos = Camera.CFrame.Position
	local origin
	if L.FovPositionMethod == "Gun Barrel" then
		if L.HasKnife or not L.GunBarrel or not L.GunBarrel:IsDescendantOf(Camera) then
			return nil
		end
		local forwardOffset = 7.5
		local worldPos = L.GunBarrel.Position + (L.GunBarrel.CFrame.LookVector * forwardOffset)
		local v, onScreen = Camera:WorldToViewportPoint(worldPos)
		if not onScreen then
			return nil
		end
		origin = Vector2.new(v.X, v.Y)
	else
		origin = UserInputService:GetMouseLocation()
	end
	local closest = nil
	local shortest = math.huge
	for _, part in ipairs(getTargetParts()) do
		if part and part:IsDescendantOf(workspace) then
			local worldDist = (camPos - part.Position).Magnitude
			if worldDist <= L.MaxAimDistance then
				local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
				if onScreen and isVisible(part) then
					local screenDist = (Vector2.new(pos.X, pos.Y) - origin).Magnitude
					if screenDist <= L.FOVRadius then
						if L.AimbotType == "Closest To You" then
							if worldDist < shortest then
								shortest = worldDist
								closest = part
							end
						else
							if screenDist < shortest then
								shortest = screenDist
								closest = part
							end
						end
					end
				end
			end
		end
	end
	return closest
end
				UserInputService.InputBegan:Connect(function(input, gpe)
					if gpe then return end
					if input.KeyCode == L.AimKey or input.UserInputType == L.AimKey then
						L.HoldingKey = true
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.KeyCode == L.AimKey or input.UserInputType == L.AimKey then
						L.HoldingKey = false
						L.LockedTarget = nil
						L.LastLockedModel = nil
						if L.KillConnection then
							L.KillConnection:Disconnect()
							L.KillConnection = nil
						end
					end
				end)
				RunService.Heartbeat:Connect(function()
					local newTeam = getLocalTeam()
					if newTeam and LocalTeam ~= newTeam then
						table.clear(L.EnemyCache)
						table.clear(L.EntryCache or {})
						LocalTeam = newTeam
					end
				end)
local insert = table.insert
local ipairs = ipairs
local pairs = pairs
local clock = os.clock
L.ActiveChams = L.ActiveChams and setmetatable(L.ActiveChams, {__mode = "k"}) or setmetatable({}, {__mode = "k"})
L.ChamsTicks = L.ChamsTicks and setmetatable(L.ChamsTicks, {__mode = "k"}) or setmetatable({}, {__mode = "k"})
L.CachedOnScreen = L.CachedOnScreen and setmetatable(L.CachedOnScreen, {__mode = "k"}) or setmetatable({}, {__mode = "k"})
L.EnemyCache = L.EnemyCache and setmetatable(L.EnemyCache, {__mode = "k"}) or setmetatable({}, {__mode = "k"})
L.StreamingHold = L.StreamingHold and setmetatable(L.StreamingHold, {__mode = "k"}) or setmetatable({}, {__mode = "k"})
local STREAM_HOLD_TIME = 0.35
local function getTorso(model)
	local c=L.DistanceTorsoCache[model]
	if c == false then return nil end
	if c and c:IsDescendantOf(model) then return c end
	for _,v in ipairs(model:GetDescendants()) do
		if v:IsA("MeshPart") and v.MeshId and v.MeshId:find(L.MESH_IDS.Torso) then
			L.DistanceTorsoCache[model]=v
			return v
		end
	end
	L.DistanceTorsoCache[model]=false
	return nil
end
local function clearChams(model)
	local boxes = L.ActiveChams[model]
	if not boxes then return end
	for i = 1, #boxes do
		local b = boxes[i]
		if b and b.Parent then
			b:Destroy()
		end
	end
	L.ActiveChams[model] = nil
	L.ChamsTicks[model] = nil
	L.CachedOnScreen[model] = nil
end
local function isValidModel(model)
	return model:IsA("Model") and model:FindFirstChildWhichIsA("BasePart", true)
end
local function isEnemyModel(model)
	local cached = L.EnemyCache[model]
	if cached ~= nil then
		return cached
	end
	if not LocalTeam then return false end
	local isEnm = checkEnemyByModel(model)
	L.EnemyCache[model] = isEnm
	return isEnm
end
local function createBox(model, part, shrink)
	local boxes = L.ActiveChams[model]
	if not boxes then
		boxes = {}
		L.ActiveChams[model] = boxes
	end
	for i = 1, #boxes do
		local b = boxes[i]
		if b.Adornee == part then
			return b
		end
	end
	local box = Instance.new("BoxHandleAdornment")
	box.Adornee = part
	box.AlwaysOnTop = (L.ChamsBehavior == "AlwaysOnTop")
	box.ZIndex = box.AlwaysOnTop and 10 or 0
	box.Size = part.Size / shrink
	box.Color3 = L.ChamsColor
	box.Transparency = L.ChamsTransparency
	box.Parent = part
	insert(boxes, box)
	return box
end
local ValidLimbs = {
	"head", "torso", "arm", "leg", "hand", "foot"
}
local function isValidLimb(part)
	if not part or not part:IsA("MeshPart") then return false end
	local n = string.lower(part.Name)
	for _, limb in ipairs(ValidLimbs) do
		if string.find(n, limb) then
			return true
		end
	end
	return false
end
local function applyChams(model)
	clearChams(model)
	local boxes = {}
	L.ActiveChams[model] = boxes
	local color = L.ChamsColor
	if L.ChamsType == "Highlight" then
		local hl = Instance.new("Highlight")
		hl.Adornee = model
		hl.FillColor = color
		hl.OutlineColor = color
		hl.FillTransparency = L.ChamsTransparency
		hl.OutlineTransparency = L.ChamsTransparency
		hl.DepthMode = (L.ChamsBehavior == "AlwaysOnTop") and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
		hl.Parent = L.CoreGui
		local success = pcall(function() hl.Parent = L.CoreGui end)
		if not success then
			hl.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
		end
		insert(boxes, hl)
	else
		local shrink = (L.ChamsBehavior == "Occluded") and (L.ChamsShrinkDefault / 1.2) or L.ChamsShrinkDefault
		for _, part in ipairs(model:GetDescendants()) do
			if isValidLimb(part) then
				local box = createBox(model, part, shrink)
				box.Color3 = color
			end
		end
	end
end
local function updateAllChams()
	local color = L.ChamsColor
	local trans = L.ChamsTransparency
	local shrink = (L.ChamsBehavior == "Occluded") and (L.ChamsShrinkDefault / 1.2) or L.ChamsShrinkDefault
	local alwaysOnTop = (L.ChamsBehavior == "AlwaysOnTop")
	local zIndex = alwaysOnTop and 10 or 0
	local depthMode = alwaysOnTop and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
	for model, boxes in pairs(L.ActiveChams) do
		for i = 1, #boxes do
			local b = boxes[i]
			if b then
				if b:IsA("Highlight") then
					b.FillColor = color
					b.OutlineColor = color
					b.FillTransparency = trans
					b.OutlineTransparency = trans
					b.DepthMode = depthMode
				else
					b.Color3 = color
					b.Transparency = trans
					b.AlwaysOnTop = alwaysOnTop
					b.ZIndex = zIndex
					if b.Adornee then
						b.Size = b.Adornee.Size / shrink
					end
				end
			end
		end
	end
end
L.ChamsHooked = L.ChamsHooked and setmetatable(L.ChamsHooked, {__mode = "k"}) or setmetatable({}, {__mode = "k"})
local function hookModelRealtime(model)
	if not isValidModel(model) then return end
	if L.ChamsHooked[model] then return end
	local conns = {}
	L.ChamsHooked[model] = conns
	local function refresh()
		L.EnemyCache[model] = nil
		if L.ChamsEnabled and isEnemyModel(model) then
			applyChams(model)
		else
			clearChams(model)
		end
	end
	refresh()
	table.insert(conns, model.DescendantAdded:Connect(function(d)
		if not L.ChamsEnabled or not isEnemyModel(model) then return end
		if L.ChamsType == "Highlight" then return end
		if not isValidLimb(d) then return end
		local shrink = (L.ChamsBehavior == "Occluded") and (L.ChamsShrinkDefault / 1.2) or L.ChamsShrinkDefault
		local box = createBox(model, d, shrink)
		box.Color3 = L.ChamsColor
		box.Transparency = L.ChamsTransparency
		box.AlwaysOnTop = (L.ChamsBehavior == "AlwaysOnTop")
		box.ZIndex = box.AlwaysOnTop and 10 or 0
	end))
	table.insert(conns, model.DescendantRemoving:Connect(function(d)
		if L.ChamsType == "Highlight" then return end
		if not d:IsA("BasePart") then return end
		local boxes = L.ActiveChams[model]
		if boxes then
			for i = #boxes, 1, -1 do
				local b = boxes[i]
				if not b or b.Adornee == d or not b.Parent then
					if b then b:Destroy() end
					table.remove(boxes, i)
				end
			end
		end
	end))
	table.insert(conns, model.AncestryChanged:Connect(function()
		L.StreamingHold[model] = nil
		refresh()
	end))
end
local function processChams(model)
	if not model or not isValidModel(model) then return end
	L.EnemyCache[model] = nil
	hookModelRealtime(model)
	if L.ChamsEnabled and isEnemyModel(model) then
		applyChams(model)
	end
end
local function hookChamsFolder(folder)
	if not folder then return end
	for _, model in ipairs(folder:GetChildren()) do
		processChams(model)
	end
	folder.ChildAdded:Connect(function(m)
		if not m then return end
		processChams(m)
	end)
	folder.ChildRemoved:Connect(function(m)
		if not m then return end
		clearChams(m)
		L.EnemyCache[m] = nil
		if L.ChamsHooked[m] and type(L.ChamsHooked[m]) == "table" then
			for _, conn in ipairs(L.ChamsHooked[m]) do
				conn:Disconnect()
			end
		end
		L.ChamsHooked[m] = nil
	end)
end
for _, folder in ipairs(PlayersFolder:GetChildren()) do
	if folder and folder:IsA("Folder") then
		hookChamsFolder(folder)
	end
end
PlayersFolder.ChildAdded:Connect(function(folder)
	if folder and folder:IsA("Folder") then
		hookChamsFolder(folder)
	end
end)
				local function createDistance(model)
					if L.DistanceDrawings[model] then return end
					local d=Drawing.new("Text")
					d.Center=true
					d.Outline=true
					d.Size=13
					if table.find(SafeFonts, L.CurrentFont) then d.Font = L.CurrentFont end
					d.Color=L.DistanceTextColor
					d.Visible=false
					L.DistanceDrawings[model]=d
				end
				local function createWeapon(model)
					if L.WeaponDrawings[model] then return end
					local d=Drawing.new("Text")
					d.Center=true
					d.Outline=true
					d.Size=13
					if table.find(SafeFonts, L.CurrentFont) then d.Font = L.CurrentFont end
					d.Color=L.WeaponTextColor
					d.Visible=false
					L.WeaponDrawings[model]=d
				end
				local function removeDistance(model)
					if L.DistanceDrawings[model] then
						L.DistanceDrawings[model]:Remove()
						L.DistanceDrawings[model]=nil
					end
					if L.WeaponDrawings[model] then
						L.WeaponDrawings[model]:Remove()
						L.WeaponDrawings[model]=nil
					end
					L.DistanceTorsoCache[model]=nil
				end
				local function hookDistanceModel(model)
					if not model:IsA("Model") then return end
					createDistance(model)
					createWeapon(model)
					for _,c in ipairs(model:GetChildren()) do
						if c:IsA("Model") then
							createDistance(c)
							createWeapon(c)
						end
					end
				end
				for _,folder in ipairs(PlayersFolder:GetChildren()) do
					if folder:IsA("Folder") then
						for _,model in ipairs(folder:GetChildren()) do
							hookDistanceModel(model)
						end
						folder.ChildAdded:Connect(hookDistanceModel)
						folder.ChildRemoved:Connect(removeDistance)
					end
				end
				PlayersFolder.ChildAdded:Connect(function(folder)
					if folder:IsA("Folder") then
						folder.ChildAdded:Connect(hookDistanceModel)
						folder.ChildRemoved:Connect(removeDistance)
					end
				end)
				local function getNameHead(model)
					local c = L.NameHeadCache[model]
					if c == false then return nil end
					if c and c:IsDescendantOf(model) then return c end
					for _, v in ipairs(model:GetDescendants()) do
						if v:IsA("MeshPart") and v.MeshId and v.MeshId:find(L.MESH_IDS.Head) then
							L.NameHeadCache[model] = v
							return v
						end
					end
					L.NameHeadCache[model] = false
					return nil
				end
				local function getPlayerName(model)
	local cached = L.NameCache[model]
	if cached ~= nil then
		return cached == false and nil or cached
	end
	for _, v in ipairs(model:GetDescendants()) do
		if v:IsA("TextLabel") and v.Name == "PlayerTag" then
			L.NameCache[model] = v.Text
			return v.Text
		end
	end
	L.NameCache[model] = false
	return nil
end
				local function createName(model)
					if L.NameDrawings[model] then return end
					local t = Drawing.new("Text")
					t.Center = true
					t.Outline = true
					t.Size = 13
					if table.find(SafeFonts, L.CurrentFont) then t.Font = L.CurrentFont end
					t.Color = L.NameTextColor or Color3.new(1,1,1)
					t.Visible = false
					L.NameDrawings[model] = t
				end
				local function removeName(model)
					if L.NameDrawings[model] then
						L.NameDrawings[model]:Remove()
						L.NameDrawings[model] = nil
					end
					L.NameHeadCache[model] = nil
				end
				local function hookNameModel(model)
					if not model:IsA("Model") then return end
					createName(model)
					for _, c in ipairs(model:GetChildren()) do
						if c:IsA("Model") then
							createName(c)
						end
					end
				end
				for _, folder in ipairs(PlayersFolder:GetChildren()) do
					if folder:IsA("Folder") then
						for _, model in ipairs(folder:GetChildren()) do
							hookNameModel(model)
						end
						folder.ChildAdded:Connect(hookNameModel)
						folder.ChildRemoved:Connect(removeName)
					end
				end
				PlayersFolder.ChildAdded:Connect(function(folder)
					if folder:IsA("Folder") then
						folder.ChildAdded:Connect(hookNameModel)
						folder.ChildRemoved:Connect(removeName)
					end
				end)
local FOVCachedTarget = nil
local FOVNextTargetUpdate = 0
RunService.RenderStepped:Connect(function(dt)
	local mousePos = UserInputService:GetMouseLocation()
	local baseFOV = L.FOVRadius
	local targetFOV = baseFOV
	if L.DynamicFOVEnabled and L.HoldingKey then
		targetFOV = baseFOV * L.DynamicFOVMultiplier
	end
	local speed = (targetFOV > L.CurrentFOVRadius) and L.DynamicFOVSpeedIn or L.DynamicFOVSpeedOut
	L.CurrentFOVRadius = L.CurrentFOVRadius + (targetFOV - L.CurrentFOVRadius) * speed
	local fovOrigin
	local validFovOrigin = false
	if L.FovPositionMethod == "Gun Barrel" then
		if not L.HasKnife and L.GunBarrel and L.GunBarrel:IsDescendantOf(Camera) then
			local forwardOffset = 7.5
			local worldPos = L.GunBarrel.Position + (L.GunBarrel.CFrame.LookVector * forwardOffset)
			local v, onScreen = Camera:WorldToViewportPoint(worldPos)
			if onScreen then
				fovOrigin = Vector2.new(v.X, v.Y)
				validFovOrigin = true
			end
		end
		if not validFovOrigin and not L.HasKnife then
			if L.LastGunBarrelTime and (os.clock() - L.LastGunBarrelTime) < 1 then
			else
				fovOrigin = mousePos
				validFovOrigin = true
			end
		end
	else
		fovOrigin = mousePos
		validFovOrigin = true
	end
	if L.FOVLockOnTarget and L.AimbotEnabled then
		local now = os.clock()
		if L.LockedTarget and L.LockedTarget:IsDescendantOf(workspace) then
			FOVCachedTarget = L.LockedTarget
			FOVNextTargetUpdate = now + L.TARGET_UPDATE_RATE
		elseif now >= FOVNextTargetUpdate then
			FOVCachedTarget = getClosestTarget()
			FOVNextTargetUpdate = now + L.TARGET_UPDATE_RATE
		end
		if FOVCachedTarget and FOVCachedTarget:IsDescendantOf(workspace) then
			local pos, onScreen = Camera:WorldToViewportPoint(FOVCachedTarget.Position)
			if onScreen then
				local targetPos = Vector2.new(pos.X, pos.Y)
				if not L.FOVCurrentOrigin then
					L.FOVCurrentOrigin = fovOrigin
				end
				L.FOVCurrentOrigin = L.FOVCurrentOrigin:Lerp(targetPos, math.clamp(dt * 22.5, 0, 1))
				fovOrigin = L.FOVCurrentOrigin
				validFovOrigin = true
			else
				if L.FOVCurrentOrigin and (L.FOVCurrentOrigin - fovOrigin).Magnitude > 1 then L.FOVCurrentOrigin = L.FOVCurrentOrigin:Lerp(fovOrigin, math.clamp(dt*22.5,0,1)) fovOrigin = L.FOVCurrentOrigin else L.FOVCurrentOrigin = nil end
			end
		else
			if L.FOVCurrentOrigin and (L.FOVCurrentOrigin - fovOrigin).Magnitude > 1 then L.FOVCurrentOrigin = L.FOVCurrentOrigin:Lerp(fovOrigin, math.clamp(dt*22.5,0,1)) fovOrigin = L.FOVCurrentOrigin else L.FOVCurrentOrigin = nil end
		end
	else
		if L.FOVCurrentOrigin and (L.FOVCurrentOrigin - fovOrigin).Magnitude > 1 then L.FOVCurrentOrigin = L.FOVCurrentOrigin:Lerp(fovOrigin, math.clamp(dt*22.5,0,1)) fovOrigin = L.FOVCurrentOrigin else L.FOVCurrentOrigin = nil end
	end
	FOVCircle.Visible = validFovOrigin and L.ShowFOV
	FOVOutline.Visible = validFovOrigin and L.ShowFOV
	L.FOVFill.Visible = validFovOrigin and L.ShowFOV
	if validFovOrigin then
		FOVCircle.Position = fovOrigin
		FOVOutline.Position = fovOrigin
		L.FOVFill.Position = fovOrigin
		FOVCircle.Radius = L.CurrentFOVRadius
		FOVOutline.Radius = L.CurrentFOVRadius
		L.FOVFill.Radius = L.CurrentFOVRadius
		FOVCircle.Color = L.FOVColor
		if Options["L.FOVFillColor"] then
			L.FOVFill.Color = L.FOVFillColor or Color3.fromRGB(83,132,171)
			L.FOVFill.Transparency = 1 - Options["L.FOVFillColor"].Transparency
		end
	end
	if not L.AimbotEnabled or not L.HoldingKey or not validFovOrigin then
		L.LockedTarget = nil
		return
	end
	local now = os.clock()
	if L.StickyAim then
		if not L.LockedTarget or not L.LockedTarget:IsDescendantOf(workspace) then
			if now >= L.NextTargetUpdate then
				L.LockedTarget = getClosestTarget()
				L.CachedTarget = L.LockedTarget
				L.NextTargetUpdate = now + L.TARGET_UPDATE_RATE
			else
				L.LockedTarget = L.CachedTarget
			end
		end
	else
		if now >= L.NextTargetUpdate then
			L.LockedTarget = getClosestTarget()
			L.CachedTarget = L.LockedTarget
			L.NextTargetUpdate = now + L.TARGET_UPDATE_RATE
		else
			L.LockedTarget = L.CachedTarget
		end
	end
if L.LockedTarget then
	local targetPos3D = L.LockedTarget.Position
	if (L.AimbotPredDropEnabled or L.AimbotPredictionEnabled) and L.activeWeaponInterface and L.publicSettings then
		local activeController = L.activeWeaponInterface.getActiveWeaponController and L.activeWeaponInterface.getActiveWeaponController()
		local activeWeapon = activeController and activeController:getActiveWeapon()
		if activeWeapon then
			local targetVelocity = Vector3.zero
			if L.AimbotPredictionEnabled and L.movementCache then
				local player
				local targetModel = L.LockedTarget
				for _=1, 4 do
					if targetModel and targetModel:IsA("Model") and targetModel:FindFirstChild("PlayerTag", true) then
						break
					end
					if targetModel then targetModel = targetModel.Parent end
				end
				if targetModel then
					local targetName = getPlayerName(targetModel)
					if targetName then
						for _, p in pairs(Players:GetPlayers()) do
							if p.Name == targetName or p.DisplayName == targetName then
								player = p
								break
							end
						end
					end
				end
				if player and L.movementCache.position[player] and L.movementCache.position[player][15] and L.movementCache.time[15] then
					targetVelocity = (L.movementCache.position[player][15] - L.movementCache.position[player][1]) / (L.movementCache.time[15] - L.movementCache.time[1])
				end
			end
			local speed = activeWeapon._weaponData.bulletspeed or 10000
			local accel = L.AimbotPredDropEnabled and (L.publicSettings.bulletAcceleration or Vector3.new(0, -workspace.Gravity, 0)) or Vector3.zero
			local origin = Camera.CFrame.Position
			local velocity, time = L.complexTrajectory(origin, accel, targetPos3D, speed, targetVelocity)
			if time and time > 0 then
				if L.AimbotPredictionEnabled then
					targetPos3D = targetPos3D + (targetVelocity * time)
				end
				if L.AimbotPredDropEnabled then
					targetPos3D = targetPos3D - (0.5 * accel * time * time)
				end
			end
		end
	end
	local pos = Camera:WorldToViewportPoint(targetPos3D)
	local targetPos = Vector2.new(pos.X, pos.Y)
	local diff = targetPos - mousePos
	local dist = diff.Magnitude
	if dist > 0 then
		local maxStep = L.AimVelocity * dt
		local move
		if dist <= maxStep then
			move = diff
		else
			move = diff.Unit * maxStep
		end
		mousemoverel(move.X, move.Y)
	end
end
end)
local OriginalSky = Lighting:FindFirstChild("OriginalSkyBackup")
if not OriginalSky then
	local current = Lighting:FindFirstChildOfClass("Sky")
	if current then
		OriginalSky = current:Clone()
		OriginalSky.Name = "OriginalSkyBackup"
		OriginalSky.Parent = Lighting
	end
end
				local function ApplySky(name)
					local data = L.Skyboxes[name]
					if not data then return end
					local sky = Lighting:FindFirstChildOfClass("Sky")
					if sky then sky:Destroy() end
					sky = Instance.new("Sky")
					sky.SkyboxBk = data.Bk
					sky.SkyboxDn = data.Dn
					sky.SkyboxFt = data.Ft
					sky.SkyboxLf = data.Lf
					sky.SkyboxRt = data.Rt
					sky.SkyboxUp = data.Up
					sky.Parent = Lighting
				end
				local function RestoreSky()
					local sky = Lighting:FindFirstChildOfClass("Sky")
					if sky then sky:Destroy() end
					if OriginalSky then
						OriginalSky:Clone().Parent = Lighting
					end
				end
				if L.SkyboxEnabled then
					ApplySky(L.SelectedSky)
				else
					RestoreSky()
				end
local aimbotSnapAlpha = 0
local aimbotSnapWasDrawing = false
RunService.RenderStepped:Connect(function(dt)
	if not L.SnapEnabled then
		SnapLine.Visible = false
		SnapOutline.Visible = false
		aimbotSnapWasDrawing = false
		return
	end
	local now = os.clock()
	if L.LockedTarget then
		L.CachedTarget = L.LockedTarget
	elseif now >= L.NextTargetUpdate then
		L.CachedTarget = getClosestTarget()
		L.NextTargetUpdate = now + L.TARGET_UPDATE_RATE
	end
	local target = L.CachedTarget
	if not target or not target:IsDescendantOf(workspace) then
		SnapLine.Visible = false
		SnapOutline.Visible = false
		aimbotSnapWasDrawing = false
		return
	end
	local pos, onScreen = Camera:WorldToViewportPoint(target.Position)
	if not onScreen then
		SnapLine.Visible = false
		SnapOutline.Visible = false
		aimbotSnapWasDrawing = false
		return
	end
	local origin
	if L.SnapLineMethod == "Gun Barrel" then
		if L.HasKnife or not L.GunBarrel or not L.GunBarrel:IsDescendantOf(Camera) then
			SnapLine.Visible = false
			SnapOutline.Visible = false
			aimbotSnapWasDrawing = false
			return
		end
		local v, onscreen = Camera:WorldToViewportPoint(L.GunBarrel.Position)
		if not onscreen then
			SnapLine.Visible = false
			SnapOutline.Visible = false
			aimbotSnapWasDrawing = false
			return
		end
		origin = Vector2.new(v.X, v.Y)
	else
		origin = UserInputService:GetMouseLocation()
	end
	local targetPos = Vector2.new(pos.X, pos.Y)
	if not aimbotSnapWasDrawing then
		aimbotSnapAlpha = 0
	end
	aimbotSnapWasDrawing = true
	aimbotSnapAlpha = math.clamp(aimbotSnapAlpha + (dt / 0.1), 0, 1)
	SnapOutline.From = origin
	SnapOutline.To = targetPos
	SnapOutline.Transparency = aimbotSnapAlpha
	SnapOutline.Visible = true
	SnapLine.From = origin
	SnapLine.To = targetPos
	SnapLine.Transparency = aimbotSnapAlpha
	SnapLine.Visible = true
end)
				UserInputService.InputBegan:Connect(function(input, gp)
					if gp then return end
					if input.KeyCode == Enum.KeyCode.Space then
						L.HoldingJump = true
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.Space then
						L.HoldingJump = false
						local char = L.charInterface and L.charInterface.getCharacterObject()
						local hum = char and char._humanoid
						if hum then
							hum.Jump = false
						end
					end
				end)
				RunService.Heartbeat:Connect(function()
					if not L.NoJumpCooldownEnabled or not L.HoldingJump then return end
					local char = L.charInterface and L.charInterface.getCharacterObject()
					local hum = char and char._humanoid
					if hum and hum.Health > 0 then
						hum.Jump = true
					end
				end)
				local function collect()
					table.clear(L.Roots)
					table.clear(L.BaseCF)
					for _, model in ipairs(Camera:GetChildren()) do
						if model:IsA("Model") then
							local root = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
							if root then
								model.PrimaryPart = root
								L.Roots[#L.Roots + 1] = root
								L.BaseCF[root] = root.CFrame
							end
						end
					end
				end
				RunService:BindToRenderStep(
					"ViewModelUpdater",
					Enum.RenderPriority.Last.Value,
					function(dt)
						if not L.ViewModelEnabled then return end
						L.LastScan += dt
						if L.LastScan >= L.ScanInterval then
							L.LastScan = 0
							collect()
						end
						for _, root in ipairs(L.Roots) do
							local base = L.BaseCF[root]
							if root and base then
								root.CFrame = Camera.CFrame * CFrame.new(L.Offset) * (Camera.CFrame:Inverse() * base)
							end
						end
					end
				)
				local function reset()
					for root, cf in pairs(L.BaseCF) do
						if root and root:IsDescendantOf(Camera) then
							root.CFrame = cf
						end
					end
				end
				local function createBox1(model)
					if L.BoxDrawings[model] then return end
					local outline = Drawing.new("Square")
					outline.Color = Color3.new(0, 0, 0)
					outline.Thickness = L.BoxOutlineThickness or 3
					outline.Filled = false
					outline.Visible = false
					local box = Drawing.new("Square")
					box.Color = L.BoxColor
					box.Thickness = L.BoxThickness or 1
					box.Filled = false
					box.Visible = false
					L.BoxFillDrawings = L.BoxFillDrawings or {}
					L.BoxFillDrawings[model] = Drawing.new("Square")
					L.BoxFillDrawings[model].Color = L.BoxFillColor or Color3.fromRGB(84, 132, 171)
					L.BoxFillDrawings[model].Thickness = 0
					L.BoxFillDrawings[model].Filled = true
					L.BoxFillDrawings[model].Visible = false
					L.BoxOutlineDrawings[model] = outline
					L.BoxDrawings[model] = box
				end
				local function removeBox(model)
					if L.BoxDrawings[model] then
						L.BoxDrawings[model]:Remove()
						L.BoxDrawings[model] = nil
					end
					if L.BoxOutlineDrawings[model] then
						L.BoxOutlineDrawings[model]:Remove()
						L.BoxOutlineDrawings[model] = nil
					end
					if L.BoxFillDrawings and L.BoxFillDrawings[model] then
						L.BoxFillDrawings[model]:Remove()
						L.BoxFillDrawings[model] = nil
					end
				end
				local function hookBoxModel(model)
					if not model:IsA("Model") then return end
					createBox1(model)
					for _, c in ipairs(model:GetChildren()) do
						if c:IsA("Model") then
							createBox1(c)
						end
					end
				end
				for _, folder in ipairs(PlayersFolder:GetChildren()) do
					if folder:IsA("Folder") then
						for _, model in ipairs(folder:GetChildren()) do
							hookBoxModel(model)
						end
						folder.ChildAdded:Connect(hookBoxModel)
						folder.ChildRemoved:Connect(removeBox)
					end
				end
				PlayersFolder.ChildAdded:Connect(function(folder)
					if folder:IsA("Folder") then
						folder.ChildAdded:Connect(hookBoxModel)
						folder.ChildRemoved:Connect(removeBox)
					end
				end)
				for _, root in ipairs(WeaponRoots) do
					for _, obj in ipairs(root:GetDescendants()) do
						if obj:IsA("ModuleScript") then
							local ok, data = pcall(require, obj)
							if ok and type(data) == "table" and type(data.firesoundid) == "string" then
								L.ValidSoundIds[data.firesoundid] = true
							end
						end
					end
				end
				local function applySound(s)
					if not s:IsA("Sound") then return end
					if not L.ValidSoundIds[s.SoundId] then return end
					if not L.SoundBackup[s] then
						L.SoundBackup[s] = {
							Id = s.SoundId,
							Volume = s.Volume
						}
					end
					local id = L.SoundMap[L.SelectedSound]
					if id and s.SoundId ~= id then
						s.SoundId = id
					end
					s.Volume = L.SoundVolume
				end
				local function restoreSound(s)
					local old = L.SoundBackup[s]
					if old then
						s.SoundId = old.Id
						s.Volume = old.Volume
						L.SoundBackup[s] = nil
					end
				end
				local function scan(m)
					for _, v in ipairs(m:GetDescendants()) do
						if v:IsA("Sound") then
							if L.GunshotOverride then
								applySound(v)
							else
								restoreSound(v)
							end
						end
					end
				end
				RunService.RenderStepped:Connect(function()
					local cam = Camera
					if not cam then return end
					for _, obj in ipairs(cam:GetChildren()) do
						if obj:IsA("Model") then
							scan(obj)
						end
					end
				end)
				L.CoreGui = game:GetService("CoreGui")
				L.MiniUI = Instance.new("ScreenGui")
				L.MiniUI.Name = "MiniLibUI"
				L.MiniUI.ZIndexBehavior = Enum.ZIndexBehavior.Global
				L.MiniUI.ResetOnSpawn = false
				L.MiniUI.DisplayOrder = 999999999
				L.MiniUI.Enabled = false
				L.ProtectGui = protectgui or (syn and syn.protect_gui) or function() end
				pcall(L.ProtectGui, L.MiniUI)
				L.Success = pcall(function()
					L.MiniUI.Parent = L.CoreGui
				end)
				if not L.Success then
					L.MiniUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
				end
				L.MiniMainColor = Color3.fromRGB(22, 22, 22)
				L.MiniBackgroundColor = Color3.fromRGB(19, 19, 19)
				L.MiniAccentColor = Color3.fromRGB(131, 146, 255)
				L.MiniOutlineColor = Color3.fromRGB(30, 30, 30)
				L.MiniBlackColor = Color3.new(0, 0, 0)
				L.MiniOuterBorder = Instance.new("Frame")
				L.MiniOuterBorder.Name = "OuterBorder"
				L.MiniOuterBorder.BackgroundColor3 = L.MiniBlackColor
				L.MiniOuterBorder.BorderColor3 = L.MiniBlackColor
				L.MiniOuterBorder.BorderSizePixel = 0
				L.MiniOuterBorder.Position = UDim2.new(0.5, -45, 0.5, 40)
				L.MiniOuterBorder.Size = UDim2.new(0, 66, 0, 26)
				L.MiniOuterBorder.Parent = L.MiniUI
				L.MiniDragButton = Instance.new("TextButton")
				L.MiniDragButton.Name = "DragButton"
				L.MiniDragButton.Size = UDim2.new(1, 40, 1, 40)
				L.MiniDragButton.Position = UDim2.new(0, -20, 0, -20)
				L.MiniDragButton.BackgroundTransparency = 1
				L.MiniDragButton.Text = ""
				L.MiniDragButton.ZIndex = 10
				L.MiniDragButton.Parent = L.MiniOuterBorder
				L.MiniDragButton.Active = true
				L.MiniMainOutline = Instance.new("Frame")
				L.MiniMainOutline.Name = "MainOutline"
				L.MiniMainOutline.BackgroundColor3 = L.MiniOutlineColor
				L.MiniMainOutline.BorderSizePixel = 0
				L.MiniMainOutline.Position = UDim2.new(0, 1, 0, 1)
				L.MiniMainOutline.Size = UDim2.new(1, -2, 1, -2)
				L.MiniMainOutline.Parent = L.MiniOuterBorder
				L.MiniInnerBorder = Instance.new("Frame")
				L.MiniInnerBorder.Name = "InnerBorder"
				L.MiniInnerBorder.BackgroundColor3 = L.MiniBlackColor
				L.MiniInnerBorder.BorderSizePixel = 0
				L.MiniInnerBorder.Position = UDim2.new(0, 1, 0, 1)
				L.MiniInnerBorder.Size = UDim2.new(1, -2, 1, -2)
				L.MiniInnerBorder.Parent = L.MiniMainOutline
				L.MiniBackground = Instance.new("Frame")
				L.MiniBackground.Name = "Background"
				L.MiniBackground.BackgroundColor3 = L.MiniBackgroundColor
				L.MiniBackground.BorderSizePixel = 0
				L.MiniBackground.Position = UDim2.new(0, 1, 0, 1)
				L.MiniBackground.Size = UDim2.new(1, -2, 1, -2)
				L.MiniBackground.Parent = L.MiniInnerBorder
				L.MiniAccentLine = Instance.new("Frame")
				L.MiniAccentLine.Name = "AccentLine"
				L.MiniAccentLine.BackgroundColor3 = Library.AccentColor
				L.MiniAccentLine.BorderSizePixel = 0
				L.MiniAccentLine.Position = UDim2.new(0, 0, 0, 0)
				L.MiniAccentLine.Size = UDim2.new(1, 0, 0, 1)
				L.MiniAccentLine.Parent = L.MiniBackground
				L.AmmoLabel = Instance.new("TextLabel")
				L.AmmoLabel.Name = "ValueLabel"
				L.AmmoLabel.BackgroundTransparency = 1
				L.AmmoLabel.Position = UDim2.new(0, 0, 0, 0)
				L.AmmoLabel.Size = UDim2.new(1, 0, 1, 0)
				L.AmmoLabel.Font = Enum.Font.BuilderSans
				L.AmmoLabel.Text = "0/0"
				L.AmmoLabel.LineHeight = 1.1
				L.AmmoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				L.AmmoLabel.TextSize = 15
				L.AmmoLabel.TextStrokeTransparency = 0
				L.AmmoLabel.Parent = L.MiniBackground
				L.MiniUIPadding = Instance.new("UIPadding")
				L.MiniUIPadding.Parent = L.AmmoLabel
				L.MiniUITextSizeConstraint = Instance.new("UITextSizeConstraint")
				L.MiniUITextSizeConstraint.MaxTextSize = 17
				L.MiniUITextSizeConstraint.MinTextSize = 14
				L.MiniUITextSizeConstraint.Parent = L.AmmoLabel
				L.MiniDragButton.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						L.MiniDragging = true
						L.MiniDragStart = input.Position
						L.MiniStartPos = L.MiniOuterBorder.Position
					end
				end)
				L.MiniDragButton.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						if L.MiniDragging then
							local delta = input.Position - L.MiniDragStart
							L.MiniOuterBorder.Position = UDim2.new(L.MiniStartPos.X.Scale, L.MiniStartPos.X.Offset + delta.X, L.MiniStartPos.Y.Scale, L.MiniStartPos.Y.Offset + delta.Y)
						end
					end
				end)
				L.MiniDragButton.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						L.MiniDragging = false
					end
				end)
				L.HealthDrawings = L.HealthDrawings or {}
				L.HealthOutlineDrawings = L.HealthOutlineDrawings or {}
				L.HealthTextDrawings = L.HealthTextDrawings or {}
				local BAR_WIDTH = 2
				local OUTLINE_WIDTH = 4
				local function createHealth(model)
					if L.HealthDrawings[model] then return end
					local outline = Drawing.new("Square")
					outline.Color = Color3.new(0, 0, 0)
					outline.Thickness = 1
					outline.Filled = true
					outline.ZIndex = 10
					outline.Visible = false
					local segments = {}
					for i = 1, 80 do
						local bar = Drawing.new("Square")
						bar.Thickness = 0
						bar.Filled = true
						bar.ZIndex = 11
						bar.Visible = false
						segments[i] = bar
					end
					local hText = Drawing.new("Text")
					hText.Size = 13
					hText.Outline = true
					hText.Center = true
					hText.ZIndex = 12
					if table.find(SafeFonts, L.CurrentFont) then hText.Font = L.CurrentFont end
					hText.Visible = false
					L.HealthOutlineDrawings[model] = outline
					L.HealthDrawings[model] = segments
					L.HealthTextDrawings[model] = hText
				end
				local function removeHealth(model)
					if L.HealthDrawings[model] then
						for _, bar in ipairs(L.HealthDrawings[model]) do
							bar:Remove()
						end
						L.HealthDrawings[model] = nil
					end
					if L.HealthOutlineDrawings[model] then
						L.HealthOutlineDrawings[model]:Remove()
						L.HealthOutlineDrawings[model] = nil
					end
					if L.HealthTextDrawings[model] then
						L.HealthTextDrawings[model]:Remove()
						L.HealthTextDrawings[model] = nil
					end
				end
				L.HealthCache = L.HealthCache or {}
				local function getEntryByModel(model)
					local cached = L.EntryCache[model]
					if cached ~= nil then return cached end
					if not L.SilentRE then return nil end
					local foundEntry = nil
					local name = model.Name
					local player = game:GetService("Players"):FindFirstChild(name)
					if player then
						foundEntry = L.SilentRE.getEntry(player)
					end
					if not foundEntry then
						local foundName = getPlayerName(model)
						if foundName then
							local foundPlayer = game:GetService("Players"):FindFirstChild(foundName)
							if foundPlayer then
								foundEntry = L.SilentRE.getEntry(foundPlayer)
							end
						end
					end
					if not foundEntry then
						L.SilentRE.operateOnAllEntries(function(plr, entry)
							if foundEntry then return end
							local tp = entry.getThirdPersonObject and entry:getThirdPersonObject()
							if tp and tp.getCharacterModel and tp:getCharacterModel() == model then
								foundEntry = entry
							end
						end)
					end
					if L.SilentRE then
						local res = foundEntry or false
						L.EntryCache[model] = res
					end
					return foundEntry
				end
				local function getHealthScale(model)
					local entry = getEntryByModel(model)
					if entry and entry.getHealth then
						local h = entry:getHealth()
						if type(h) == "number" then
							return math.clamp(h / 100, 0, 1)
						end
					end
					local ch = L.HealthCache[model]
					if ch == false then return 1 end
					if ch and ch:IsDescendantOf(model) then
						local scale = ch.Size.X.Scale
						if scale ~= scale then return 1 end
						return math.clamp(scale, 0, 1)
					end
					for _, d in ipairs(model:GetDescendants()) do
						if d:IsA("Frame") and d.Name == "Percent" then
							local health = d:FindFirstAncestor("Health")
							if health then
								local tag = health:FindFirstAncestor("PlayerTag")
								if tag and tag:FindFirstAncestor("NameTagGui") then
									L.HealthCache[model] = d
									local scale = d.Size.X.Scale
									if scale ~= scale then return 1 end
									return math.clamp(scale, 0, 1)
								end
							end
						end
					end
					L.HealthCache[model] = false
					return 1
				end
				local function hookHealthModel(model)
					if not model:IsA("Model") then return end
					createHealth(model)
					for _, c in ipairs(model:GetChildren()) do
						if c:IsA("Model") then
							createHealth(c)
						end
					end
				end
				for _, folder in ipairs(PlayersFolder:GetChildren()) do
					if folder:IsA("Folder") then
						for _, model in ipairs(folder:GetChildren()) do
							hookHealthModel(model)
						end
						folder.ChildAdded:Connect(hookHealthModel)
						folder.ChildRemoved:Connect(removeHealth)
					end
				end
				PlayersFolder.ChildAdded:Connect(function(folder)
					if folder:IsA("Folder") then
						folder.ChildAdded:Connect(hookHealthModel)
						folder.ChildRemoved:Connect(removeHealth)
					end
				end)
				local lastESPUpdate = 0
				RunService.RenderStepped:Connect(function(dt)
					for m, d in pairs(L.DistanceDrawings) do if not m.Parent then d:Remove() L.DistanceDrawings[m]=nil if L.WeaponDrawings[m] then L.WeaponDrawings[m]:Remove() L.WeaponDrawings[m]=nil end end end
					for m, d in pairs(L.NameDrawings) do if not m.Parent then d:Remove() L.NameDrawings[m]=nil end end
					for m, box in pairs(L.BoxDrawings) do if not m.Parent then box:Remove() L.BoxDrawings[m]=nil if L.BoxOutlineDrawings[m] then L.BoxOutlineDrawings[m]:Remove() L.BoxOutlineDrawings[m]=nil end if L.BoxFillDrawings and L.BoxFillDrawings[m] then L.BoxFillDrawings[m]:Remove() L.BoxFillDrawings[m]=nil end end end
					for m, arr in pairs(L.HealthDrawings) do if not m.Parent then for _,l in ipairs(arr) do l:Remove() end L.HealthDrawings[m]=nil if L.HealthOutlineDrawings[m] then L.HealthOutlineDrawings[m]:Remove() L.HealthOutlineDrawings[m]=nil end if L.HealthTextDrawings[m] then L.HealthTextDrawings[m]:Remove() L.HealthTextDrawings[m]=nil end end end
					local now = os.clock()
					local distEnabled = L.DistanceESPEnabled
					local weaponEnabled = L.WeaponESPEnabled
					local nameEnabled = L.NameESPEnabled
					local boxEnabled = L.BoxESPEnabled
					local healthEnabled = L.HealthESPEnabled
					local chamsEnabled = L.ChamsEnabled
					if now - lastESPUpdate < 1/120 then return end
					lastESPUpdate = now
					for _, t in pairs(L.DistanceDrawings) do if not distEnabled then t.Visible = false end end
					for _, t in pairs(L.WeaponDrawings) do if not weaponEnabled then t.Visible = false end end
					for _, t in pairs(L.NameDrawings) do if not nameEnabled then t.Visible = false end end
					for _, b in pairs(L.BoxDrawings) do
						if not boxEnabled then
							b.Visible = false
						end
					end
					for _, o in pairs(L.BoxOutlineDrawings) do
						if not boxEnabled then
							o.Visible = false
						end
					end
					if L.BoxFillDrawings then
						for _, f in pairs(L.BoxFillDrawings) do
							if not (L.BoxFillEnabled and boxEnabled) then f.Visible = false end
						end
					end
					for _, hTable in pairs(L.HealthDrawings) do
						if not healthEnabled then
							for i = 1, 80 do hTable[i].Visible = false end
						end
					end
					for _, o in pairs(L.HealthOutlineDrawings) do if not healthEnabled then o.Visible = false end end
					if not (distEnabled or weaponEnabled or nameEnabled or boxEnabled or healthEnabled or chamsEnabled) then return end
					local camPos = Camera.CFrame.Position
					local maxDist = L.DistanceMax or 750
					for model, _ in pairs(L.DistanceDrawings) do
						local textName = L.NameDrawings[model]
						local textWeapon = L.WeaponDrawings[model]
						local textDist = L.DistanceDrawings[model]
						local boxes = L.BoxDrawings[model]
						local outlines = L.BoxOutlineDrawings[model]
						local healthBar = L.HealthDrawings[model]
						local healthOutline = L.HealthOutlineDrawings[model]
						local healthText = L.HealthTextDrawings[model]
						local shouldShow = true
						local torso, dist, topPos, bottomPos, topVis, bottomVis, topWorld, bottomWorld, nameWorld
						if not model:IsDescendantOf(PlayersFolder) then
							shouldShow = false
						end
						if shouldShow then
							torso = getTorso(model)
							if not torso or not checkEnemyByModel(model) then
								shouldShow = false
							end
						end
						if shouldShow then
							dist = (camPos - torso.Position).Magnitude
							if dist > maxDist or not isOnScreen(torso) then
								shouldShow = false
							end
						end
						if shouldShow then
							topWorld = torso.Position + Vector3.new(0, 3, 0)
							bottomWorld = torso.Position - Vector3.new(0, 3.5, 0)
							nameWorld = torso.Position + Vector3.new(0, 3.5, 0)
							topPos, topVis = Camera:WorldToViewportPoint(topWorld)
							bottomPos, bottomVis = Camera:WorldToViewportPoint(bottomWorld)
							if not topVis or not bottomVis then
								shouldShow = false
							end
						end
						if not shouldShow then
							L.FadeCache[model] = nil
							if textName then textName.Visible = false end
							if textWeapon then textWeapon.Visible = false end
							if textDist then textDist.Visible = false end
							if boxes then boxes.Visible = false end
							if outlines then outlines.Visible = false end
							if L.BoxFillDrawings and L.BoxFillDrawings[model] then L.BoxFillDrawings[model].Visible = false end
							if healthBar then for i = 1, 80 do healthBar[i].Visible = false end end
							if healthOutline then healthOutline.Visible = false end
							if healthText then
								healthText.Visible = false
								L.HealthTextFadeCache[model] = nil
							end
							local activeChams = L.ActiveChams[model]
							if activeChams then
								for i = 1, #activeChams do
									local b = activeChams[i]
									if b:IsA("Highlight") then
										b.Enabled = false
										b.FillTransparency = 1
										b.OutlineTransparency = 1
									else
										b.Visible = false
										b.Transparency = 1
									end
								end
							end
							continue
						end
						local startTime = L.FadeCache[model]
						if not startTime then
							startTime = now
							L.FadeCache[model] = startTime
						end
						local fadeAlpha = math.clamp((now - startTime) / L.FadeTime, 0, 1)
						local height = math.floor(math.abs(topPos.Y - bottomPos.Y))
						local width = math.floor(height * 0.55)
						local x = math.floor(topPos.X - width / 2)
						local y = math.floor(topPos.Y)
						local function applyFontCase(txt)
							if not txt then return txt end
							local case = L.FontCase or Options.FontCaseDropdown and Options.FontCaseDropdown.Value or "Normal"
							if case == "Lowercase" then return string.lower(txt)
							elseif case == "Uppercase" then return string.upper(txt)
							elseif case == "Normal" then
								return (string.lower(txt):gsub("^%l", string.upper):gsub("[%s%p]%l", string.upper))
							end
							return txt
						end
						if textName and nameEnabled then
							local name = getPlayerName(model)
							if name then
								textName.Position = Vector2.new(x + width / 2, y - 15)
								textName.Text = applyFontCase(name)
								textName.Transparency = fadeAlpha
								textName.Visible = true
							else
								textName.Visible = false
							end
						elseif textName then textName.Visible = false end
						if textWeapon and weaponEnabled then
							local weaponName = "Unknown"
							if L.SilentRE then
								local targetName = getPlayerName(model)
								for _, player in pairs(Players:GetPlayers()) do
									if targetName and (player.Name == targetName or player.DisplayName == targetName) then
										local entry = L.SilentRE.getEntry(player)
										if entry then
											local pWeaponObj = entry:getWeaponObject()
											if pWeaponObj and pWeaponObj.weaponName then
												weaponName = pWeaponObj.weaponName
											end
										end
										break
									end
								end
							end
							textWeapon.Position = Vector2.new(x + width / 2, y + height)
							textWeapon.Text = applyFontCase(weaponName)
							textWeapon.Color = L.WeaponTextColor
							textWeapon.Transparency = fadeAlpha
							textWeapon.Visible = true
						elseif textWeapon then textWeapon.Visible = false end
						if textDist and distEnabled then
							textDist.Position = Vector2.new(x + width / 2, y + height + (weaponEnabled and 13 or 0))
							textDist.Text = math.floor(dist).."s"
							textDist.Color = L.DistanceTextColor
							textDist.Transparency = fadeAlpha
							textDist.Visible = true
						elseif textDist then textDist.Visible = false end
						if boxes and outlines and boxEnabled then
							boxes.Visible = true
							outlines.Visible = true
							boxes.Color = L.BoxColor
							outlines.Color = Color3.new(0,0,0)
							boxes.Transparency = fadeAlpha
							outlines.Transparency = fadeAlpha
							local tl = Vector2.new(x, y)
							local sz = Vector2.new(width, height)
							boxes.Size = sz
							boxes.Position = tl
							outlines.Size = sz
							outlines.Position = tl
							if L.BoxFillDrawings and L.BoxFillDrawings[model] and L.BoxFillEnabled then
								L.BoxFillDrawings[model].Visible = true
								L.BoxFillDrawings[model].Color = L.BoxFillColor or Color3.fromRGB(84, 132, 171)
								L.fillTrans = 0.5
								if Options and Options["BoxFillColorPicker"] then L.fillTrans = Options["BoxFillColorPicker"].Transparency end
								L.BoxFillDrawings[model].Transparency = (1 - L.fillTrans) * fadeAlpha
								L.BoxFillDrawings[model].Size = sz
								L.BoxFillDrawings[model].Position = tl
							elseif L.BoxFillDrawings and L.BoxFillDrawings[model] then
								L.BoxFillDrawings[model].Visible = false
							end
						elseif boxes then
							boxes.Visible = false
							outlines.Visible = false
							if L.BoxFillDrawings and L.BoxFillDrawings[model] then L.BoxFillDrawings[model].Visible = false end
						end
						if healthBar and healthOutline and healthEnabled then
							local healthScale = getHealthScale(model)
							local visualScale = L.VisualHealth[model]
							if not visualScale then
								visualScale = healthScale
								L.VisualHealth[model] = visualScale
							end
							visualScale = visualScale + (healthScale - visualScale) * math.clamp(dt * 10, 0, 1)
							L.VisualHealth[model] = visualScale
							local barX = math.floor(x - 5)
							local barY = math.floor(y)
							healthOutline.Size = Vector2.new(OUTLINE_WIDTH, math.floor(height) + 2)
							healthOutline.Position = Vector2.new(barX - 1, barY - 1)
							healthOutline.Transparency = fadeAlpha
							healthOutline.Visible = true
							if L.HealthGradientEnabled then
								local segmentCount = 80
								local segmentHeight = height / segmentCount
								local totalFillHeight = height * visualScale
								for i = 1, segmentCount do
									local segment = healthBar[i]
									if segment then
										local sP = (i - 1) / (segmentCount - 1)
										if L.HealthGradientRotationEnabled then sP = (math.sin(i / 15 + tick() * (L.HealthGradientRotationSpeed or 4)) + 1) / 2 end
										local sBottomOffset = (i - 1) * segmentHeight
										if sBottomOffset < totalFillHeight then
											local sFillHeight = math.min(segmentHeight, totalFillHeight - sBottomOffset)
											local sTopPos = math.floor(barY + height - sBottomOffset - sFillHeight)
											local sBottomPos = math.floor(barY + height - sBottomOffset)
											segment.Size = Vector2.new(BAR_WIDTH, sBottomPos - sTopPos)
											segment.Position = Vector2.new(barX, sTopPos)
											segment.Color = L.HealthLowColor:Lerp(L.HealthHighColor, sP)
											segment.Transparency = fadeAlpha
											segment.Visible = true
										else
											segment.Visible = false
										end
									end
								end
							else
								local barHeight = math.ceil(height * visualScale)
								local barYPos = math.floor(barY + (height - barHeight))
								if healthBar[1] then
									healthBar[1].Size = Vector2.new(BAR_WIDTH, barHeight)
									healthBar[1].Position = Vector2.new(barX, barYPos)
									healthBar[1].Color = L.HealthLowColor:Lerp(L.HealthHighColor, visualScale)
									healthBar[1].Transparency = fadeAlpha
									healthBar[1].Visible = true
								end
								for i = 2, 80 do
									if healthBar[i] then
										healthBar[i].Visible = false
									end
								end
							end
							local hText = L.HealthTextDrawings[model]
							if hText then
								local fadeProgress = L.HealthTextFadeCache[model] or 0
								if L.HealthTextEnabled and healthScale < 1 then
									fadeProgress = math.min(fadeProgress + (dt / 0.15), 1)
								else
									fadeProgress = math.max(fadeProgress - (dt / 0.15), 0)
								end
								L.HealthTextFadeCache[model] = fadeProgress
								if fadeProgress > 0 then
									local textY = barY + height - (height * visualScale)
									hText.Text = tostring(math.floor(healthScale * 100))
									hText.Position = Vector2.new(barX - 10, textY - 8)
									hText.Size = 13
									hText.Color = L.HealthTextColor
									hText.Transparency = fadeProgress * fadeAlpha
									hText.Visible = true
								else
									hText.Visible = false
								end
							end
						elseif healthBar then
							for i = 1, 80 do healthBar[i].Visible = false end
							healthOutline.Visible = false
							local hText = L.HealthTextDrawings[model]
							if hText then hText.Visible = false end
						end
						if chamsEnabled then
							local activeChams = L.ActiveChams[model]
							if activeChams then
								local chamsBaseTrans = L.ChamsTransparency or 0.5
								local chamsFadeAlpha = 1 - (fadeAlpha * (1 - chamsBaseTrans))
								for i = 1, #activeChams do
									local b = activeChams[i]
									if b:IsA("Highlight") then
										b.FillTransparency = chamsFadeAlpha
										b.OutlineTransparency = chamsFadeAlpha
										b.Enabled = true
									else
										b.Transparency = chamsFadeAlpha
										b.Visible = true
									end
								end
							end
						else
							local activeChams = L.ActiveChams[model]
							if activeChams then
								for i = 1, #activeChams do
									local b = activeChams[i]
									if b:IsA("Highlight") then
										b.Enabled = false
									else
										b.Visible = false
									end
								end
							end
						end
					end
				end)
local function applyFontSafe(drawing, font)
    if table.find(SafeFonts, font) then
        drawing.Font = font
    end
end
local function updateAllFonts(fontId)
    L.CurrentFont = fontId
    for _, d in pairs(L.DistanceDrawings) do
        applyFontSafe(d, fontId)
    end
    for _, d in pairs(L.NameDrawings) do
        applyFontSafe(d, fontId)
    end
    for _, d in pairs(L.WeaponDrawings) do
        applyFontSafe(d, fontId)
    end
    for _, d in pairs(L.HealthTextDrawings) do
        applyFontSafe(d, fontId)
    end
end
local BARREL_MESH_ID = "12272787618"
local nextGunCheck = 0
RunService.Heartbeat:Connect(function()
	local now = os.clock()
	if now >= nextGunCheck then
		local knifeFound = false
		for _, m in ipairs(Camera:GetChildren()) do
			if m:IsA("Model") and m:FindFirstChild("Trigger", true) then
				knifeFound = true
				break
			end
		end
		L.HasKnife = knifeFound
	end
	if L.SnapLineMethod ~= "Gun Barrel" and L.FovPositionMethod ~= "Gun Barrel" and L.SilentSnapOriginMethod ~= "Gun Barrel" and L.SilentFOVOriginMethod ~= "Gun Barrel" and L.CrosshairPositionMode ~= "Gun Barrel" then
		L.GunBarrel = nil
		return
	end
	if L.GunBarrel and L.GunBarrel:IsDescendantOf(Camera) then
		L.LastGunBarrelTime = now
		return
	end
	if now >= nextGunCheck then
		nextGunCheck = now + 0.25
		local found = nil
		for _, obj in ipairs(Camera:GetDescendants()) do
			if obj:IsA("SpecialMesh") and obj.MeshId:find(BARREL_MESH_ID) then
				local p = obj.Parent
				if p and p:IsA("BasePart") then
					found = p
					L.LastGunBarrelTime = now
					break
				end
			end
		end
		L.GunBarrel = found
	end
end)
local lines = {}
for i = 1, 4 do
    lines[i] = Drawing.new("Line")
    lines[i].Thickness = 2
    lines[i].Color = L.CrosshairColor
    lines[i].ZIndex = 2
    lines[i].Visible = false
end
local outlines = {}
for i = 1, 4 do
    outlines[i] = Drawing.new("Line")
    outlines[i].Thickness = 4
    outlines[i].Color = Color3.new(0,0,0)
    outlines[i].ZIndex = 1
    outlines[i].Visible = false
end
local flapLines = {}
for i = 1, 4 do
    flapLines[i] = Drawing.new("Line")
    flapLines[i].Thickness = 2
    flapLines[i].Color = L.CrosshairColor
    flapLines[i].ZIndex = 2
    flapLines[i].Visible = false
end
local flapOutlines = {}
for i = 1, 4 do
    flapOutlines[i] = Drawing.new("Line")
    flapOutlines[i].Thickness = 4
    flapOutlines[i].Color = Color3.new(0,0,0)
    flapOutlines[i].ZIndex = 1
    flapOutlines[i].Visible = false
end
local starLines = {}
local starOutlines = {}
for i = 1, 6 do
    starLines[i] = Drawing.new("Line")
    starLines[i].Thickness = 2
    starLines[i].Color = Color3.fromRGB(255,255,255)
    starLines[i].ZIndex = 2
    starLines[i].Visible = false
    starOutlines[i] = Drawing.new("Line")
    starOutlines[i].Thickness = 4
    starOutlines[i].Color = Color3.new(0,0,0)
    starOutlines[i].ZIndex = 1
    starOutlines[i].Visible = false
end
local dot = Drawing.new("Circle")
dot.Filled = true
dot.Thickness = 1
dot.Color = L.CrosshairColor
dot.ZIndex = 2
dot.Visible = false
local dotOutline = Drawing.new("Circle")
dotOutline.Filled = true
dotOutline.Thickness = 1
dotOutline.Color = Color3.new(0,0,0)
dotOutline.ZIndex = 1
dotOutline.Visible = false
local angle = 0
local SIDE_ORDER = {"Top","Right","Bottom","Left"}
local ANGLES = {0,90,180,270}
local cachedTarget = nil
local nextTargetUpdate = 0
local function getDefaultCrosshairCenter(camera)
    if L.CrosshairPositionMode == "Center Of Screen" then
        local size = camera.ViewportSize
        return Vector2.new(size.X/2, size.Y/2)
    elseif L.CrosshairPositionMode == "Gun Barrel" then
        if L.HasKnife or not L.GunBarrel or not L.GunBarrel:IsDescendantOf(Camera) then
            return nil
        end
        local forwardOffset = 7.5
        local worldPos = L.GunBarrel.Position + (L.GunBarrel.CFrame.LookVector * forwardOffset)
        local v, onScreen = camera:WorldToViewportPoint(worldPos)
        if not onScreen then
            return nil
        end
        return Vector2.new(v.X, v.Y)
    else
        local mousePos = UserInputService:GetMouseLocation()
        return Vector2.new(mousePos.X, mousePos.Y)
    end
end
local function getCrosshairCenter(dt)
    local camera = Workspace.CurrentCamera
    if not camera then return Vector2.new(0,0) end
    if L.CrosshairLockOnTarget then
        local now = os.clock()
        local activeTarget = nil
        if L.SilentEnabled then
            if now >= (L.CrosshairSilentNextUpdate or 0) then
                local _, _, tPart = L:GetSilentClosestTarget()
                L.CrosshairSilentCachedTarget = tPart
                L.CrosshairSilentNextUpdate = now + L.TARGET_UPDATE_RATE
            end
            activeTarget = L.CrosshairSilentCachedTarget
        elseif L.AimbotEnabled then
            if L.LockedTarget and L.LockedTarget:IsDescendantOf(workspace) then
                cachedTarget = L.LockedTarget
                nextTargetUpdate = now + L.TARGET_UPDATE_RATE
                activeTarget = cachedTarget
            elseif now >= nextTargetUpdate then
                cachedTarget = getClosestTarget()
                nextTargetUpdate = now + L.TARGET_UPDATE_RATE
                activeTarget = cachedTarget
            else
                activeTarget = cachedTarget
            end
        end
        if activeTarget and activeTarget:IsDescendantOf(workspace) then
            local pos, onScreen = camera:WorldToViewportPoint(activeTarget.Position)
            if onScreen then
                local targetPos = Vector2.new(pos.X, pos.Y)
                if not L.CrosshairCurrentOrigin then
                    L.CrosshairCurrentOrigin = targetPos
                else
                    L.CrosshairCurrentOrigin = L.CrosshairCurrentOrigin:Lerp(targetPos, math.clamp(dt * 35, 0, 1))
                end
                return L.CrosshairCurrentOrigin
            end
        end
    end
    local fallback = getDefaultCrosshairCenter(camera)
    local origin = fallback or Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    if L.CrosshairCurrentOrigin and (L.CrosshairCurrentOrigin - origin).Magnitude > 1 then
        L.CrosshairCurrentOrigin = L.CrosshairCurrentOrigin:Lerp(origin, math.clamp(dt * 35, 0, 1))
    else
        L.CrosshairCurrentOrigin = nil
    end
    return L.CrosshairCurrentOrigin or origin
end
RunService.RenderStepped:Connect(function(dt)
    if not L.CrosshairEnabled then
        for i = 1,4 do
            lines[i].Visible = false
            outlines[i].Visible = false
            flapLines[i].Visible = false
            flapOutlines[i].Visible = false
        end
        for i = 1,6 do
            starLines[i].Visible = false
            starOutlines[i].Visible = false
        end
        if dot then dot.Visible = false end
        if dotOutline then dotOutline.Visible = false end
        return
    end
    local center = getCrosshairCenter(dt)
    if L.CrosshairSpin then
        angle = (angle + dt * L.CrosshairSpinSpeed) % 360
    else
        angle = 0
    end
    local size = L.CrosshairSize
    local gap = L.CrosshairGap
    local thickness = L.CrosshairThickness
    local sides = STYLE_SIDES[L.CrosshairStyle] or STYLE_SIDES["1"]
    if L.CrosshairStyle == "4" then
        for i = 1,4 do
            lines[i].Visible = false
            outlines[i].Visible = false
            flapLines[i].Visible = false
            flapOutlines[i].Visible = false
        end
        for i = 1,6 do
            starLines[i].Visible = false
            starOutlines[i].Visible = false
        end
        local dotRadius = math.max(1, math.floor(thickness * 1.5))
        dot.Radius = dotRadius
        dot.Position = center
        dot.Color = L.CrosshairColor
        dot.Visible = true
        dotOutline.Radius = dotRadius + 1
        dotOutline.Position = center
        dotOutline.Visible = true
        return
    elseif L.CrosshairStyle == "6" then
        dot.Visible = false
        dotOutline.Visible = false
        for i = 1,4 do
            lines[i].Visible = false
            outlines[i].Visible = false
            flapLines[i].Visible = false
            flapOutlines[i].Visible = false
        end
        local R = size 
        local triAngles = {
            {90, 210, 330},
            {270, 30, 150},
        }
        local lineIdx = 1
        for _, tri in ipairs(triAngles) do
            local verts = {}
            for j = 1, 3 do
                local rad = math.rad(angle + tri[j])
                verts[j] = center + Vector2.new(math.cos(rad), -math.sin(rad)) * R
            end
            for j = 1, 3 do
                local a = verts[j]
                local b = verts[(j % 3) + 1]
                starLines[lineIdx].From = a
                starLines[lineIdx].To = b
                starLines[lineIdx].Thickness = thickness
                starLines[lineIdx].Color = L.CrosshairColor
                starLines[lineIdx].Visible = true
                starOutlines[lineIdx].From = a
                starOutlines[lineIdx].To = b
                starOutlines[lineIdx].Thickness = thickness + 2
                starOutlines[lineIdx].Visible = true
                lineIdx = lineIdx + 1
            end
        end
        return
    else
        dot.Visible = false
        dotOutline.Visible = false
        for i = 1,6 do
            starLines[i].Visible = false
            starOutlines[i].Visible = false
        end
    end
    for i = 1,4 do
        lines[i].Thickness = thickness
        outlines[i].Thickness = thickness + 2
        flapLines[i].Thickness = thickness
        flapOutlines[i].Thickness = thickness + 2
        local sideName = SIDE_ORDER[i]
        if sides[sideName] then
            local rad = math.rad(angle + ANGLES[i])
            local dir = Vector2.new(math.cos(rad), math.sin(rad))
            local from = center + dir * gap
            local to = center + dir * (gap + size)
            if L.CrosshairStyle == "5" then
                local perp = Vector2.new(-dir.Y, dir.X)
                local offset = math.max(2, size)
                from = center
                to = center + dir * (gap + size)
                flapLines[i].From = to
                flapLines[i].To = to + perp * offset
                flapLines[i].Color = L.CrosshairColor
                flapLines[i].Visible = true
                flapOutlines[i].From = to
                flapOutlines[i].To = to + perp * offset
                flapOutlines[i].Visible = true
            else
                flapLines[i].Visible = false
                flapOutlines[i].Visible = false
            end
            lines[i].From = from
            lines[i].To = to
            lines[i].Color = L.CrosshairColor
            lines[i].Visible = true
            outlines[i].From = from
            outlines[i].To = to
            outlines[i].Visible = true
        else
            lines[i].Visible = false
            outlines[i].Visible = false
            flapLines[i].Visible = false
            flapOutlines[i].Visible = false
        end
    end
end)
local SilentSnapOutline = Drawing.new("Line")
SilentSnapOutline.Thickness = 3
SilentSnapOutline.Color = Color3.new(0,0,0)
SilentSnapOutline.Transparency = 1
SilentSnapOutline.Visible = false
local SilentSnapLine = Drawing.new("Line")
SilentSnapLine.Thickness = 1
SilentSnapLine.Color = Color3.fromRGB(255,255,255)
SilentSnapLine.Transparency = 1
SilentSnapLine.Visible = false
local SilentFOVOutline = Drawing.new("Circle")
SilentFOVOutline.Filled = false
SilentFOVOutline.Thickness = 3
SilentFOVOutline.Color = Color3.new(0,0,0)
SilentFOVOutline.Transparency = 1
SilentFOVOutline.Visible = false
local SilentFOVCircle = Drawing.new("Circle")
SilentFOVCircle.Filled = false
SilentFOVCircle.Thickness = 1
SilentFOVCircle.Color = L.SilentFOVColor
SilentFOVCircle.Transparency = 1
SilentFOVCircle.Visible = false
L.SilentFOVFill = Drawing.new("Circle")
L.SilentFOVFill.Filled = true
L.SilentFOVFill.Thickness = 0
L.SilentFOVFill.Color = Color3.fromRGB(83, 132, 171)
L.SilentFOVFill.Transparency = 0.5
L.SilentFOVFill.Visible = false
local SilentLocalTeam = nil
function L:ResolveBarrelMotor()
	if self.GunBarrelMotor or not self.GunBarrel then return end
	for _, d in ipairs(self.GunBarrel:GetDescendants()) do
		if d:IsA("Motor6D") then
			self.GunBarrelMotor = d
			self.GunBarrelMotorOriginal = d.Transform
			return
		end
	end
	for _, d in ipairs(self.GunBarrel:GetDescendants()) do
		if d:IsA("Weld") then
			self.GunBarrelMotor = d
			self.GunBarrelMotorOriginal = d.C0
			return
		end
	end
end
local function GetSilentScreenOrigin()
	if L.SilentFOVOriginMethod == "Gun Barrel" then
		if L.HasKnife then return nil, false, nil end
		if L.GunBarrel and L.GunBarrel:IsDescendantOf(Camera) then
			local p = L.GunBarrel.Position + (L.GunBarrel.CFrame.LookVector * 7.5)
			local v, onScreen = Camera:WorldToViewportPoint(p)
			if onScreen then
				return Vector2.new(v.X, v.Y), true, p
			end
		end
		if L.LastGunBarrelTime and (os.clock() - L.LastGunBarrelTime) < 1 then
			return nil, false, nil
		end
		local m = UserInputService:GetMouseLocation()
		return m, true, nil
	end
	local m = UserInputService:GetMouseLocation()
	return m, true, L.GunBarrel and L.GunBarrel.Position or nil
end
local function SilentGetLocalTeam()
	return LocalTeam or getLocalTeam()
end
local function SilentIsEnemy(part)
	return isEnemy(part)
end
local function SilentIsVisible(part)
	if not L.SilentWallCheck then return true end
	local origin = Camera.CFrame.Position
	local dir = part.Position - origin
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local filter = {LocalPlayer.Character, Camera}
	local weapon = workspace.CurrentCamera:FindFirstChildWhichIsA("Model")
	if weapon then table.insert(filter, weapon) end
	params.FilterDescendantsInstances = filter
	params.IgnoreWater = true
	local result = workspace:Raycast(origin, dir, params)
	return not result or result.Instance:IsDescendantOf(part.Parent)
end
L.SilentAimPartCache = L.SilentAimPartCache or setmetatable({}, {__mode = "k"})
local function getCachedSilentTargetPart(model)
	local targetMesh = L.SILENT_TARGET_MESH or L.MESH_IDS["Head"]
	local c = L.SilentAimPartCache[model]
	if c == false then return nil end
	if c and c:IsDescendantOf(model) and c.MeshId:find(targetMesh) then return c end
	for _, v in ipairs(model:GetDescendants()) do
		if v:IsA("MeshPart") and v.MeshId and v.MeshId:find(targetMesh) then
			L.SilentAimPartCache[model] = v
			return v
		end
	end
	L.SilentAimPartCache[model] = false
	return nil
end
local function SilentGetTargetParts()
	local t = {}
	for model, _ in pairs(L.NameDrawings or {}) do
		if checkEnemyByModel(model) then
			local p = getCachedSilentTargetPart(model)
			if p then t[#t+1] = p end
		end
	end
	return t
end
function L:GetSilentClosestTarget(overridePart)
	local camPos = Camera.CFrame.Position
	local origin
	if L.SilentFOVOriginMethod == "Gun Barrel" then
		if L.HasKnife or not L.GunBarrel or not L.GunBarrel:IsDescendantOf(Camera) then return nil end
		local forwardOffset = 7.5
		local worldPos = L.GunBarrel.Position + (L.GunBarrel.CFrame.LookVector * forwardOffset)
		local v, onScreen = Camera:WorldToViewportPoint(worldPos)
		if not onScreen then return nil end
		origin = Vector2.new(v.X, v.Y)
	else
		origin = UserInputService:GetMouseLocation()
	end
	local distance = math.huge
	if L.SilentPriority == "Closest To Mouse" then
		distance = L.SilentCurrentFOV or math.huge
	end
	local position, closestEntry, closestPart
	local partName = overridePart or L.SilentAimPart or "Head"
	if not L.SilentRE then return nil end
	local physicsignore = {workspace.Terrain, Camera, workspace:FindFirstChild("Ignore"), workspace:FindFirstChild("Players")}
	local raycastparameters = RaycastParams.new()
	raycastparameters.IgnoreWater = true
	raycastparameters.FilterDescendantsInstances = physicsignore
	raycastparameters.FilterType = Enum.RaycastFilterType.Exclude
	L.SilentRE.operateOnAllEntries(function(player, entry)
		local character = entry._thirdPersonObject and entry._thirdPersonObject._characterModelHash
		if character and entry._isEnemy then
			local targetPart = character[partName]
			if targetPart then
				local target = targetPart.Position
				local isVisible = true
				if L.SilentWallCheck then
					local result = workspace:Raycast(camPos, target - camPos, raycastparameters)
					if result then
						isVisible = false
					end
				end
				if isVisible then
					local screenPosition, onscreen = Camera:WorldToViewportPoint(target)
					local currentDist = math.huge
					if L.SilentPriority == "Closest To You" then
						currentDist = (camPos - target).Magnitude
					else
						currentDist = (Vector2.new(screenPosition.X, screenPosition.Y) - origin).Magnitude
					end
					if screenPosition.Z > 0 and currentDist < distance then
						closestPart = targetPart
						position = target
						distance = currentDist
						closestEntry = entry
					end
				end
			end
		end
	end)
	return position, closestEntry, closestPart
end
L.solve = function(v44, v45, v46, v47, v48) 
    if not v44 then
        return
    elseif v44 > -1.0E-10 and v44 < 1.0E-10 then
        return L.solve(v45, v46, v47, v48)
    else
        if v48 then
            local v49 = -v45 / (4 * v44)
            local v50 = (v46 + v49 * (3 * v45 + 6 * v44 * v49)) / v44
            local v51 = (v47 + v49 * (2 * v46 + v49 * (3 * v45 + 4 * v44 * v49))) / v44
            local v52 = (v48 + v49 * (v47 + v49 * (v46 + v49 * (v45 + v44 * v49)))) / v44
            if v51 > -1.0E-10 and v51 < 1.0E-10 then
                local v53, v54 = L.solve(1, v50, v52)
                if not v54 or v54 < 0 then
                    return
                else
                    local v55 = math.sqrt(v53)
                    local v56 = math.sqrt(v54)
                    return v49 - v56, v49 - v55, v49 + v55, v49 + v56
                end
            else
                local v57, _, v59 = L.solve(1, 2 * v50, v50 * v50 - 4 * v52, -v51 * v51)
                local v60 = v59 or v57
                local v61 = math.sqrt(v60)
                local v62, v63 = L.solve(1, v61, (v60 + v50 - v51 / v61) / 2)
                local v64, v65 = L.solve(1, -v61, (v60 + v50 + v51 / v61) / 2)
                if v62 and v64 then
                    return v49 + v62, v49 + v63, v49 + v64, v49 + v65
                elseif v62 then
                    return v49 + v62, v49 + v63
                elseif v64 then
                    return v49 + v64, v49 + v65
                end
            end
        elseif v47 then
            local v66 = -v45 / (3 * v44);
            local v67 = -(v46 + v66 * (2 * v45 + 3 * v44 * v66)) / (3 * v44)
            local v68 = -(v47 + v66 * (v46 + v66 * (v45 + v44 * v66))) / (2 * v44)
            local v69 = v68 * v68 - v67 * v67 * v67
            local v70 = math.sqrt((math.abs(v69)))
            if v69 > 0 then
                local v71 = v68 + v70
                local v72 = v68 - v70
                v71 = v71 < 0 and -(-v71) ^ 0.3333333333333333 or v71 ^ 0.3333333333333333
                local v73 = v72 < 0 and -(-v72) ^ 0.3333333333333333 or v72 ^ 0.3333333333333333
                return v66 + v71 + v73
            else
                local v74 = math.atan2(v70, v68) / 3
                local v75 = 2 * math.sqrt(v67)
                return v66 - v75 * math.sin(v74 + 0.5235987755982988), v66 + v75 * math.sin(v74 - 0.5235987755982988), v66 + v75 * math.cos(v74)
            end;
        elseif v46 then
            local v76 = -v45 / (2 * v44)
            local v77 = v76 * v76 - v46 / v44
            if v77 < 0 then
                return
            else
                local v78 = math.sqrt(v77)
                return v76 - v78, v76 + v78
            end
        elseif v45 then
            return -v45 / v44
        end
        return
    end
end
L.complexTrajectory = function(o, a, t, s, e) 
    if not o or not t then return end
    local ld = t - o
    a = -a
    e = e or Vector3.zero
    local r1, r2, r3, r4 = L.solve(
        a:Dot(a) * 0.25,
        a:Dot(e),
        a:Dot(ld) + e:Dot(e) - s^2,
        ld:Dot(e) * 2,
        ld:Dot(ld)
    )
    local x = (r1 and r1>0 and r1) or (r2 and r2>0 and r2) or (r3 and r3>0 and r3) or r4
    if not x then return end
    local v = (ld + e*x + 0.5*a*x^2) / x
    return v, x
end
L.trajectory = function(o, a, t, s)
    if not o or not t then return end
    local f = -a
    local ld = t - o
    local a_dot = f:Dot(f)
    local b = 4 * ld:Dot(ld)
    local k = (4 * (f:Dot(ld) + s * s)) / (2 * a_dot)
    local v = (k * k - b / a_dot) ^ 0.5
    local t1, t0 = k - v, k + v
    t1 = t1 < 0 and t0 or t1; t1 = t1 ^ 0.5
    return f * t1 / 2 + ld / t1, t1
end
UserInputService.InputBegan:Connect(function(input,gpe)
	if not gpe and input.UserInputType == Enum.UserInputType.MouseButton2 then
		L.SilentHolding = true
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		L.SilentHolding = false
	end
end)
RunService.RenderStepped:Connect(function(dt)
	local now = os.clock()
	local base = L.SilentFOVRadius
	local targetFOV = base
	if L.SilentDynamicFOV and L.SilentHolding then
		targetFOV = base * (L.DynamicFOVMultiplier or 1.85)
	end
	local speed = (targetFOV > L.SilentCurrentFOV) and (L.DynamicFOVSpeedIn or 0.05) or (L.DynamicFOVSpeedOut or 0.05)
	L.SilentCurrentFOV = L.SilentCurrentFOV + (targetFOV - L.SilentCurrentFOV) * speed
	local origin, valid = GetSilentScreenOrigin()
	if not L.SilentFOVNextTargetUpdate then L.SilentFOVNextTargetUpdate = 0 end
	if L.SilentFOVLockOnTarget and L.SilentEnabled then
		if L.SilentHolding and L.SilentCachedTarget and L.SilentCachedTarget:IsDescendantOf(workspace) then
			L.SilentFOVCachedTarget = L.SilentCachedTarget
			L.SilentFOVNextTargetUpdate = now + L.TARGET_UPDATE_RATE
		elseif now >= L.SilentFOVNextTargetUpdate then
			local tPos, tEntry, tPart = L:GetSilentClosestTarget()
			L.SilentFOVCachedTarget = tPart
			L.SilentFOVNextTargetUpdate = now + L.TARGET_UPDATE_RATE
		end
		if L.SilentFOVCachedTarget and typeof(L.SilentFOVCachedTarget) == "Instance" and L.SilentFOVCachedTarget:IsDescendantOf(workspace) then
			local pos, onScreen = Camera:WorldToViewportPoint(L.SilentFOVCachedTarget.Position)
			if onScreen then
				origin = Vector2.new(pos.X, pos.Y)
				valid = true
			end
		end
	end
	if valid then
		if L.SilentFOVLockOnTarget and L.SilentEnabled and L.SilentFOVCachedTarget and typeof(L.SilentFOVCachedTarget) == "Instance" and L.SilentFOVCachedTarget:IsDescendantOf(workspace) then
			if not L.SilentFOVCurrentOrigin then
				L.SilentFOVCurrentOrigin = origin
			else
				L.SilentFOVCurrentOrigin = L.SilentFOVCurrentOrigin:Lerp(origin, math.clamp(dt * 22.5, 0, 1))
			end
			origin = L.SilentFOVCurrentOrigin
		else
			if L.SilentFOVCurrentOrigin and (L.SilentFOVCurrentOrigin - origin).Magnitude > 1 then L.SilentFOVCurrentOrigin = L.SilentFOVCurrentOrigin:Lerp(origin, math.clamp(dt * 22.5, 0, 1)) origin = L.SilentFOVCurrentOrigin else L.SilentFOVCurrentOrigin = nil end
		end
		SilentFOVCircle.Visible = L.SilentShowFOV
		SilentFOVOutline.Visible = L.SilentShowFOV
		L.SilentFOVFill.Visible = L.SilentShowFOV
		SilentFOVCircle.Position = origin
		SilentFOVOutline.Position = origin
		L.SilentFOVFill.Position = origin
		SilentFOVCircle.Radius = L.SilentCurrentFOV
		SilentFOVOutline.Radius = L.SilentCurrentFOV
		L.SilentFOVFill.Radius = L.SilentCurrentFOV
		SilentFOVCircle.Color = L.SilentFOVColor
		if Options["SilentL.FOVFillColor"] then
			L.SilentFOVFill.Color = L.SilentFOVFillColor or Color3.fromRGB(83,132,171)
			L.SilentFOVFill.Transparency = 1 - Options["SilentL.FOVFillColor"].Transparency
		end
	else
		L.SilentFOVCurrentOrigin = nil
		SilentFOVCircle.Visible = false
		SilentFOVOutline.Visible = false
		L.SilentFOVFill.Visible = false
	end
	local snapOrigin
	local snapValid = false
	if L.SilentSnapOriginMethod == "Gun Barrel" then
		if not L.HasKnife and L.GunBarrel and L.GunBarrel:IsDescendantOf(Camera) then
			local v, onScreen = Camera:WorldToViewportPoint(L.GunBarrel.Position)
			if onScreen then
				snapOrigin = Vector2.new(v.X, v.Y)
				snapValid = true
			end
		end
	else
		snapOrigin = UserInputService:GetMouseLocation()
		snapValid = true
	end
	local snapTarget = nil
	if L.SilentSnapEnabled and snapValid then
		if not L.SilentNextTargetUpdate then L.SilentNextTargetUpdate = 0 end
		if now >= L.SilentNextTargetUpdate then
			local tPos, tEntry, tPart = L:GetSilentClosestTarget()
			snapTarget = tPart
			L.SilentCachedTarget = snapTarget
			L.SilentNextTargetUpdate = now + L.TARGET_UPDATE_RATE
		else
			snapTarget = L.SilentCachedTarget
		end
		if snapTarget and typeof(snapTarget) == "Instance" and snapTarget:IsDescendantOf(workspace) then
			local pos, onScreen = Camera:WorldToViewportPoint(snapTarget.Position)
			if onScreen then
				local dist = origin and (Vector2.new(pos.X, pos.Y) - origin).Magnitude or math.huge
				if L.SilentHolding or dist <= (L.SilentCurrentFOV * 1.5) then
					if not L.SilentSnapWasDrawing then
						L.SilentSnapAlpha = 0
					end
					L.SilentSnapWasDrawing = true
					L.SilentSnapAlpha = math.clamp((L.SilentSnapAlpha or 0) + (dt / 0.1), 0, 1)
					SilentSnapLine.Visible = true
					SilentSnapOutline.Visible = true
					SilentSnapLine.From = snapOrigin
					SilentSnapLine.To = Vector2.new(pos.X,pos.Y)
					SilentSnapOutline.From = snapOrigin
					SilentSnapOutline.To = Vector2.new(pos.X,pos.Y)
					SilentSnapLine.Transparency = L.SilentSnapAlpha
					SilentSnapOutline.Transparency = L.SilentSnapAlpha
				else
					SilentSnapLine.Visible = false
					SilentSnapOutline.Visible = false
					L.SilentSnapWasDrawing = false
				end
			else
				SilentSnapLine.Visible = false
				SilentSnapOutline.Visible = false
				L.SilentSnapWasDrawing = false
			end
		else
			SilentSnapLine.Visible = false
			SilentSnapOutline.Visible = false
			L.SilentSnapWasDrawing = false
		end
	else
		SilentSnapLine.Visible = false
		SilentSnapOutline.Visible = false
		L.SilentSnapWasDrawing = false
	end
end)
local function applyHitSound(s)
	if not s:IsA("Sound") then return end
	if s.Name ~= "hitmarker" then return end
	if not L.HitSoundBackup[s] then
		L.HitSoundBackup[s] = {Id=s.SoundId,Volume=s.Volume}
	end
	local id = L.HitSoundMap[L.HitSoundSelected]
	if id and s.SoundId ~= id then
		s.SoundId = id
	end
	s.Volume = L.HitSoundVolume
end
local function restoreHitSound(s)
	local old = L.HitSoundBackup[s]
	if old then
		s.SoundId = old.Id
		s.Volume = old.Volume
		L.HitSoundBackup[s] = nil
	end
end
local function applyKillSound(s)
	if not s:IsA("Sound") then return end
	if s.Name ~= "killshot" and s.Name ~= "headshotkill" then return end
	if not L.KillSoundBackup[s] then
		L.KillSoundBackup[s] = {Id=s.SoundId,Volume=s.Volume}
	end
	local id = L.KillSoundMap[L.KillSoundSelected]
	if id and s.SoundId ~= id then
		s.SoundId = id
	end
	s.Volume = L.KillSoundVolume
end
local function restoreKillSound(s)
	local old = L.KillSoundBackup[s]
	if old then
		s.SoundId = old.Id
		s.Volume = old.Volume
		L.KillSoundBackup[s] = nil
	end
end
local CachedSlots = {}
local OriginalColors = {}
local function CacheSleeves()
	table.clear(CachedSlots)
	table.clear(OriginalColors)
	for _, obj in ipairs(Camera:GetDescendants()) do
		if obj:IsA("MeshPart") and obj.Name == "Sleeves" then
			for _, tex in ipairs(obj:GetChildren()) do
				if tex:IsA("Texture") and tex.Name == "Slot1" then
					table.insert(CachedSlots, tex)
					OriginalColors[tex] = tex.Color3
				end
			end
		end
	end
end
local function Apply()
	if #CachedSlots == 0 then
		CacheSleeves()
	end
	local texId
	if L.MasterEnabled then
		texId = SleeveTextureIds[L.SelectedSleeveTexture or "Default"]
	else
		texId = SleeveTextureIds.Default
	end
	if not texId then
		warn("sleeves arent found.. WTF!!")
		return
	end
	for _, tex in ipairs(CachedSlots) do
		if tex:IsDescendantOf(Camera) then
			tex.Texture = texId
			if L.MasterEnabled and L.SleeveColor then
				tex.Color3 = L.SleeveColor
			else
				tex.Color3 = OriginalColors[tex] or tex.Color3
			end
		end
	end
end
Camera.DescendantAdded:Connect(function(obj)
	if obj:IsA("Texture") and obj.Name == "Slot1" then
		if obj.Parent and obj.Parent:IsA("MeshPart") and obj.Parent.Name == "Sleeves" then
			table.insert(CachedSlots, obj)
			OriginalColors[obj] = obj.Color3
			Apply()
		end
	end
end)
local lastState = L.MasterEnabled
game:GetService("RunService").Stepped:Connect(function()
	if L.MasterEnabled ~= lastState then
		lastState = L.MasterEnabled
		Apply()
	end
end)
				local Window = Library:CreateWindow({
					Title = "                                          $$ roxy.win $$",
					Center = true,
					AutoShow = true,
					MenuFadeTime = 0.1,
					Resizable = true,
					ShowCustomCursor = false,
					NotifySide = "Bottom",
					Size = UDim2.new(0, 800, 0, 600)
				})
				for _, v in ipairs(Window.Holder:GetDescendants()) do
					if v:IsA("TextLabel") and v.Text:find("roxy.win") then
						v.RichText = true
						break
					end
				end
				local Tabs = {
					A = Window:AddTab("Legitbot"),
			        B2 = Window:AddTab("Ragebot"),
					B = Window:AddTab("Visuals"),
					C = Window:AddTab("Misc"),
					["UI Settings"] = Window:AddTab("Configs")
				}
				local Aimbot = Tabs.A:AddLeftGroupbox("Aimbot")
				local Silent = Tabs.A:AddRightGroupbox("Silent")
				local LOCALP = Tabs.A:AddLeftGroupbox("Local")
				local GunMods = Tabs.A:AddRightGroupbox("Gun Mods")
				GunMods:AddToggle("NoRecoil", {
					Text = "No Recoil",
					Default = false,
					Tooltip = "Removes weapon recoil",
					Callback = function(v) L.NoRecoil = v end
				})
				GunMods:AddToggle("NoSpread", {
					Text = "No Spread",
					Default = false,
					Tooltip = "Removes weapon spread/bullet deviation",
					Callback = function(v) L.NoSpread = v end
				})
				GunMods:AddToggle("NoCameraSway", {
					Text = "No Camera Sway",
					Default = false,
					Tooltip = "Removes camera sway while aiming",
					Callback = function(v) L.NoCameraSway = v end
				})
				GunMods:AddToggle("NoCameraBob", {
					Text = "No Camera Bob",
					Default = false,
					Tooltip = "Removes camera bobbing while moving",
					Callback = function(v) L.NoCameraBob = v end
				})
				GunMods:AddToggle("NoWalkSway", {
					Text = "No Walk Sway",
					Default = false,
					Tooltip = "Removes weapon sway caused by walking",
					Callback = function(v) L.NoWalkSway = v end
				})
				GunMods:AddToggle("NoGunSway", {
					Text = "No Gun Sway",
					Default = false,
					Tooltip = "Removes weapon sway completely",
					Callback = function(v) L.NoGunSway = v end
				})
				GunMods:AddToggle("InstantReload", {
					Text = "Instant Reload",
					Default = false,
					Tooltip = "Reloads your weapon instantly",
					Callback = function(v) L.InstantReload = v end
				})
				GunMods:AddToggle("InstantAim", {
					Text = "Instant Aim",
					Default = false,
					Tooltip = "Makes aiming down sights instantaneous",
					Callback = function(v) L.InstantAim = v end
				})
				GunMods:AddToggle("InstantEquip", {
					Text = "Instant Equip",
					Default = false,
					Tooltip = "Makes weapon switching instantaneous",
					Callback = function(v) L.InstantEquip = v end
				})
				local ESP1 = Tabs.B:AddLeftGroupbox("Enemy")
				local ESP2 = Tabs.B:AddRightTabbox()
                local ESP4 = Tabs.B:AddLeftGroupbox("Crosshair")
				local AimbotToggle = Aimbot:AddToggle("ToggleAimbot", {
					Text = "Toggle Aimbot",
					Default = false,
					Callback = function(v)
						L.AimbotEnabled = v
					end
				})
				AimbotToggle:AddKeyPicker("AimbotToggleKeybind", {
					Default = "MB2",
					Mode = "Hold",
					SyncToggleState = false,
					Text = "Aimbot",
					Callback = function() end,
					ChangedCallback = function(New)
						L.AimKey = New
					end
				})
				Aimbot:AddToggle("AimbotStickyAimToggle", {
					Text = "Sticky Aim",
					Default = false,
					Callback = function(v)
						L.StickyAim = v
					end
				})
				Aimbot:AddToggle("WallCheckToggle", {
					Text = "Wall Check",
					Default = false,
					Callback = function(v)
						L.WallCheck = v
					end
				})
				Aimbot:AddToggle("AimbotPredDropToggle", {
					Text = "Calculate Bullet Drop",
					Default = false,
					Callback = function(v)
						L.AimbotPredDropEnabled = v
					end
				})
				Aimbot:AddToggle("AimbotPredictionToggle", {
					Text = "Calculate Prediction",
					Default = false,
					Callback = function(v)
						L.AimbotPredictionEnabled = v
					end
				})
Aimbot:AddSlider("SmoothnessSlider", {
	Text = "Smoothness",
	Default = 1.2,
	Min = 0.3,
	Max = 5,
	Rounding = 1,
	Compact = true,
	Callback = function(v)
		L.AimVelocity = v * 1000
	end
})
				Aimbot:AddSlider("MaxDistanceB", {
					Text = "Max Distance",
					Default = 500,
					Min = 1,
					Max = 1000,
					Rounding = 0,
					Compact = true,
					Suffix = "stds",
					Callback = function(v)
						L.MaxAimDistance = v
					end
				})
				Aimbot:AddDropdown('AimbotPartSelection', {
					Values = { 'Head', 'Torso' },
					Default = 1,
					Multi = false,
					Text = 'Aimbot Bone',
					Callback = function(Value)
						L.SelectedAimPart = Value
						L.TARGET_MESH_ID = L.MESH_IDS[Value]
					end
				})
				Aimbot:AddDropdown('AimbotTypeDropdown', {
					Values = { 'Closest To Mouse', 'Closest To You' },
					Default = 1,
					Multi = false,
					Text = 'Target Priority',
					Callback = function(Value)
						L.AimbotType = Value
					end
				})
				Aimbot:AddDivider()
				local SnapLine1 = Aimbot:AddToggle("SnapLineToggle", {
					Text = "Snap Line",
					Default = false,
					Callback = function(v)
						L.SnapEnabled = v
						if not v then
							SnapLine.Visible = false
							SnapOutline.Visible = false
						end
					end
				})
				SnapLine1:AddColorPicker("SnapLineColor", {
					Default = Color3.fromRGB(255, 255, 255),
					Title = "Line Color",
					Callback = function(v)
						SnapLine.Color = v
					end
				})
				local FOVToggle = Aimbot:AddToggle("ToggleFOV", {
					Text = "Show FOV",
					Default = false,
					Callback = function(v)
						L.ShowFOV = v
					end
				})
				Aimbot:AddToggle("DynamicFOVToggle", {
					Text = "Dynamic FOV",
					Default = false,
					Callback = function(v)
						L.DynamicFOVEnabled = v
					end
				})
				Aimbot:AddToggle("FOVLockOnTarget", {
					Text = "Lock On Target",
					Tooltip = "Locks FOV on aimbot target",
					Default = false,
					Callback = function(v)
						L.FOVLockOnTarget = v
					end
				})
				FOVToggle:AddColorPicker("L.FOVColor", {
					Default = Color3.fromRGB(255, 255, 255),
					Title = "FOV Color",
					Callback = function(v)
						L.FOVColor = v
					end
				})
				FOVToggle:AddColorPicker("L.FOVFillColor", {
					Default = Color3.fromRGB(83, 132, 171),
					Title = "FOV Fill Color",
					Transparency = 0.5,
					Callback = function(v)
						L.FOVFillColor = v
					end
				})
				Aimbot:AddSlider("FOVSize1", {
					Text = "Size",
					Default = 120,
					Min = 0,
					Max = 500,
					Rounding = 0,
					Suffix = "px",
					Compact = true,
					Callback = function(v)
						L.FOVRadius = v
					end
				})
	Aimbot:AddDropdown('SnapLineMethod', {
	Values = { 'Gun Barrel', 'Mouse' },
	Default = 1,
	Multi = false,
	Text = 'Snap From',
	Callback = function(v)
		L.SnapLineMethod = v
	end
})
Aimbot:AddDropdown('FovPositionMethod', {
	Values = { 'Gun Barrel', 'Mouse' },
	Default = 2,
	Multi = false,
	Text = 'Fov Position',
	Callback = function(v)
		L.FovPositionMethod = v
	end
})
				    LOCALP:AddToggle("WALKSPEEDLOCK", {
					Text = "Walkspeed Modifier",
					Default = false,
					Compact = true,
					Callback = function(value)
						L.WalkSpeedEnabled = value
						local char = L.charInterface and L.charInterface.getCharacterObject()
						if char then
							char:setBaseWalkSpeed(value and L.TARGET_WALKSPEED or (L.newSpawnCache.walkSpeed or 16))
						end
					end
				}):AddKeyPicker("WalkSpeedKeybind", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Walkspeed", NoUI = false })
				LOCALP:AddToggle("NOJUMPCOOLDOWN", {
					Text = "No Jump Cooldown",
					Default = false,
					Callback = function(value)
						L.NoJumpCooldownEnabled = value
						if not value then
							local char = L.charInterface and L.charInterface.getCharacterObject()
							local hum = char and char._humanoid
							if hum then
								hum.Jump = false
							end
						end
					end
				})
				LOCALP:AddToggle("NOFALLDAMAGE", {
					Text = "No Fall Damage",
					Default = false,
					Callback = function(value)
						L.NoFallDamageEnabled = value
					end
				})
				LOCALP:AddSlider("WALKSPEEDSLIDER", {
					Text = "WalkSpeed",
					Default = 16,
					Min = 5,
					Max = 250,
					Rounding = 0,
					Compact = false,
					Callback = function(Value)
						L.TARGET_WALKSPEED = Value
						local char = L.charInterface and L.charInterface.getCharacterObject()
						if L.WalkSpeedEnabled and char then
							char:setBaseWalkSpeed(Value)
						end
					end
				})
				local ESP2TAB = ESP2:AddTab('Arm')
				ESP2TAB:AddToggle('ArmVisualsToggle', {
					Text = 'Toggle Arm Visuals',
					Default = false,
					Tooltip = nil,
					Callback = function(Value)
						L.MasterEnabled = Value
						if not Value then
							ClearAll()
							restoreArmMaterial()
							restoreHideArms()
							SetSleeveSlotsTransparency(0)
						end
					end
				})
				local ArmsHighlight = ESP2TAB:AddToggle('ArmHighlighToggle', {
					Text = 'Arm Highlight',
					Default = false,
					Tooltip = nil,
					Callback = function(Value)
						L.HighlightEnabled = Value
						if not Value then
							ClearAll()
						end
					end
				})
				ArmsHighlight:AddColorPicker("ArmFillCP", {
					Default = Color3.fromRGB(84,132,171),
					Title = "Fill Color",
					Transparency = nil,
					Callback = function(value)
						L.FillColor = value
						for _, h in pairs(L.ArmHighlights) do
							h.FillColor = value
						end
					end
				})
				ArmsHighlight:AddColorPicker("ArmHighlightCP", {
					Default = Color3.fromRGB(255, 255, 255),
					Title = "Highlight Color",
					Transparency = nil,
					Callback = function(value)
						L.OutlineColor = value
						for _, h in pairs(L.ArmHighlights) do
							h.OutlineColor = value
						end
					end
				})
				ESP2TAB:AddSlider('HighlightTransparency', {
					Text = 'Transparency',
					Default = L.HighlightFillTransparency,
					Min = 0,
					Max = 1,
					Rounding = 1,
					Compact = true,
					Callback = function(Value)
						L.HighlightFillTransparency = Value
						for _, h in pairs(L.ArmHighlights) do
							h.FillTransparency = Value
						end
					end
				})
				local ArmsMaterial = ESP2TAB:AddToggle('ArmsMaterialToggle', {
					Text = 'Arm Material',
					Default = false,
					Callback = function(Value)
						L.ArmsMaterialEnabled = Value
						if not Value then
							restoreArmMaterial()
						end
					end
				})
				ArmsMaterial:AddColorPicker("ArmMaterialCP", {
					Default = Color3.fromRGB(84,132,171),
					Title = "Material Color",
					Callback = function(value)
						L.ArmsMaterialColor = value
					end
				})
				ESP2TAB:AddToggle('HideArmsToggle', {
					Text = 'Hide Arms',
					Default = false,
					Callback = function(Value)
						L.HideArmsEnabled = Value
						if not Value then
							restoreHideArms()
						end
					end
				})
				ESP2TAB:AddToggle('HideSleevesToggle', {
	Text = 'Hide Sleeves',
	Default = false,
	Callback = function(Value)
		L.HideSleevesEnabled = Value
		if Value and L.MasterEnabled then
			SetSleeveSlotsTransparency(1)
		else
			SetSleeveSlotsTransparency(0)
		end
	end
})
				ESP2TAB:AddDropdown('ArmMaterialDropdown', {
					Values = { 'ForceField', 'Neon', 'SmoothPlastic', 'Glass', 'Metal' },
					Default = 1,
					Multi = false,
					Text = 'Material Selection',
					Callback = function(Value)
						L.ArmsMaterialEnum = L.MaterialMap[Value] or Enum.Material.ForceField
					end
				})
				ESP2TAB:AddDropdown('ArmForceFieldTextureDropdown', {
					Values = (function()
						local keys = {}
						for k, _ in pairs(L.ForceFieldTextures) do
							table.insert(keys, k)
						end
						table.sort(keys)
						return keys
					end)(),
					Default = "Honeycomb",
					Multi = false,
					Text = 'ForceField Texture',
					Callback = function(Value)
						L.SelectedArmForcefieldTexture = Value
					end
				})
ESP2TAB:AddDropdown('SleeveTextureDropdown', {
	Values = {'Default','Beach','Camo'},
	Default = 1,
	Multi = false,
	Text = 'Sleeves Texture',
	Callback = function(Value)
		L.SelectedSleeveTexture = Value
		Apply()
	end
})
ESP2TAB:AddLabel('Sleeves Color'):AddColorPicker('SleeveColorP', {
	Default = Color3.new(1, 1, 1),
	Title = 'Sleeve Color',
	Transparency = nil,
	Callback = function(Value)
		L.SleeveColor = Value
		if L.MasterEnabled then
			Apply()
		end
	end
})
local ESP2TAB1 = ESP2:AddTab('Weapon')
				ESP2TAB1:AddToggle('WeaponVisualsToggle', {
					Text = 'Toggle Weapon Visuals',
					Default = false,
					Tooltip = nil,
					Callback = function(Value)
						L.WeaponMasterEnabled = Value
						if not Value then
							clearWeaponHighlights()
							restoreWeaponMaterial()
						end
					end
				})
				local WeaponHighlightT = ESP2TAB1:AddToggle('WeaponHighlightToggle', {
					Text = 'Weapon Highlight',
					Default = false,
					Tooltip = nil,
					Callback = function(Value)
						L.WeaponHighlightEnabled = Value
						if not Value then
							clearWeaponHighlights()
						end
					end
				})
				WeaponHighlightT:AddColorPicker("WeaponFillCP", {
					Default = L.WeaponFillColor,
					Title = "Fill Color",
					Transparency = nil,
					Callback = function(value)
						L.WeaponFillColor = value
						for _, h in pairs(L.WeaponHighlights) do
							h.FillColor = value
						end
					end
				})
				WeaponHighlightT:AddColorPicker("WeaponHighlightCP", {
					Default = L.WeaponOutlineColor,
					Title = "Highlight Color",
					Transparency = nil,
					Callback = function(value)
						L.WeaponOutlineColor = value
						for _, h in pairs(L.WeaponHighlights) do
							h.OutlineColor = value
						end
					end
				})
				ESP2TAB1:AddSlider('WeaponHighlightTransparency', {
					Text = 'Transparency',
					Default = L.WeaponFillTransparency,
					Min = 0,
					Max = 1,
					Rounding = 1,
					Compact = true,
					Callback = function(Value)
						L.WeaponFillTransparency = Value
						for _, h in pairs(L.WeaponHighlights) do
							h.FillTransparency = Value
						end
					end
				})
				local WeaponMaterial = ESP2TAB1:AddToggle('WeaponMaterialToggle', {
					Text = 'Weapon Material',
					Default = false,
					Callback = function(Value)
						L.WeaponMaterialEnabled = Value 
						if not Value or not L.WeaponMasterEnabled then
							restoreWeaponMaterial()
						end
					end
				})
				WeaponMaterial:AddColorPicker("WeaponMaterialCP", {
					Default = Color3.fromRGB(84,132,171),
					Title = "Material Color",
					Callback = function(value)
						L.WeaponMaterialColor = value
					end
				})
				ESP2TAB1:AddToggle('HideGunToggle', {
					Text = 'Hide Gun',
					Default = false,
					Callback = function(Value)
						L.HideGunEnabled = Value 
						if not Value or not L.WeaponMasterEnabled then
							if type(restoreHideGun) == "function" then
								restoreHideGun()
							end
						end
					end
				})
				ESP2TAB1:AddDropdown('WeaponMaterialDropdown', {
					Values = { 'ForceField', 'Neon', 'SmoothPlastic', 'Glass', 'Metal' },
					Default = 1,
					Multi = false,
					Text = 'Material Selection',
					Callback = function(Value)
						L.WeaponMaterialEnum = L.WeaponMaterialMap[Value] or Enum.Material.ForceField
					end
				})
				ESP2TAB1:AddDropdown('WeaponForceFieldTextureDropdown', {
					Values = (function()
						local keys = {}
						for k, _ in pairs(L.ForceFieldTextures) do
							table.insert(keys, k)
						end
						table.sort(keys)
						return keys
					end)(),
					Default = "Honeycomb",
					Multi = false,
					Text = 'ForceField Texture',
					Callback = function(Value)
						L.SelectedWeaponForcefieldTexture = Value
					end
				})
				ESP2TAB1:AddDivider()
				ESP2TAB1:AddToggle('ViewmodelOffsetToggle', {
					Text = 'Offset Changer',
					Default = false,
					Callback = function(v)
						L.ViewmodelOffsetEnabled = v
					end
				})
				ESP2TAB1:AddToggle('ViewmodelOffsetRemoveOnAim', {
					Text = 'Remove On Aim',
					Default = false,
					Callback = function(v)
						L.ViewmodelOffsetRemoveOnAim = v
					end
				})
				ESP2TAB1:AddSlider('ViewmodelOffsetX', {
					Text = 'Offset X',
					Default = 0,
					Min = -5,
					Max = 5,
					Rounding = 1,
					Compact = true,
					Callback = function(v)
						L.ViewmodelOffsetX = v
						L:UpdateViewmodelOffset()
					end
				})
				ESP2TAB1:AddSlider('ViewmodelOffsetY', {
					Text = 'Offset Y',
					Default = 0,
					Min = -5,
					Max = 5,
					Rounding = 1,
					Compact = true,
					Callback = function(v)
						L.ViewmodelOffsetY = v
						L:UpdateViewmodelOffset()
					end
				})
				ESP2TAB1:AddSlider('ViewmodelOffsetZ', {
					Text = 'Offset Z',
					Default = 0,
					Min = -5,
					Max = 5,
					Rounding = 1,
					Compact = true,
					Callback = function(v)
						L.ViewmodelOffsetZ = v
						L:UpdateViewmodelOffset()
					end
				})
				local CHAMSESP1 = ESP1:AddToggle('ChamsESP', {
					Text = 'Player Chams',
					Default = false,
					Callback = function(v)
						L.ChamsEnabled = v
						if L.ChamsEnabled then
							for _, folder in ipairs(PlayersFolder:GetChildren()) do
								if folder:IsA("Folder") then
									for _, model in ipairs(folder:GetChildren()) do
										processChams(model)
										for _, child in ipairs(model:GetChildren()) do
											if isValidModel(child) then
												processChams(child)
											end
										end
									end
								end
							end
						else
							for model in pairs(L.ActiveChams) do
								clearChams(model)
							end
						end
					end
				})
				CHAMSESP1:AddColorPicker("ChamsESPCP", {
					Default = Color3.fromRGB(84,132,171),
					Title = "Chams Color",
					Callback = function(v)
						L.ChamsColor = v
						updateAllChams()
					end
				})
				local NAMEVISUALS = ESP1:AddToggle('ShowPlayerTags', {
					Text = 'Player Name',
					Default = false,
					Callback = function(state)
						L.NameESPEnabled = state
					end
				})
				NAMEVISUALS:AddColorPicker('NameTagColor', {
					Default = Color3.fromRGB(255, 255, 255),
					Title = 'Name Text Color',
					Transparency = 0,
					Callback = function(color)
						L.NameTextColor = color
						for _, text in pairs(L.NameDrawings) do
							text.Color = color
						end
					end
				})
				local BOXVISUALS = ESP1:AddToggle("BoxESP", {
					Text = "Player Box",
					Default = false,
					Callback = function(state)
						L.BoxESPEnabled = state
					end
				})
				BOXVISUALS:AddColorPicker("BoxESPColor", {
					Default = Color3.fromRGB(255, 255, 255),
					Title = "Box Color",
					Transparency = 0,
					Callback = function(color)
						L.BoxColor = color
						for _, box in pairs(L.BoxDrawings) do
							box.Color = color
						end
					end
				})
				L.BoxFillDepBox = ESP1:AddDependencyBox()
				L.BoxFillDepBox:AddToggle("BoxFillToggle", {
					Text = "Box Fill",
					Default = false,
					Callback = function(state)
						L.BoxFillEnabled = state
					end
				}):AddColorPicker("BoxFillColorPicker", {
					Default = Color3.fromRGB(84, 132, 171),
					Title = "Box Fill Color",
					Transparency = 0.5,
					Callback = function(color)
						L.BoxFillColor = color
					end
				})
				L.BoxFillDepBox:SetupDependencies({
					{ BOXVISUALS, true }
				})
				local HEALTHVISUALS = ESP1:AddToggle("HealthESP", {
					Text = "Player Health",
					Default = false,
					Callback = function(state)
						L.HealthESPEnabled = state
					end
				})
				HEALTHVISUALS:AddColorPicker("HealthESPHigh", {
					Default = Color3.fromRGB(0, 255, 0),
					Title = "Health Color ( High )",
					Transparency = nil,
					Callback = function(color)
						L.HealthHighColor = color
					end
				})
				HEALTHVISUALS:AddColorPicker("HealthESPLow", {
					Default = Color3.fromRGB(255, 0, 0),
					Title = "Health Color ( Low )",
					Transparency = nil,
					Callback = function(color)
						L.HealthLowColor = color
					end
				})
				local HealthDepBox = ESP1:AddDependencyBox()
				local HealthTextToggle = HealthDepBox:AddToggle("HealthTextToggle", {
					Text = "Player Health Text",
					Default = false,
					Callback = function(state)
						L.HealthTextEnabled = state
					end
				})
				HealthTextToggle:AddColorPicker("HealthTextColor", {
					Default = Color3.fromRGB(255, 255, 255),
					Title = "Health Text Color",
					Callback = function(color)
						L.HealthTextColor = color
					end
				})
				HealthDepBox:AddToggle("HealthGradientToggle", {
					Text = "Gradient Color",
					Default = false,
					Callback = function(state)
						L.HealthGradientEnabled = state
					end
				})
				HealthDepBox:SetupDependencies({
					{ HEALTHVISUALS, true }
				})
				HealthDepBox = ESP1:AddDependencyBox()
				HealthDepBox:AddToggle("HealthGradientRotationToggle", {
					Text = "Gradient Rotation",
					Default = false,
					Callback = function(v) L.HealthGradientRotationEnabled = v end
				})
				HealthDepBox:SetupDependencies({ { Toggles.HealthGradientToggle, true } })
				HealthDepBox = ESP1:AddDependencyBox()
				HealthDepBox:AddSlider("HealthGradientRotationSpeed", {
					Text = "Gradient Rotation Speed",
					Default = 1, Min = 0.1, Max = 10, Rounding = 1, Compact = true,
					Callback = function(v) L.HealthGradientRotationSpeed = v end
				})
				HealthDepBox:SetupDependencies({ { Toggles.HealthGradientRotationToggle, true } })
				local CHAMSESP2 = ESP1:AddToggle('DistanceESP', {
					Text = 'Player Distance',
					Default = false,
					Callback = function(v)
						L.DistanceESPEnabled = v
					end
				})
				CHAMSESP2:AddColorPicker("DistanceESPCP", {
					Default = Color3.fromRGB(255, 255, 255),
					Title = "Text Color",
					Callback = function(v)
					L.DistanceTextColor = v
				end
				})
				local CHAMSESP3 = ESP1:AddToggle('WeaponESP', {
					Text = 'Player Weapon',
					Default = false,
					Callback = function(v)
						L.WeaponESPEnabled = v
					end
				})
				CHAMSESP3:AddColorPicker("WeaponESPCP", {
					Default = Color3.fromRGB(255, 255, 255),
					Title = "Text Color",
					Callback = function(v)
						L.WeaponTextColor = v
					end
				})
				ESP1:AddSlider("ChamsTransparencySlider", {
					Text = "Chams Transparency",
					Default = L.ChamsTransparency or 0.5,
					Min = 0,
					Max = 1,
					Rounding = 2,
					Compact = true,
					Callback = function(v)
						L.ChamsTransparency = v
						updateAllChams()
					end
				})
				ESP1:AddDropdown('FontTypeDropdown', {
					Values = {
						'UI',
						'System',
						'Plex',
						'Monospace'
					},
					Default = 3,
					Multi = false,
					Text = 'Font Type',
					Callback = function(Value)
						local fontId = FontMap[Value]
						if fontId ~= nil then
							updateAllFonts(fontId)
						end
					end
				})
				ESP1:AddDropdown('FontCaseDropdown', {
					Values = { 'Normal', 'Lowercase', 'Uppercase' },
					Default = 1,
					Multi = false,
					Text = 'Font Case',
					Callback = function(Value)
						L.FontCase = Value
					end
				})
local TabBox2 = Tabs.B:AddRightTabbox()
local WorldTab = TabBox2:AddTab('World')
				local CAmbientToggle = WorldTab:AddToggle('CustomAmbienToggle', {
					Text = 'Custom Ambient',
					Default = false,
					Callback = function(enabled)
						L.CustomAmbientEnabled = enabled
						if enabled then
							Lighting.Ambient = L.CAmbientColor
							task.spawn(function()
								while L.CustomAmbientEnabled and not Library.Unloaded do
									if Lighting.Ambient ~= L.CAmbientColor then
										Lighting.Ambient = L.CAmbientColor
									end
									task.wait()
								end
							end)
						else
							Lighting.Ambient = Color3.fromRGB(150, 150, 150)
						end
					end
				})
				CAmbientToggle:AddColorPicker('CAmbientCP1', {
					Default = L.CAmbientColor,
					Title = 'Ambient Color',
					Callback = function(color)
						L.CAmbientColor = color
						if L.CustomAmbientEnabled then
							Lighting.Ambient = L.CAmbientColor
						end
					end
				})
				WorldTab:AddToggle('CustomSkyboxToggle', {
					Text = 'Custom Skybox',
					Default = false,
					Tooltip = "If skyboxes arent showing toggle custom clocktime",
					Callback = function(enabled)
						L.SkyboxEnabled = enabled
						if L.SkyboxEnabled then
							ApplySky(L.SelectedSky)
						else
							RestoreSky()
						end
					end
				})
				WorldTab:AddToggle('CustomClockTimeToggle', {
					Text = 'Custom ClockTime',
					Default = false,
					Callback = function(enabled)
						L.CustomClockTimeEnabled = enabled
						if enabled then
							L.OriginalClockTime = Lighting.ClockTime
							Lighting.ClockTime = L.CustomClockTimeValue
						else
							Lighting.ClockTime = L.OriginalClockTime
						end
					end
				})
				WorldTab:AddSlider("CustomClockTimeSlider", {
					Text = "ClockTime",
					Default = 12,
					Min = 0,
					Max = 24,
					Rounding = 0,
					Compact = true,
					Callback = function(v)
						L.CustomClockTimeValue = v
						if L.CustomClockTimeEnabled then
							Lighting.ClockTime = v
						end
					end
				})
WorldTab:AddDropdown('SkyboxSelectionDropdown', {
    Values = (function()
        local skyKeys = {}
        for k, _ in pairs(L.Skyboxes) do
            table.insert(skyKeys, k)
        end
        table.sort(skyKeys)
        return skyKeys
    end)(),
    Default = "ElegantMorning",
    Multi = false,
    Text = 'Skybox Selection',
    Callback = function(value)
        L.SelectedSky = value
        if L.SkyboxEnabled then
            ApplySky(L.SelectedSky)
        end
    end
})
WorldTab:AddDivider()
WorldTab:AddToggle('BloomToggle', {
	Text = 'Bloom',
	Default = false,
	Callback = function(enabled)
		L.BloomEnabled = enabled
		if enabled then
			if not Lighting:FindFirstChild("RoxyBloom") then
				Instance.new("BloomEffect", Lighting).Name = "RoxyBloom"
			end
			if not Lighting:FindFirstChild("RoxyBloomCC") then
				Instance.new("ColorCorrectionEffect", Lighting).Name = "RoxyBloomCC"
			end
			Lighting.RoxyBloom.Enabled = true
			Lighting.RoxyBloomCC.Enabled = true
			Lighting.RoxyBloom.Intensity = L.BloomIntensity or 1
			Lighting.RoxyBloom.Size = L.BloomSize or 24
			Lighting.RoxyBloom.Threshold = L.BloomThreshold or 2
			Lighting.RoxyBloomCC.TintColor = L.BloomColor or Color3.fromRGB(255, 255, 255)
		else
			if Lighting:FindFirstChild("RoxyBloom") then Lighting.RoxyBloom.Enabled = false end
			if Lighting:FindFirstChild("RoxyBloomCC") then Lighting.RoxyBloomCC.Enabled = false end
		end
	end
}):AddColorPicker('BloomColorCP', {
	Default = Color3.fromRGB(255, 255, 255),
	Title = 'Bloom Color',
	Callback = function(color)
		L.BloomColor = color
		if L.BloomEnabled and Lighting:FindFirstChild("RoxyBloomCC") then
			Lighting.RoxyBloomCC.TintColor = color
		end
	end
})
WorldTab:AddSlider("BloomSizeSlider", {
	Text = "Bloom Size",
	Default = 24,
	Min = 0,
	Max = 56,
	Rounding = 0,
	Compact = true,
	Callback = function(v)
		L.BloomSize = v
		if L.BloomEnabled and Lighting:FindFirstChild("RoxyBloom") then
			Lighting.RoxyBloom.Size = v
		end
	end
})
WorldTab:AddSlider("BloomThresholdSlider", {
	Text = "Bloom Threshold",
	Default = 2,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Compact = true,
	Callback = function(v)
		L.BloomThreshold = v
		if L.BloomEnabled and Lighting:FindFirstChild("RoxyBloom") then
			Lighting.RoxyBloom.Threshold = v
		end
	end
})
WorldTab:AddSlider("BloomIntensitySlider", {
	Text = "Bloom Intensity",
	Default = 1,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Compact = true,
	Callback = function(v)
		L.BloomIntensity = v
		if L.BloomEnabled and Lighting:FindFirstChild("RoxyBloom") then
			Lighting.RoxyBloom.Intensity = v
		end
	end
})
WorldTab:AddDivider()
local CameraTab = TabBox2:AddTab('Camera')
CameraTab:AddToggle("ThirdPersonEnabled", {
    Text = "Toggle Third Person",
    Default = false,
    Callback = function(v)
        L.ThirdPersonEnabled = v
        if L.ThirdPerson then 
            if L.ThirdPerson.Active ~= v then
                L.ThirdPerson:Activate() 
            end
        end
    end
}):AddKeyPicker("ThirdPersonKeybind", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Third Person", NoUI = false })
CameraTab:AddToggle("ThirdPersonHideChar", {
    Text = "Hide Character",
    Default = false,
    Callback = function(v)
        L.ThirdPersonHideChar = v
    end
})
CameraTab:AddSlider("ThirdPersonDistance", {
    Text = "Third person distance",
    Default = 7,
    Min = 0,
    Max = 20,
    Rounding = 1,
    Callback = function(v)
        L.ThirdPersonDistance = v
    end
})
CameraTab:AddSlider("ThirdPersonReplicationDelay", {
    Text = "Character Replication Delay",
    Default = 0,
    Min = 0,
    Max = 0.75,
    Rounding = 2,
    Callback = function(v)
        L.ThirdPersonReplicationDelay = v
    end
})
CameraTab:AddToggle("ToggleCharacterVisuals", {
    Text = "Toggle Character Visuals",
    Default = false,
    Callback = function(v)
        L.ToggleCharacterVisuals = v
    end
}):AddColorPicker("ThirdPersonChamsColor", {
    Default = Color3.fromRGB(83,132,171),
    Title = "Third Person Chams Color",
    Callback = function(v)
        L.ThirdPersonChamsColor = v
    end
})
CameraTab:AddDropdown("CharacterMaterial", {
    Values = { "Glass", "Neon", "ForceField", "Wood" },
    Default = "ForceField",
    Multi = false,
    Text = "Character Material",
    Callback = function(v)
        L.CharacterMaterial = v
    end
})
CameraTab:AddDropdown("ForceFieldTexture", {
    Values = (function()
        local keys = {}
        for k, _ in pairs(L.ForceFieldTextures) do
            table.insert(keys, k)
        end
        table.sort(keys)
        return keys
    end)(),
    Default = "Honeycomb",
    Multi = false,
    Text = "ForceField Texture",
    Callback = function(v)
        L.SelectedForceFieldTexture = v
    end
})
local TabBox = Tabs.B:AddRightTabbox()
local ExtraTab = TabBox:AddTab('Extra')
				local extracount = ExtraTab:AddToggle('AmmoCountToggle', {
					Text = 'Ammo Count',
					Default = false,
					Callback = function(v)
						L.MiniUI.Enabled = v
					end
				})
				local BulletTab = TabBox:AddTab('Bullets')
				local BulletToggle = BulletTab:AddToggle('BulletTracersToggle', {
					Text = 'Bullet Tracers',
					Default = false,
					Callback = function(v)
						L.BulletTracersEnabled = v
					end
				})
				L.BulletTracerLink = true
				BulletTab:AddToggle('BulletTracerLink', {
					Text = 'Origin Link Connection',
					Default = true,
					Tooltip = 'Visually connects your physical Torso to the scanned offset firing position for ragebot',
					Callback = function(v)
						L.BulletTracerLink = v
					end
				})
				BulletToggle:AddColorPicker("TracerColor", {
					Default = Color3.fromRGB(83,132,171),
					Title = "Tracer Color",
					Callback = function(v)
						L.TracerColor = v
					end
				})
				BulletTab:AddSlider("TracerSize", {
					Text = "Size",
					Default = 0.1,
					Min = 0.05,
					Max = 3,
					Rounding = 2,
					Compact = true,
					Suffix = " Studs",
					Callback = function(v)
						L.TracerSize = v
					end
				})
				BulletTab:AddSlider("TracerAnimationSpeed", {
					Text = "Animation Speed",
					Default = 3,
					Min = 0,
					Max = 10,
					Rounding = 1,
					Compact = true,
					Callback = function(v)
						L.TracerAnimationSpeed = v
					end
				})
				BulletTab:AddSlider("TracerDuration", {
					Text = "Duration",
					Default = 3.5,
					Min = 0.1,
					Max = 3.5,
					Rounding = 1,
					Compact = true,
					Suffix = "s",
					Callback = function(v)
						L.TracerDuration = v
					end
				})
				BulletTab:AddDropdown('TracerStyle', {
					Values = { '1', '2', '3', '4', '5', '6' },
					Default = '1',
					Multi = false,
					Text = 'Tracer Style',
					Callback = function(v)
						L.TracerStyle = v
					end
				})

L.CrosshairLockOnTarget = false
L.CrosshairEnabled = false
L.CrosshairColor = Color3.fromRGB(255,255,255)
L.CrosshairSpin = false
L.CrosshairSize = 20
L.CrosshairSpinSpeed = 150
L.CrosshairThickness = 1
L.CrosshairGap = 2
L.CrosshairSides = {Top=true,Bottom=true,Left=true,Right=true}
L.CrosshairPositionMode = "Center Of Screen"
ESP4:AddToggle('CrosshairToggle1',{
	Text='Toggle Crosshair',
	Default=L.CrosshairEnabled,
	Callback=function(v)
		L.CrosshairEnabled=v
	end
}):AddColorPicker("CrosshairMainColor",{
	Default=L.CrosshairColor,
	Title="Crosshair Color",
	Callback=function(v)
		L.CrosshairColor=v
	end
})
ESP4:AddToggle('CrosshairSpinToggle',{
	Text='Spin',
	Default=L.CrosshairSpin,
	Callback=function(v)
		L.CrosshairSpin=v
	end
})
ESP4:AddToggle('CrosshairLockOnTarget',{
	Text='Lock On Target',
	Tooltip="Locks Crosshair On Aimbot/Silent Target",
	Default=false,
	Callback=function(v)
		L.CrosshairLockOnTarget = v
	end
})
ESP4:AddToggle('CrosshairRemoveIGCH',{
	Text='No Crosshair',
	Tooltip="Hides in-game crosshair",
	Default=false,
	Callback=function(v)
		local crosshairs = player.PlayerGui.HudScreenGui.Main.DisplayCrosshairs
		local parts = {
			crosshairs.Up,
			crosshairs.Center,
			crosshairs.Down,
			crosshairs.Left,
			crosshairs.Right,
		}
		for _, part in ipairs(parts) do
			if part then
				part.Visible = not v
			end
		end
	end
})
ESP4:AddSlider("CrossHairSizeSlider",{
	Text="Crosshair Size",
	Default=L.CrosshairSize,
	Min=2,
	Max=100,
	Rounding=0,
	Compact=true,
	Callback=function(v)
		L.CrosshairSize=v
	end
})
ESP4:AddSlider("CrosshairSpinSpeed",{
	Text="Spin Speed",
	Default=L.CrosshairSpinSpeed,
	Min=1,
	Max=200,
	Rounding=0,
	Compact=true,
	Callback=function(v)
		L.CrosshairSpinSpeed=v
	end
})
ESP4:AddSlider("CrosshairThickness",{
	Text="Crosshair Thickness",
	Default=L.CrosshairThickness,
	Min=1,
	Max=10,
	Rounding=1,
	Compact=true,
	Callback=function(v)
		L.CrosshairThickness=v
	end
})
ESP4:AddSlider("CrosshairGap",{
	Text="Crosshair Gap",
	Default=L.CrosshairGap,
	Min=0,
	Max=50,
	Rounding=0,
	Compact=true,
	Callback=function(v)
		L.CrosshairGap=v
	end
})
ESP4:AddDropdown('CrosshairStyles',{
	Values={'1','2','3','4','5','6'},
	Default='1',
	Multi=false,
	Text='Crosshair Style',
	Callback=function(v)
		L.CrosshairStyle=v
	end
})
ESP4:AddDropdown('CrosshairScreenPosition',{
	Values={'Center Of Screen','Gun Barrel'},
	Default="Center Of Screen",
	Multi=false,
	Text='Crosshair Position',
	Callback=function(v)
		L.CrosshairPositionMode=v
	end
})
local SilentToggle = Silent:AddToggle("ToggleSilent",{
	Text="Toggle Silent",
	Default=false,
	Risky = false,
	Tooltip = nil,
	Callback=function(v)
		L.SilentEnabled=v
		if not v then
			L.SilentHolding=false
		end
	end
})
SilentToggle:AddKeyPicker("AimbotToggleKeybind",{
	Default="None",
	Mode="Hold",
	SyncToggleState=false,
	Text="Silent Aim",
	Callback=function()
		L.SilentHolding=true
	end,
	ChangedCallback=function()
		L.SilentHolding=false
	end
})
Silent:AddToggle("SilentStickyAimToggle",{
	Text="Sticky Aim",
	Default=false,
	Callback=function(v)
		L.SilentSticky=v
	end
})
Silent:AddToggle("SilentWallCheckToggle",{
	Text="Wall Check",
	Default=false,
	Callback=function(v)
		L.SilentWallCheck=v
	end
})
Silent:AddSlider("SilentRedirectChanceSlider",{
	Text="Hit Chance",
	Default=50,
	Min=1,
	Max=100,
	Rounding=0,
	Compact=true,
	Suffix="%",
	Callback=function(v)
		L.SilentHitChance=v
	end
})
Silent:AddSlider("SilentHeadshotChance",{
	Text="Headshot Chance",
	Default=100,
	Min=0,
	Max=100,
	Rounding=0,
	Compact=true,
	Suffix="%",
	Callback=function(v)
		L.SilentHeadshotChance=v
	end
})
Silent:AddSlider("SilentMaxDistanceB",{
	Text="Max Distance",
	Default=500,
	Min=1,
	Max=1000,
	Rounding=0,
	Compact=true,
	Suffix="stds",
	Callback=function(v)
		L.SilentMaxDistance=v
	end
})
Silent:AddDropdown("SilentTypeDropdown",{
	Values={"Closest To Mouse","Closest To You"},
	Default=1,
	Multi=false,
	Text="Target Priority",
	Callback=function(v)
		L.SilentPriority=v
	end
})
Silent:AddDivider()
local SnapLine2 = Silent:AddToggle("SilentSnapLineToggle",{
	Text="Snap Line",
	Default=false,
	Callback=function(v)
		L.SilentSnapEnabled=v
	end
})
SnapLine2:AddColorPicker("SilentSnapLineColor",{
	Default=Color3.fromRGB(255,255,255),
	Title="Line Color",
	Callback=function(v)
		L.SilentSnapColor=v
	end
})
local SilentFovToggle = Silent:AddToggle("SilentToggleFOV",{
	Text="Show FOV",
	Default=false,
	Callback=function(v)
		L.SilentShowFOV=v
	end
})
Silent:AddToggle("SilentDynamicFOVToggle",{
	Text="Dynamic FOV",
	Default=false,
	Callback=function(v)
		L.SilentDynamicFOV=v
	end
})
Silent:AddToggle("SilentFOVLockOnTarget",{
	Text="Lock On Target",
	Tooltip="Locks FOV On Silent Target",
	Default=false,
	Callback=function(v)
		L.SilentFOVLockOnTarget=v
	end
})
SilentFovToggle:AddColorPicker("SilentL.FOVColor",{
	Default=Color3.fromRGB(255,255,255),
	Title="FOV Color",
	Callback=function(v)
		L.SilentFOVColor=v
	end
})
SilentFovToggle:AddColorPicker("SilentL.FOVFillColor",{
	Default=Color3.fromRGB(83,132,171),
	Title="FOV Fill Color",
	Transparency=0.5,
	Callback=function(v)
		L.SilentFOVFillColor=v
	end
})
Silent:AddSlider("SilentFOVSize1",{
	Text="Size",
	Default=120,
	Min=0,
	Max=500,
	Rounding=0,
	Suffix="px",
	Compact=true,
	Callback=function(v)
		L.SilentFOVRadius=v
	end
})
Silent:AddDropdown("SilentSnapLineMethod",{
	Values={"Gun Barrel","Mouse"},
	Default=1,
	Multi=false,
	Text="Snap From",
	Callback=function(v)
		L.SilentSnapOriginMethod=v
	end
})
Silent:AddDropdown("SilentFovPositionMethod",{
	Values={"Gun Barrel","Mouse"},
	Default=1,
	Multi=false,
	Text="Fov Position",
	Callback=function(v)
		L.SilentFOVOriginMethod=v
	end
})
local Rage = Tabs.B2:AddLeftGroupbox("Rage")
Rage:AddToggle("RageBotAutoShoot",{
	Text="Auto Shoot",
	Tooltip="Automatically shoots valid targets",
	Default=false,
	Callback=function(v)
		L.RageBotAutoShoot = v
	end
}):AddKeyPicker("RageBotAutoShootKeybind", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Auto Shoot", NoUI = false })
Rage:AddToggle("RageBotFirePosScan",{
	Text="Fire Position Scanning",
	Tooltip="Scans fire positions around corners for valid shots",
	Default=false,
	Callback=function(v)
		L.RageBotFirePosScan = v
	end
})
Rage:AddSlider("RageBotFirePosOffset",{
	Text="Fire Position Offset",
	Default=9,
	Min=1,
	Max=15.9,
	Rounding=1,
	Suffix=" Studs",
	Compact=true,
	Callback=function(v)
		L.RageBotFirePosOffset = v
	end
})
Rage:AddSlider("RageBotFirePosCount", {
	Text = "Scanning Count",
	Default = 5,
	Min = 1,
	Max = 16,
	Rounding = 0,
	Compact = true,
	Callback = function(v)
		L.RageBotFirePosCount = v
	end
})
Rage:AddDropdown("RageBotFirePosMethod", {
	Values = { "Cardinal", "Spinning Cardinal", "Random" },
	Default = 3,
	Multi = false,
	Text = "Scanning Method",
	Callback = function(v)
		L.RageBotFirePosMethod = v
	end
})
Rage:AddToggle("RageBotHitPosScan",{
	Text="Hit Position Scanning",
	Tooltip="Scans the outer edges of the enemy hitbox for valid hits",
	Default=false,
	Callback=function(v)
		L.RageBotHitPosScan = v
	end
})
Rage:AddSlider("RageBotHitPosOffset",{
	Text="Hit Position Offset",
	Default=6,
	Min=1,
	Max=10,
	Rounding=1,
	Suffix=" Studs",
	Compact=true,
	Callback=function(v)
		L.RageBotHitPosOffset = v
	end
})
Rage:AddSlider("RageBotHitPosCount", {
	Text = "Scanning Count",
	Default = 5,
	Min = 1,
	Max = 16,
	Rounding = 0,
	Compact = true,
	Callback = function(v)
		L.RageBotHitPosCount = v
	end
})
Rage:AddDropdown("RageBotHitPosMethod", {
	Values = { "Cardinal", "Spinning Cardinal", "Random" },
	Default = 3,
	Multi = false,
	Text = "Scanning Method",
	Callback = function(v)
		L.RageBotHitPosMethod = v
	end
})
Rage:AddToggle("CollatScanningEnabled", {
	Text = "Collat Scanning",
	Default = false,
	Callback = function(v)
		L.CollatScanningEnabled = v
	end
})
Rage:AddSlider("CollatScanningRadius", {
	Text = "Collat Scanning Radius",
	Default = 1,
	Min = 0.1,
	Max = 10,
	Rounding = 1,
	Compact = true,
	Callback = function(v)
		L.CollatScanningRadius = v
	end
})
local AntiA = Tabs.B2:AddRightGroupbox("Anti Aim")
AntiA:AddToggle("AntiAimEnabled", {
    Text = "Toggle Anti Aim",
    Default = false,
    Callback = function(v) L.AntiAimEnabled = v end
}):AddKeyPicker("AntiAimKeybind", { Default = "None", SyncToggleState = true, Mode = "Toggle", Text = "Anti Aim", NoUI = false })
AntiA:AddToggle("AntiAimYawEnabled", {
    Text = "Yaw",
    Default = false,
    Callback = function(v) L.AntiAimYawEnabled = v end
})
AntiA:AddSlider("AntiAimYawAngle", {
    Text = "Yaw Angle",
    Min = -180, Max = 180, Default = 0, Rounding = 0, Compact = true,
    Callback = function(v) L.AntiAimYawAngle = v end
})
AntiA:AddSlider("AntiAimYawWaveRate", {
    Text = "Yaw Wave Rate",
    Min = 1, Max = 10, Default = 1, Rounding = 1, Compact = true,
    Callback = function(v) L.AntiAimYawWaveRate = v end
})
AntiA:AddSlider("AntiAimYawWaveDegree", {
    Text = "Yaw Wave Degree",
    Min = 0, Max = 360, Default = 0, Rounding = 0, Compact = true,
    Callback = function(v) L.AntiAimYawWaveDegree = v end
})
AntiA:AddDropdown("AntiAimYawType", {
    Text = "Yaw Type",
    Values = {"Custom", "Wave"},
    Default = "Custom",
    Callback = function(v) L.AntiAimYawType = v end
})
AntiA:AddToggle("AntiAimPitchEnabled", {
    Text = "Pitch",
    Default = false,
    Callback = function(v) L.AntiAimPitchEnabled = v end
})
AntiA:AddSlider("AntiAimPitchAngle", {
    Text = "Pitch Angle",
    Min = -90, Max = 90, Default = 0, Rounding = 0, Compact = true,
    Callback = function(v) L.AntiAimPitchAngle = v end
})
AntiA:AddSlider("AntiAimPitchWaveRate", {
    Text = "Pitch Wave Rate",
    Min = 0, Max = 10, Default = 0, Rounding = 1, Compact = true,
    Callback = function(v) L.AntiAimPitchWaveRate = v end
})
AntiA:AddDropdown("AntiAimPitchType", {
    Text = "Pitch Type",
    Values = {"Custom", "Wave"},
    Default = "Custom",
    Callback = function(v) L.AntiAimPitchType = v end
})
AntiA:AddToggle("AntiAimSpinBotEnabled", {
    Text = "Spin Bot",
    Default = false,
    Callback = function(v) L.AntiAimSpinBotEnabled = v end
})
AntiA:AddSlider("AntiAimSpinBotDegreeRate", {
    Text = "Spin Bot Degree Rate",
    Min = -1800, Max = 1800, Default = 0, Rounding = 0, Compact = true,
    Callback = function(v) L.AntiAimSpinBotDegreeRate = v end
})
AntiA:AddSlider("AntiAimSpinBotWaveRate", {
    Text = "Spin Bot Wave Rate",
    Min = 0, Max = 10, Default = 0, Rounding = 0, Compact = true,
    Callback = function(v) L.AntiAimSpinBotWaveRate = v end
})
AntiA:AddDropdown("AntiAimSpinBotType", {
    Text = "Spin Type",
    Values = {"Custom", "Wave"},
    Default = "Custom",
    Callback = function(v) L.AntiAimSpinBotType = v end
})
AntiA:AddDivider()
AntiA:AddToggle("FakeLagEnabled", {
    Text = "Fake Lag",
    Default = false,
    Callback = function(v) L.FakeLagEnabled = v end
})
AntiA:AddSlider("FakeLagRefreshDistance", {
    Text = "Update Distance",
    Min = 0, Max = 3, Default = 3, Rounding = 1, Compact = true,
    Callback = function(v) L.FakeLagRefreshDistance = v end
})
AntiA:AddSlider("FakeLagRefreshRate", {
    Text = "Update Interval",
    Min = 0, Max = 1.2, Default = 0.5, Rounding = 2, Compact = true,
    Callback = function(v) L.FakeLagRefreshRate = v end
})
AntiA:AddToggle("FakePositionEnabled", {
    Text = "Fake Position",
    Default = false,
    Callback = function(v) L.FakePositionEnabled = v end
})
AntiA:AddSlider("FakePositionRadius", {
    Text = "Fake Position Radius",
    Min = 0.1, Max = 8.5, Default = 1, Rounding = 1, Compact = true,
    Callback = function(v) L.FakePositionRadius = v end
})
AntiA:AddSlider("FakePositionInterval", {
    Text = "Fake Position Interval",
    Min = 1, Max = 75, Default = 10, Rounding = 0, Compact = true,
    Callback = function(v) L.FakePositionInterval = v end
})

L.UnlocksGroup = Tabs.C:AddLeftGroupbox("Unlocks")
L.UnlockAllButton = L.UnlocksGroup:AddButton({
    Text = 'Unlock All',
    Func = function() if L.TriggerUnlockAll then L.TriggerUnlockAll() end end,
    DoubleClick = true,
    Tooltip = 'Unlocks all weapons, knifes & attachments'
})
L.UnlockAllButton:AddButton({
    Text = 'Unlock All Camos',
    Func = function() if L.TriggerUnlockCamos then L.TriggerUnlockCamos() end end,
    DoubleClick = true,
    Tooltip = 'Unlocks all camos for every weapon.'
})

local Notifications = Tabs.C:AddLeftGroupbox("Notifications")
Notifications:AddToggle("NotifyOnSpectator", {
    Text = "Notify On Spectator",
    Default = false
})
Notifications:AddToggle("NotifyOnKillToggle", {
    Text = "Notify On Kill",
    Default = false,
    Callback = function(v) L.NotifyOnKill = v end
})
Notifications:AddDropdown("NotifyOnKillOptions", {
    Values = {"Name", "Distance", "Hitpart"},
    Default = 1,
    Multi = true,
    Text = "Options",
    Callback = function(v) L.NotifyOnKillOptions = v end
})
local SoundGroup = Tabs.C:AddRightGroupbox("Sound")
SoundGroup:AddToggle('GunShotSound', {
    Text = 'Gunshot Sound Override',
    Default = false,
    Callback = function(v)
        L.GunshotOverride = v
    end
})
SoundGroup:AddDropdown('GunShotSoundIds', {
    Values = {
        'Minecraft experience',
        'Neverlose',
        'Gamesense',
        'One',
        'Bell',
        'Rust',
        'TF2',
        'Slime',
        'Among Us',
        'Minecraft',
        'CS:GO',
        'Saber',
        'Baimware',
        'Osu',
        'TF2 Critical',
        'Bat',
        'Call of Duty',
        'Bubble',
        'Pick',
        'Pop',
        'Bruh',
        '[Bamboo]',
        'Crowbar',
        'Weeb',
        'Beep',
        'Bambi',
        'Stone',
        'Old Fatality',
        'Click',
        'Ding',
        'Snow',
        'Laser',
        'Mario',
        'Steve',
        'Snowdrake',
        'Default'
    },
    Default = "",
    Multi = false,
    Text = 'Sound Selection',
    Callback = function(v)
        L.SelectedSound = v
    end
})
SoundGroup:AddSlider("SoundVolumeSlider", {
    Text = "Volume",
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        L.SoundVolume = v
    end
})
SoundGroup:AddToggle('HitSoundShot', {
    Text = 'Hit Sound Override',
    Default = false,
    Callback = function(v)
        L.HitSoundOverride = v
        local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
        for _, root in ipairs(playerGui:GetChildren()) do
            for _, s in ipairs(root:GetDescendants()) do
                if s:IsA("Sound") and s.Name=="hitmarker" then
                    if v then
                        applyHitSound(s)
                    else
                        restoreHitSound(s)
                    end
                end
            end
        end
    end
})
SoundGroup:AddDropdown('HitSoundShotDropdown', {
    Values = { "Minecraft experience","Neverlose","Gamesense","One","Bell","Rust","TF2","Slime","Among Us","Minecraft","CS:GO","Saber","Baimware","Osu","TF2 Critical","Bat","Call of Duty","Bubble","Pick","Pop","Bruh","[Bamboo]","Crowbar","Weeb","Beep","Bambi","Stone","Old Fatality","Click","Ding","Snow","Laser","Mario","Steve","Snowdrake","Default" },
    Default = L.HitSoundSelected,
    Multi = false,
    Text = 'Sound Selection',
    Callback = function(v)
        L.HitSoundSelected = v
        if L.HitSoundOverride then
            local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
            for _, root in ipairs(playerGui:GetChildren()) do
                for _, s in ipairs(root:GetDescendants()) do
                    if s:IsA("Sound") and s.Name=="hitmarker" then
                        applyHitSound(s)
                    end
                end
            end
        end
    end
})
SoundGroup:AddSlider("HitSoundVolumeSlider", {
    Text = "Volume",
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        L.HitSoundVolume = v
        if L.HitSoundOverride then
            local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
            for _, root in ipairs(playerGui:GetChildren()) do
                for _, s in ipairs(root:GetDescendants()) do
                    if s:IsA("Sound") and s.Name=="hitmarker" then
                        applyHitSound(s)
                    end
                end
            end
        end
    end
})
SoundGroup:AddToggle('KillSoundShot', {
    Text = 'Kill Sound Override',
    Default = false,
    Callback = function(v)
        L.KillSoundOverride = v
        local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
        for _, root in ipairs(playerGui:GetChildren()) do
            for _, s in ipairs(root:GetDescendants()) do
                if s:IsA("Sound") and (s.Name=="killshot" or s.Name=="headshotkill") then
                    if v then
                        applyKillSound(s)
                    else
                        restoreKillSound(s)
                    end
                end
            end
        end
    end
})
SoundGroup:AddDropdown('KillSoundShotDropdown', {
    Values = { "Minecraft experience","Neverlose","Gamesense","One","Bell","Rust","TF2","Slime","Among Us","Minecraft","CS:GO","Saber","Baimware","Osu","TF2 Critical","Bat","Call of Duty","Bubble","Pick","Pop","Bruh","[Bamboo]","Crowbar","Weeb","Beep","Bambi","Stone","Old Fatality","Click","Ding","Snow","Laser","Mario","Steve","Snowdrake","Default" },
    Default = L.KillSoundSelected or "Default",
    Multi = false,
    Text = 'Sound Selection',
    Callback = function(v)
        L.KillSoundSelected = v
        if L.KillSoundOverride then
            local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
            for _, root in ipairs(playerGui:GetChildren()) do
                for _, s in ipairs(root:GetDescendants()) do
                    if s:IsA("Sound") and (s.Name=="killshot" or s.Name=="headshotkill") then
                        applyKillSound(s)
                    end
                end
            end
        end
    end
})
SoundGroup:AddSlider("KillSoundVolumeSlider", {
    Text = "Volume",
    Default = 1,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        L.KillSoundVolume = v
        if L.KillSoundOverride then
            local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
            for _, root in ipairs(playerGui:GetChildren()) do
                for _, s in ipairs(root:GetDescendants()) do
                    if s:IsA("Sound") and (s.Name=="killshot" or s.Name=="headshotkill") then
                        applyKillSound(s)
                    end
                end
            end
        end
    end
})
game:GetService("Players").LocalPlayer.PlayerGui.DescendantAdded:Connect(function(c)
	if c:IsA("Sound") then
		if c.Name=="hitmarker" and L.HitSoundOverride then
			applyHitSound(c)
		elseif (c.Name=="killshot" or c.Name=="headshotkill") and L.KillSoundOverride then
			applyKillSound(c)
		end
	end
end)
game:GetService("Players").LocalPlayer.PlayerGui.HudScreenGui.Main.DisplayNotifications.ChildAdded:Connect(function(child)
	if child.Name == "DisplayBigAward" and Toggles.NotifyOnSpectator.Value then
		local enemy = child:WaitForChild("TextEnemy", 1)
		if enemy then
			local isAward = false
			local conns = {}
			local function chk(txt)
				local t = string.lower(txt)
				if string.find(t, "secured") or string.find(t, "picked") or string.find(t, "friend") then isAward = true end
			end
			local function hk(v)
				if v:IsA("TextLabel") and v ~= enemy then
					chk(v.Text)
					table.insert(conns, v:GetPropertyChangedSignal("Text"):Connect(function() chk(v.Text) end))
				end
			end
			for _, v in ipairs(child:GetDescendants()) do hk(v) end
			table.insert(conns, child.DescendantAdded:Connect(hk))
			
			local name = enemy.Text
			if name == "" then
				local start = tick()
				repeat task.wait() name = enemy.Text until name ~= "" or tick() - start > 1
			end
			
			if not isAward then
				local ew = tick()
				repeat task.wait() until isAward or tick() - ew > 0.25
			end
			for _, c in ipairs(conns) do c:Disconnect() end
			if isAward then return end
			if name ~= "" then
				Library:Notify(name .. " Is Now Spectating", 3)
				task.delay(3, function() Library:Notify(name .. " Is No Longer Spectating", 3) end)
			end
		end
	end
end)
task.spawn(function()
    local killfeedContainer = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HudScreenGui"):WaitForChild("Main"):WaitForChild("DisplayKillfeed"):WaitForChild("Container")
    killfeedContainer.ChildAdded:Connect(function(child)
        if not L.NotifyOnKill then return end
        if child.Name ~= "DisplayKillfeedLine" then return end
        
        task.spawn(function()
            local textKillfeed = child:WaitForChild("TextKillfeed", 0.5)
            if not textKillfeed then return end
            
            local t = tick()
            repeat task.wait() until textKillfeed.Text ~= "Label" and textKillfeed.Text ~= "" or tick() - t > 0.5
            
            local textDistance = textKillfeed:FindFirstChild("TextDistance")
            
            local killer, victim
            for v in textKillfeed.Text:gmatch(">([^<]+)</font>") do
                if not killer then killer = v end
                victim = v
            end
            
            if killer ~= game:GetService("Players").LocalPlayer.Name then return end
            if killer == victim then return end
            
            local opts = L.NotifyOnKillOptions or {}
            local msg = "Killed"
            
            if opts["Name"] and victim then
                msg = msg .. " " .. victim
            else
                if opts["Distance"] and not opts["Hitpart"] then
                    msg = msg .. " player"
                else
                    msg = msg .. " Player"
                end
            end
            
            if opts["Distance"] and textDistance then
                local distStr = textDistance.Text:match("([%d%.]+)") or "0"
                msg = msg .. " from " .. distStr .. " studs away"
            end
            
            if opts["Hitpart"] then
                local imgHead = child:FindFirstChild("ImageHeadshot")
                local isHead = imgHead and imgHead.Visible
                msg = msg .. " [" .. (isHead and "Head" or "Body") .. "]"
            end
            
            Library:Notify(msg, 3)
        end)
    end)
end)
local Ts = game:GetService("TweenService")
local fadeInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local isMiniAmmoVisible = false
RunService.RenderStepped:Connect(function()
	if not extracount.Value then
		L.MiniUI.Enabled=false
		isMiniAmmoVisible=false
		for _, v in ipairs(L.MiniOuterBorder:GetDescendants()) do
			if v:IsA("Frame") then v.BackgroundTransparency = 1 end
			if v:IsA("TextLabel") then v.TextTransparency = 1; v.TextStrokeTransparency = 1 end
		end
		L.MiniOuterBorder.BackgroundTransparency = 1
		return
	end
	local magText = Hud.TextMagCount.Text
	local spareText = Hud.TextSpareCount.Text
	local currentAmmo = tonumber(magText) or 0
	local spareAmmo = tonumber(spareText) or 0
	local isHudVisible = false
	if Hud.TextMagCount and Hud.TextMagCount.Visible and Hud.TextMagCount.Parent and Hud.TextMagCount.Parent.Visible then
		isHudVisible = true
	end
	local hasAmmo = (currentAmmo ~= 0 or spareAmmo ~= 0)
	if hasAmmo and isHudVisible then
		L.AmmoLabel.Text = currentAmmo .. " / " .. spareAmmo
		L.MiniAccentLine.BackgroundColor3 = Library.AccentColor
		if not isMiniAmmoVisible then
			isMiniAmmoVisible = true
			L.MiniUI.Enabled = true
			Ts:Create(L.MiniOuterBorder, fadeInfo, {BackgroundTransparency = 0}):Play()
			for _, v in ipairs(L.MiniOuterBorder:GetDescendants()) do
				if v:IsA("Frame") then
					if v.Name ~= "Background" then 
						Ts:Create(v, fadeInfo, {BackgroundTransparency = 0}):Play()
					else
						Ts:Create(v, fadeInfo, {BackgroundTransparency = 0}):Play()
					end
				elseif v:IsA("TextLabel") then
					Ts:Create(v, fadeInfo, {TextTransparency = 0, TextStrokeTransparency = 0}):Play()
				end
			end
		end
	else
		if isMiniAmmoVisible then
			isMiniAmmoVisible = false
			Ts:Create(L.MiniOuterBorder, fadeInfo, {BackgroundTransparency = 1}):Play()
			for _, v in ipairs(L.MiniOuterBorder:GetDescendants()) do
				if v:IsA("Frame") then
					Ts:Create(v, fadeInfo, {BackgroundTransparency = 1}):Play()
				elseif v:IsA("TextLabel") then
					Ts:Create(v, fadeInfo, {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
				end
			end
		end
	end
end)
pcall(function()
	workspace.StreamingEnabled=false
end)
Library:SetWatermarkVisibility(true)
local FrameTimer=tick()
local FrameCounter=0
local FPS=60
local GetPing=(function()
	return math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
end)
local CanDoPing=pcall(function()
	return GetPing()
end)
local WatermarkConnection=RunService.RenderStepped:Connect(function()
	FrameCounter+=1
	if (tick()-FrameTimer)>=1 then
		FPS=FrameCounter
		FrameTimer=tick()
		FrameCounter=0
	end
	if CanDoPing then
		Library:SetWatermark(('roxy.win / dev | %d fps | %d ms'):format(math.floor(FPS),GetPing()))
	else
		Library:SetWatermark(('roxy.win | %d fps'):format(math.floor(FPS)))
	end
end)
Library:OnUnload(function()
	L.AimbotEnabled = false
	L.ShowFOV = false
	L.ChamsEnabled = false
	L.BoxESPEnabled = false
	L.CrosshairEnabled = false
	L.GunshotOverride = false
	L.KillSoundOverride = false
	L.HitSoundOverride = false
	L.SkyboxEnabled = false
	L.NameESPEnabled = false
	L.DistanceESPEnabled = false
	L.WeaponESPEnabled = false
	L.ViewModelEnabled = false
	L.WeaponMasterEnabled = false
	L.HealthESPEnabled = false
	L.SnapEnabled = false
	L.KillNotifyEnabled = false
	L.WalkSpeedEnabled = false
	L.MasterEnabled = false
	L.HighlightEnabled = false
	L.SilentEnabled = false
	Lighting.Ambient = L.OriginalValues.Ambient
	if L.OriginalClockTime then Lighting.ClockTime = L.OriginalClockTime end
	local sky = Lighting:FindFirstChildOfClass("Sky")
	if sky then sky:Destroy() end
	local origSky = Lighting:FindFirstChild("OriginalSkyBackup")
	if origSky then origSky:Clone().Parent = Lighting end
	local hum = findHumanoid()
	if hum then hum.WalkSpeed = 16 end
	restoreHideArms()
	restoreArmMaterial()
	restoreWeaponMaterial()
	SetSleeveSlotsTransparency(0)
	for s, old in pairs(L.HitSoundBackup) do
		if s and s:IsDescendantOf(game) then s.SoundId = old.Id s.Volume = old.Volume end
	end
	for s, old in pairs(L.KillSoundBackup) do
		if s and s:IsDescendantOf(game) then s.SoundId = old.Id s.Volume = old.Volume end
	end
	for s, old in pairs(L.SoundBackup) do
		if s and s:IsDescendantOf(game) then s.SoundId = old.Id s.Volume = old.Volume end
	end
	if L.MiniUI then L.MiniUI:Destroy() end
	for _,h in pairs(L.ArmHighlights) do pcall(function() h:Destroy() end) end
	for _,h in pairs(L.WeaponHighlights) do pcall(function() h:Destroy() end) end
	for m,_ in pairs(L.ActiveChams) do clearChams(m) end
	pcall(function()
		for _,v in pairs(L.DistanceDrawings) do v:Remove() end
		for _,v in pairs(L.WeaponDrawings) do v:Remove() end
		for _,v in pairs(L.NameDrawings) do v:Remove() end
		for _, boxes in pairs(L.BoxDrawings) do
			for _, l in ipairs(boxes) do l:Remove() end
		end
		for _, outlines in pairs(L.BoxOutlineDrawings) do
			for _, l in ipairs(outlines) do l:Remove() end
		end
		for _,v in pairs(L.HealthDrawings) do v:Remove() end
		for _,v in pairs(L.HealthOutlineDrawings) do v:Remove() end
		for i=1,4 do 
            lines[i]:Remove() 
            outlines[i]:Remove() 
            flapLines[i]:Remove()
            flapOutlines[i]:Remove()
        end
        for i=1,6 do
            starLines[i]:Remove()
            starOutlines[i]:Remove()
        end
		if dot then dot:Remove() end
		if dotOutline then dotOutline:Remove() end
		if SnapLine then SnapLine:Remove() end
		if SnapOutline then SnapOutline:Remove() end
		if FOVCircle then FOVCircle:Remove() end
		if FOVOutline then FOVOutline:Remove() end
		if SilentSnapLine then SilentSnapLine:Remove() end
		if SilentSnapOutline then SilentSnapOutline:Remove() end
		if SilentFOVCircle then SilentFOVCircle:Remove() end
		if SilentFOVOutline then SilentFOVOutline:Remove() end
	end)
	WatermarkConnection:Disconnect()
	Library.Unloaded = true
end)
local MenuGroup=Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddToggle("KeybindMenuOpen",{
	Default=Library.KeybindFrame.Visible,
	Text="Open Keybind Menu",
	Callback=function(v)
		Library.KeybindFrame.Visible=v
	end
})
MenuGroup:AddToggle("ShowCustomCursor",{
	Text="Custom Cursor",
	Default=false,
	Callback=function(v)
		Library.ShowCustomCursor=v
	end
})

MenuGroup:AddToggle("HideLogo",{
	Text="Hide Logo",
	Default=false,
	Callback=function(v)
		Library.HideImages=v
		if Library.BackgroundImage then
			Library.BackgroundImage.Visible = not v
		end
	end
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind",{Default="RightShift",NoUI=true,Text="Menu keybind"})
MenuGroup:AddButton("Unload",function()
	Library:Unload()
end)
MenuGroup:AddDropdown("NotificationPosition", {
    Values = {"Left", "Right", "Bottom"},
    Default = "Bottom",
    Multi = false,
    Text = "Notification Position",
    Callback = function(v)
        Library.NotifySide = v
    end
})
local text="you're a customer.."
local label=MenuGroup:AddLabel("")
label.RichText=true
task.spawn(function()
	while true do
        local color = string.format("rgb(%d,%d,%d)", Library.AccentColor.R * 255, Library.AccentColor.G * 255, Library.AccentColor.B * 255)
		for i=1,#text do
			label:SetText('<font color="'..color..'">'..text:sub(1,i)..'</font>')
			task.wait(0.05)
		end
		task.wait(0.3)
		for i=#text-1,0,-1 do
			label:SetText('<font color="'..color..'">'..text:sub(1,i)..'</font>')
			task.wait(0.05)
		end
		task.wait(0.1)
	end
end)
local baseTitle = "                                                                                       "
local current = "roxy.win"
local flickerChar = "$$"
task.spawn(function()
	local visible = true
	while true do
		local accent = Library.AccentColor
		local color = visible and "FFFFFF" or string.format("%02X%02X%02X", accent.R * 255, accent.G * 255, accent.B * 255)
		local left = '<font color="#' .. color .. '">$$</font>'
		local right = '<font color="#' .. color .. '">$$</font>'
		Window:SetWindowTitle(baseTitle .. left .. " " .. current .. " " .. right)
		visible = not visible
		task.wait(0.5)
	end
end)
Library.ToggleKeybind=Options.MenuKeybind
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder('Roxy.win')
SaveManager:SetFolder('Roxy.win/Phantom-Forces')
SaveManager:SetSubFolder('specific-place')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
    task.spawn(function()

    local requirefunc = getrenv().shared.require

    local modules = setmetatable({}, {
        __index = function(_, Property)
            return requirefunc(Property)
        end
    })

    local network = modules.NetworkClient
    local cframeLib = modules.CFrameLib
    local recoil = modules.RecoilSprings
    local cameraObject = modules.MainCameraObject
    local firearmObject = modules.FirearmObject
    local contentInterface = modules.ContentInterface
    local charInterface = modules.CharacterInterface
    local weaponInterface = modules.WeaponControllerInterface
    local bulletObject = modules.BulletObject
    local publicSettings = modules.PublicSettings
    local replicationInterface = modules.ReplicationInterface
    local screenCull = modules.ScreenCull
    local thirdPersonObject = modules.ThirdPersonObject
    local bulletCheck = modules.BulletCheck
    local effects = modules.Effects
    local charObject = modules.CharacterObject
    local audioSystem = modules.AudioSystem
    local crosshairsInterface = modules.HudCrosshairsInterface
    local replicationObject = modules.ReplicationObject
    local activeLoadoutUtils = modules.ActiveLoadoutUtils
    local playerDataClientInterface = modules.PlayerDataClientInterface
    L.Storage = {}
    L.TriggerUnlockAll = function()
        L.UnlockAll, L.UnlockKnives, L.UnlockAttachments = true, true, true
        local pData = modules.PlayerDataClientInterface.getPlayerData()
        if pData then
            pData.unlockAll = true
            local cData = modules.PlayerDataUtils.getClassData(pData)
            if cData then
                for _, cl in ipairs({"Assault", "Scout", "Support", "Recon"}) do
                    local pri = cData[cl].Primary.Name
                    local sec = cData[cl].Secondary.Name
                    L.FakeWeapons[cl] = {pri, sec}
                    L.RealWeapons[cl] = {pri, sec}
                end
            end
        end
    end
    L.TriggerUnlockCamos = function()
        L.UnlockCamos = true
        if not L.camoDatabase then
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Mentha Spicata") and rawget(v, "Dove blue") then
                    L.camoDatabase = v
                    break
                end
            end
        end
        if L.camoDatabase then
            local pData = modules.PlayerDataClientInterface.getPlayerData()
            if pData then
                for cName, cData in pairs(L.camoDatabase) do
                    if cData.Case then
                        modules.PlayerDataUtils.getCasePacketData(pData, cData.Case, true).Skins[cName] = {ALL = true}
                    end
                end
            end
        end
    end
    local ThirdPerson = { Active = false; ThirdPersonObject = nil } do
        local newReplicationObject = replicationObject.new;
        local FakePlayer = Instance.new('Player');
        FakePlayer.Name = LocalPlayer.Name;
        debug.setupvalue(newReplicationObject, 3, FakePlayer);
        L.ThirdPersonEnabled = false
        L.ThirdPersonDistance = 7
        L.ThirdPersonMode = 'Interpolation'
        L.ThirdPersonReplicationDelay = 0
        function ThirdPerson:Init()
            if self.Initializing then return end
            self.Initializing = true
            local oldFakePlayer = debug.getupvalue(newReplicationObject, 3);
            debug.setupvalue(newReplicationObject, 3, FakePlayer);
            local Entry
            for i = 1, 10 do
                Entry = replicationInterface.getEntry(LocalPlayer)
                if Entry then break end
                if not replicationInterface.getEntry(LocalPlayer) then
                    replicationInterface.addEntry(LocalPlayer)
                end
                task.wait(0.1)
            end
            if not Entry then
                warn("roxy.win / failed to get local player entry for third person")
                self.Initializing = false
                return
            end
            local Loadout = self:GetLoadout();
            Entry:spawn(Vector3.zero, Loadout);
            debug.setupvalue(newReplicationObject, 3, oldFakePlayer);
            local SmoothReplicator = Entry._smoothReplication;
            local setCharacterRender = Entry._thirdPersonObject.setCharacterRender
            Entry._thirdPersonObject.setCharacterRender = function(self, Visible)
                if L.ThirdPersonEnabled then
                    Visible = not L.ThirdPersonHideChar;
                end
                return setCharacterRender(self, Visible);
            end;
            if self.Active then
                Entry._thirdPersonObject:setCharacterRender(not L.ThirdPersonHideChar)
            end
            local PositionSpring = Entry._posspring;
            local AngleSpring = Entry._lookangles;
            if self.Replication then self.Replication:Disconnect() end
            local ThirdPersonReplication = RunService.Stepped:Connect(function()
                local CharacterObject = charInterface.getCharacterObject()
                if not CharacterObject then return end;
                local ThirdPersonObject = Entry:getThirdPersonObject();
                if not ThirdPersonObject then return end;
                rawset(self, 'ThirdPersonObject', ThirdPersonObject);
                Entry:step(true, 3);
                local Stance = CharacterObject:getMovementMode();
                ThirdPersonObject:setStance(self.Active and Stance:lower() or 'prone');
                if (not charInterface.isAlive()) and ThirdPersonObject._characterModel then
                    pcall(function() ThirdPersonObject._characterModel:PivotTo(CFrame.new(0, -500, 0)) end)
                    return
                end
                local Position, Angles = L.Storage.Repupdate, L.Storage.LookAngles;
                if Position and Angles then
                    Position = Position + (not self.Active and Vector3.new(0, -250, 0) or Vector3.zero);
                    local function processReplication()
                        setidentity(2);
                        SmoothReplicator:receive(os.clock(), tick(), {
                            breakcount = 0;
                            position = Position;
                            velocity = Vector3.zero;
                            angles = Angles;
                            t = tick();
                        }, true);
                        Entry:step(3, true);
                        setidentity(8);
                    end;
                    if L.ThirdPersonReplicationDelay and L.ThirdPersonReplicationDelay ~= 0 then
                        task.delay(L.ThirdPersonReplicationDelay, processReplication);
                    else
                        processReplication();
                    end;
                end;
            end);
            ThirdPerson.Replication = ThirdPersonReplication;
            self.Initializing = false
            self.Initialized = true
        end;
        local CharacterObjectDespawn = charInterface.despawn;
        function charInterface.despawn()
            setidentity(8)
            if ThirdPerson.Replication and ThirdPerson.ThirdPersonObject then
                if ThirdPerson.ThirdPersonObject._characterModel then
                    pcall(function() ThirdPerson.ThirdPersonObject._characterModel:PivotTo(CFrame.new(0, -500, 0)) end)
                end
                ThirdPerson.Replication:Disconnect();
                ThirdPerson.ThirdPersonObject._replicationObject:despawn();
                ThirdPerson.Replication = nil;
                ThirdPerson.ThirdPersonObject = nil;
            end;
            setidentity(2);
            return CharacterObjectDespawn();
        end;
        function ThirdPerson:GetLoadout()
            return activeLoadoutUtils.getActiveLoadoutData(playerDataClientInterface.getPlayerData());
        end;
        function ThirdPerson:Activate()
            self.Active = not self.Active;
            L.ThirdPersonEnabled = self.Active
            -- if Options.ThirdPersonEnabled then
            --     Options.ThirdPersonEnabled:SetValue(self.Active)
            -- end
            if self.Active and not self.Initialized then
                task.spawn(function() self:Init() end)
            end
            if self.ThirdPersonObject then
                self.ThirdPersonObject:setCharacterRender(self.Active and not L.ThirdPersonHideChar)
            end
        end;
        L.ThirdPerson = ThirdPerson
    end;
    L.SilentRE = replicationInterface
    if network and cframeLib and recoil and cameraObject and firearmObject and contentInterface and charInterface and weaponInterface and bulletObject and replicationInterface and publicSettings and bulletCheck then
        L.activeWeaponInterface = weaponInterface
        L.charInterface = charInterface
		L.publicSettings = publicSettings
        L.bulletCheck = bulletCheck
        L.networkClient = network
        L.effects = effects
        L.audioSystem = audioSystem
        L.crosshairsInterface = crosshairsInterface
        local setBaseWalkSpeed = charObject.setBaseWalkSpeed
        function charObject:setBaseWalkSpeed(speed)
            L.newSpawnCache.walkSpeed = L.newSpawnCache.walkSpeed or speed
            return setBaseWalkSpeed(self, L.WalkSpeedEnabled and L.TARGET_WALKSPEED or speed)
        end
        local CFIdentity = CFrame.identity
        RunService.RenderStepped:Connect(function()
            if Options.ThirdPersonEnabled and Options.ThirdPersonEnabled.Value then return end
            local activeInterface = L.activeWeaponInterface
            local controller = activeInterface and activeInterface.getActiveWeaponController()
            if not controller then return end
            local weapon = controller:getActiveWeapon()
            if not weapon or not weapon._mainOffset then return end
            local name = weapon.weaponName or "Unknown"
            local original = L.OriginalOffsets[name]
            if not original then
                original = weapon._mainOffset
                L.OriginalOffsets[name] = original
            end
            local target = original
            if L.ViewmodelOffsetEnabled then
                if not (L.ViewmodelOffsetRemoveOnAim and weapon._aiming) then
                    target = original * (L.ViewmodelOffsetCFrame or CFIdentity)
                end
            end
            local current = weapon._mainOffset
            local posDiff = (current.p - target.p).Magnitude
            if posDiff > 0.001 then
                weapon._mainOffset = current:Lerp(target, 0.1)
            elseif posDiff > 0 then
                weapon._mainOffset = target
            end
        end)
        RunService.Stepped:Connect(function()
            local clockTime = os.clock()
            replicationInterface.operateOnAllEntries(function(player, entry)
                if entry._isEnemy then
                    local tpObj = rawget(entry, "_thirdPersonObject")
                    local character = tpObj and rawget(tpObj, "_characterModelHash")
                    L.movementCache.position[player] = L.movementCache.position[player] or {}
                    if character and character.Head then
                        table.insert(L.movementCache.position[player], 1, character.Head.Position)
                        table.remove(L.movementCache.position[player], 16)
                    end
                end
            end)
            table.insert(L.movementCache.time, 1, clockTime)
            table.remove(L.movementCache.time, 16)
        end)
        local offsetsB1 = table.create(16)
        local offsetsB2 = table.create(16)
        local function getPositionOffsets(origin, target, offset, method, count, buffer)
            buffer[1] = origin
            if offset and count and count > 1 then
                local methodType = method or "Spinning Cardinal"
                local angleOffset = 0
                if methodType == "Spinning Cardinal" then
                    angleOffset = (os.clock() * 3) % (math.pi * 2)
                elseif methodType == "Random" then
                    angleOffset = math.rad(math.random(1, 360))
                elseif methodType == "Cardinal" then
                    angleOffset = 0
                end
                local cframe = CFrame.new(origin, target) * CFrame.Angles(0, 0, angleOffset)
                local iters = count - 1
                for i = 1, iters do
                    local ang = (math.pi * 2 / iters) * i
                    buffer[i + 1] = cframe * (Vector3.new(math.cos(ang), math.sin(ang), 0) * offset)
                end
                return count
            end
            return 1
        end
        local cBuf = {}
        local cCount = 0
        local tBuf = {}
        local sBuf = {}
        local function sortDist(a, b) 
            if a and b and a.dist and b.dist then return a.dist < b.dist end
            return false
        end
        local function getClosestPlayers(position)
            cCount = 0
            L.SilentRE.operateOnAllEntries(function(player, entry)
                local tpObj = rawget(entry, "_thirdPersonObject")
                local character = tpObj and rawget(tpObj, "_characterModelHash")
                if entry._receivedPosition and entry._velspring and entry._velspring.t and character and entry._isEnemy and character.Head then
                    local charModel = tpObj.getCharacterModel and tpObj:getCharacterModel()
                    if charModel then
                        if not checkEnemyByModel(charModel) then return end
                    else
                        local torso = character["Torso"] or character["torso"]
                        if LocalTeam and torso then
                            local c = torso.Color
                            local isActuallyEnemy = (LocalTeam == "PHANTOMS" and c == L.BODY_COLOR.GHOSTS)
                                or (LocalTeam == "GHOSTS" and c == L.BODY_COLOR.PHANTOMS)
                            if not isActuallyEnemy then return end
                        elseif LocalTeam then
                            return
                        end
                    end
                    local dist = (character.Head.Position - position).Magnitude
                    cCount = cCount + 1
                    local item = cBuf[cCount]
                    if not item then
                        item = {}
                        cBuf[cCount] = item
                    end
                    item.entry = entry
                    item.dist = dist
                end
            end)
            if cCount == 0 then return nil end
            table.clear(sBuf)
            for i = 1, cCount do sBuf[i] = cBuf[i] end
            table.sort(sBuf, sortDist)
            table.clear(tBuf)
            for i = 1, math.min(cCount, 5) do 
                tBuf[i] = sBuf[i]
            end
            return tBuf
        end
        local raycastStep = 1 / 30
        local function scanPositions(origin, target, accel, speed, penetration, closestPlayers, playerIndex, collatRadius)
            local oCount = getPositionOffsets(origin, target, L.RageBotFirePosScan and L.RageBotFirePosOffset, L.RageBotFirePosMethod, L.RageBotFirePosCount or 5, offsetsB1)
            local tCount = getPositionOffsets(target, origin, L.RageBotHitPosScan and L.RageBotHitPosOffset, L.RageBotHitPosMethod, L.RageBotHitPosCount or 5, offsetsB2)
            local bestScore = -1
            local bOrigin, bTarget, bVel, bHitTime
            local validCount = 0
            for oIdx = oCount, 1, -1 do
                local newOrigin = offsetsB1[oIdx]
                for tIdx = tCount, 1, -1 do
                    if oIdx ~= 1 and tIdx ~= 1 and oIdx ~= tIdx and (oIdx + tIdx) % 11 ~= 0 then continue end
                    local newTarget = offsetsB2[tIdx]
                    local velocity, hitTime = L.complexTrajectory(newOrigin, accel, newTarget, speed)
                    if velocity and L.bulletCheck(newOrigin, newTarget, velocity, accel, penetration, raycastStep) then
                        local score = oIdx
                        if closestPlayers and collatRadius then
                            for cIdx = playerIndex + 1, #closestPlayers do
                                local cEntry = closestPlayers[cIdx].entry
                                if cEntry and cEntry._receivedPosition then
                                    local dist = (cEntry._receivedPosition - newTarget).Magnitude
                                    if dist <= collatRadius then
                                        local cVelocity = L.complexTrajectory(newOrigin, accel, cEntry._receivedPosition, speed)
                                        if cVelocity and L.bulletCheck(newOrigin, cEntry._receivedPosition, cVelocity, accel, penetration, raycastStep) then
                                            score = score + 100
                                        end
                                    end
                                end
                            end
                        end
                        if score >= bestScore then
                            bestScore = score
                            bOrigin = newOrigin
                            bTarget = newTarget
                            bVel = velocity
                            bHitTime = hitTime
                            if score >= 100 then
                                return bOrigin, bTarget, bVel, bHitTime 
                            end
                        end
                        validCount = validCount + 1
                        if validCount >= 3 then
                            return bOrigin, bTarget, bVel, bHitTime
                        end
                    end
                end
            end
            if bOrigin then return bOrigin, bTarget, bVel, bHitTime end
            return false
        end
        local newFrameTime, frameAcceleration, physicsignore, raycast, simulateBullet, drawTracer, drawSegment
        local nextShot = 0
        local nextScan = 0
        local ticket = 0
        local ticketAddition = 0
        local currentScanIndex = 1
        RunService.Heartbeat:Connect(function()
            local clockTime = os.clock()
            local newSpawnCache = L.newSpawnCache
            local activeInterface = L.activeWeaponInterface
            local controller = activeInterface and activeInterface.getActiveWeaponController()
            local weapon = controller and controller:getActiveWeapon()
            if L.RageBotAutoShoot and clockTime > nextShot and clockTime > nextScan and weapon and weapon._weaponData and newSpawnCache.lastUpdate then
                local origin = newSpawnCache.lastUpdate
                local closestPlayers = getClosestPlayers(origin)
                local data = weapon._weaponData
                local penetration = data.penetrationdepth
                local speed = data.bulletspeed
                if closestPlayers and penetration and speed and (weapon._magCount > 0 or weapon._spareCount > 0) then
                    local shotFired = false
                    local totalPlayers = #closestPlayers
                    if currentScanIndex > totalPlayers then currentScanIndex = 1 end
                    
                    local playersChecked = 0
                    local maxChecksPerFrame = math.max(1, math.floor(800 / ((L.RageBotFirePosCount or 5) * (L.RageBotHitPosCount or 5))))
                    
                    while playersChecked < maxChecksPerFrame and playersChecked < totalPlayers do
                        local playerIndex = currentScanIndex
                        local entryData = closestPlayers[playerIndex]
                        local entry = entryData.entry
                        local colRadius = L.CollatScanningEnabled and (L.CollatScanningRadius or 1) or nil
                        local newOrigin, newTarget, velocity, hitTime = scanPositions(origin, entry._receivedPosition, L.publicSettings.bulletAcceleration, speed, penetration, closestPlayers, playerIndex, colRadius)
                        
                        if newOrigin then
                            shotFired = true
                            if weapon._magCount < 1 then
                                if weapon._spareCount >= data.magsize then
                                    weapon._magCount = data.magsize
                                    weapon._spareCount = weapon._spareCount - weapon._magCount
                                else
                                    weapon._magCount = weapon._spareCount
                                    weapon._spareCount = 0
                                end
                                L.networkClient.send(L.networkClient, "reload")
                            end
                            local bullets = {}
                            local bulletData = {
                                camerapos = origin,
                                firepos = newOrigin,
                                bullets = bullets
                            }
                            for _ = 1, (data.pelletcount or 1) do
                                table.insert(bullets, {velocity.Unit, ticket + ticketAddition})
                                ticketAddition = ticketAddition + 1
                            end
                            local timeVal = L.networkClient.getTime() + newSpawnCache.latency + newSpawnCache.currentAddition
                            L.networkClient.send(L.networkClient, "newbullets", weapon.uniqueId, bulletData, timeVal)
                            for bulletIndex = 1, #bullets do
                                local theTicket = bullets[bulletIndex][2]
                                L.networkClient.send(L.networkClient, "bullethit", weapon.uniqueId, entry._player, newTarget, "Head", theTicket, timeVal)
                            end
                            if L.CollatScanningEnabled then
                                for cIdx = playerIndex + 1, #closestPlayers do
                                    local cEntryData = closestPlayers[cIdx]
                                    local cEntry = cEntryData.entry
                                    if cEntry and cEntry._receivedPosition then
                                        local dist = (cEntry._receivedPosition - newTarget).Magnitude
                                        if dist <= (L.CollatScanningRadius or 1) then
                                            local cOrigin, cTarget = scanPositions(origin, cEntry._receivedPosition, L.publicSettings.bulletAcceleration, speed, penetration)
                                            if cOrigin then
                                                for bulletIndex = 1, #bullets do
                                                    local theTicket = bullets[bulletIndex][2]
                                                    L.networkClient.send(L.networkClient, "bullethit", weapon.uniqueId, cEntry._player, cTarget, "Head", theTicket, timeVal)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            if L.BulletTracersEnabled then
                                if L.BulletTracerLink and L.RageBotFirePosScan and (newOrigin - origin).Magnitude > 0.1 then
                                    task.spawn(drawSegment, origin, newOrigin)
                                end
                                task.spawn(drawTracer, newOrigin, velocity, penetration)
                            end
                            if weapon._barrelPart then
                                local barrel = weapon._barrelPart
                                for _, c in ipairs(barrel:GetChildren()) do
                                    if c:IsA("ParticleEmitter") or c:IsA("PointLight") or c:IsA("Sound") or c.Name == "MuzzleFlash" then
                                        c:Destroy()
                                    end
                                end
                                L.effects.muzzleflash(barrel, data.hideflash, 0.9)
                                if data.type == "SNIPER" then
                                    L.audioSystem.play("metalshell", 0.1)
                                elseif data.type == "SHOTGUN" then
                                    L.audioSystem.play("shotWeaponshell", 0.2)
                                elseif data.type == "REVOLVER" and not data.caselessammo then
                                    L.audioSystem.play("metalshell", 0.15, 0.8)
                                end
                                if data.sniperbass then
                                    L.audioSystem.play("1PsniperBass", 0.75)
                                    L.audioSystem.play("1PsniperEcho", 1)
                                end
                                L.audioSystem.playSoundId(data.firesoundid, 2, data.firevolume, data.firepitch, barrel, nil, 0, 0.05)
                            end
                            if L.crosshairsInterface and not weapon._aiming then
                                L.crosshairsInterface.fireImpulse(data.crossexpansion)
                            end
                            local fireDelay = 60 / (data.variablefirerate and data.firerate[weapon._firemodeIndex] or data.firerate)
                            nextShot = clockTime + fireDelay
                            weapon._magCount = weapon._magCount - 1
                            break
                        end
                        currentScanIndex = (currentScanIndex % totalPlayers) + 1
                        playersChecked = playersChecked + 1
                    end
                    if not shotFired and playersChecked >= totalPlayers then
                        nextScan = clockTime + 0.015
                    end
                else
                    nextScan = clockTime + 0.015
                end
            end
        end)
        newFrameTime = 1 / 200
        frameAcceleration = Vector3.new(0, -workspace.Gravity, 0)
        physicsignore = {workspace.Terrain, workspace:FindFirstChild("Ignore"), workspace:FindFirstChild("Players"), workspace.CurrentCamera}
        local sharedRaycastParams = RaycastParams.new()
        sharedRaycastParams.IgnoreWater = true
        raycast = function(origin, direction, filterlist, whitelist)
            sharedRaycastParams.FilterDescendantsInstances = filterlist or physicsignore
            sharedRaycastParams.FilterType = whitelist and Enum.RaycastFilterType.Include or Enum.RaycastFilterType.Exclude
            local result = workspace:Raycast(origin, direction, sharedRaycastParams)
            if result then
                return result.Instance, result.Position, result.Normal
            end
            return nil, nil, nil
        end
        simulateBullet = function(origin, velocity, penetration)
            local newTime = 0
            local newOrigin = origin
            local newVelocity = velocity
            local newPenetration = penetration
            local ignoreList = {table.unpack(physicsignore)}
            local firstOrigin = origin
            local lastTarget = origin
            local hitDetermined = false
            while (newTime < 1) do
                local frameTime = newFrameTime
                local motion = (frameTime * newVelocity) + (((frameTime * frameTime) / 2) * frameAcceleration)
                local hit, enter = raycast(newOrigin, motion, ignoreList)
                if hit and hit.CanCollide and hit.Transparency ~= 1 and hit.Name ~= "Window" then
                    local canShoot = false
                    local normal = motion.Unit
                    local maxExtent = hit.Size.Magnitude * normal
                    local _, exit = raycast(enter + maxExtent, -maxExtent, {hit}, true)
                    if exit then
                        canShoot = true
                        newPenetration = newPenetration - normal:Dot(exit - enter)
                        if (newPenetration < 0) then
                            lastTarget = enter
                            hitDetermined = true
                            break
                        end
                    else
                        canShoot = true
                    end
                    if canShoot then
                        table.insert(ignoreList, hit)
                        local timePassed = (motion:Dot(enter - newOrigin) / motion:Dot(motion)) * frameTime
                        newOrigin = enter + (0.01 * (newOrigin - enter).Unit)
                        newVelocity = newVelocity + (timePassed * frameAcceleration)
                        newTime = newTime + timePassed
                        lastTarget = exit or enter
                    end
                else
                    lastTarget = newOrigin + motion
                    newOrigin = newOrigin + motion
                    newVelocity = newVelocity + (frameTime * frameAcceleration)
                    newTime = newTime + frameTime
                end
            end
            return firstOrigin, lastTarget
        end
        L.BulletTracersList = {}
        L.TracerPool = {}
        L.TransparencyCache = table.create(21)
        for i = 0, 20 do L.TransparencyCache[i] = NumberSequence.new(i / 20) end
        RunService.RenderStepped:Connect(function()
            local c = #L.BulletTracersList
            if c == 0 then return end
            local now = os.clock()
            for i = c, 1, -1 do
                local t = L.BulletTracersList[i]
                if not t.beam or not t.container or not t.beam.Parent then
                    if t.container then pcall(function() t.container:Destroy() end) end
                    table.remove(L.BulletTracersList, i)
                    continue
                end
                local passed = now - t.created
                if passed < 0.5 then
                    local pVal = 1 - (passed * 2)
                    local idx = math.clamp(math.floor(pVal * 20 + 0.5), 0, 20)
                    t.beam.Transparency = L.TransparencyCache[idx]
                elseif passed < t.duration then
                    if not t.fullyVisible then
                        t.beam.Transparency = L.TransparencyCache[0]
                        t.fullyVisible = true
                    end
                elseif passed < t.duration + 1 then
                    t.fullyVisible = false
                    local pVal = passed - t.duration
                    local idx = math.clamp(math.floor(pVal * 20 + 0.5), 0, 20)
                    t.beam.Transparency = L.TransparencyCache[idx]
                else
                    t.beam.Enabled = false
                    table.insert(L.TracerPool, t)
                    table.remove(L.BulletTracersList, i)
                end
            end
        end)
        drawSegment = function(firstOrigin, lastTarget)
            local tracerColor = L.TracerColor or Color3.fromRGB(83,132,171)
            local diameter = L.TracerSize or 0.1
            local duration = L.TracerDuration or 4
            local textureId = "rbxthumb://type=Asset&id=7151778311&w=420&h=420"
            local texSpeed = L.TracerAnimationSpeed or 3
            if L.TracerStyle == "2" then textureId = "rbxthumb://type=Asset&id=446111271&w=420&h=420"
            elseif L.TracerStyle == "3" then textureId = "rbxthumb://type=Asset&id=86406621856457&w=420&h=420"
            elseif L.TracerStyle == "4" then textureId = "rbxthumb://type=Asset&id=7151842833&w=420&h=420"
            elseif L.TracerStyle == "5" then textureId = "rbxthumb://type=Asset&id=15000399181&w=420&h=420"
            elseif L.TracerStyle == "6" then textureId = "rbxthumb://type=Asset&id=73663492833517&w=420&h=420" end
            local poolSize = #L.TracerPool
            local t
            if poolSize > 0 then
                t = L.TracerPool[poolSize]
                L.TracerPool[poolSize] = nil
                t.container.CFrame = CFrame.new(firstOrigin)
                t.a1.WorldPosition = firstOrigin
                t.a2.WorldPosition = lastTarget
                t.beam.Color = ColorSequence.new(tracerColor)
                t.beam.Width0 = diameter * 2.5
                t.beam.Width1 = diameter * 2.5
                t.beam.Texture = textureId
                t.beam.TextureSpeed = texSpeed
                t.beam.Transparency = L.TransparencyCache[20]
                t.beam.Enabled = true
                t.created = os.clock()
                t.duration = duration
                t.fullyVisible = false
            else
                local container = Instance.new("Part")
                container.Name = "TracerContainer"
                container.Anchored = true
                container.CanCollide = false
                container.Transparency = 1
                container.Size = Vector3.zero
                container.CFrame = CFrame.new(firstOrigin)
                container.Parent = workspace:FindFirstChild("Ignore") or workspace
                local a1 = Instance.new("Attachment", container)
                a1.WorldPosition = firstOrigin
                local a2 = Instance.new("Attachment", container)
                a2.WorldPosition = lastTarget
                local beam = Instance.new("Beam", container)
                beam.Attachment0 = a1
                beam.Attachment1 = a2
                beam.Color = ColorSequence.new(tracerColor)
                beam.Width0 = diameter * 2.5
                beam.Width1 = diameter * 2.5
                beam.Texture = textureId
                beam.TextureMode = Enum.TextureMode.Static
                beam.TextureLength = 4
                beam.TextureSpeed = texSpeed
                beam.Transparency = L.TransparencyCache[20]
                beam.ZOffset = 1
                beam.FaceCamera = true
                beam.LightEmission = 10
                beam.LightInfluence = 0
                t = {
                    container = container,
                    a1 = a1,
                    a2 = a2,
                    beam = beam,
                    created = os.clock(),
                    duration = duration,
                    fullyVisible = false
                }
            end
            table.insert(L.BulletTracersList, t)
        end
        drawTracer = function(origin, velocity, penetration, isSubPellet)
            if not L.BulletTracersEnabled then return end
            if isSubPellet then return end
            local firstOrigin, lastTarget = simulateBullet(origin, velocity, penetration)
            if not firstOrigin or not lastTarget then return end
            drawSegment(firstOrigin, lastTarget)
        end
        L.newbullet = bulletObject.new
        function bulletObject.new(bulletData)
            if bulletData.onplayerhit then
                if L.UnlockAll then
                    local controller = weaponInterface.getActiveWeaponController()
                    local weapon = controller and controller:getActiveWeapon()
                    local data = weapon and weapon:getWeaponData()
                    if data then
                        local pData = playerDataClientInterface.getPlayerData()
                        local cl = (pData and modules.PlayerDataUtils.getClassData(pData)) and modules.PlayerDataUtils.getClassData(pData).curclass
                        if cl and L.FakeWeapons[cl] and L.FakeWeapons[cl][controller:getActiveWeaponIndex()] == (data.displayname or data.name) then
                            local realSpeed = contentInterface.getWeaponData(L.FakeWeapons[cl][controller:getActiveWeaponIndex()], false).bulletspeed
                            if realSpeed then bulletData.velocity = bulletData.velocity.Unit * realSpeed end
                        end
                    end
                end
                if L.SilentEnabled and (L.SilentHitChance >= math.random(1, 100)) then
                    local targetPos, entry, targetPart = L:GetSilentClosestTarget((L.SilentHeadshotChance >= math.random(1, 100)) and "Head" or "Torso")
                    if targetPos then
                        local targetVelocity = Vector3.zero
                        if entry and entry._player then
                            local player = entry._player
                            if L.movementCache.position[player] and L.movementCache.position[player][15] and L.movementCache.time[15] then
                                targetVelocity = (L.movementCache.position[player][15] - L.movementCache.position[player][1]) / (L.movementCache.time[15] - L.movementCache.time[1])
                            end
                        end
                        local origin = bulletData.position
                        local velocity = (L.complexTrajectory(origin, bulletData.acceleration, targetPos, bulletData.velocity.Magnitude, targetVelocity))
                        bulletData.velocity = velocity
                    end
                end
                drawTracer(bulletData.position, bulletData.velocity, bulletData.penetrationdepth, bulletData.isSubPellet)
            end
            return L.newbullet(bulletData)
        end
        local send = network.send
        function network:send(name, ...)
            local Arguments = { ... }
            if name == "spawn" then
                L.LastSpawnTime = tick()
                task.spawn(function()
                    local start = tick()
                    repeat task.wait() until charInterface.isAlive() or (tick() - start > 5);
                    if not charInterface.isAlive() then return end
                    L.ThirdPerson:Init();
                end);
            end
            if not L.ThirdPersonInitialized then
                L.ThirdPersonInitialized = true
                task.spawn(function()
                    local start = tick()
                    repeat task.wait() until charInterface.isAlive() or (tick() - start > 5);
                    if charInterface.isAlive() then
                        L.ThirdPerson:Init();
                    end
                end)
            end
            if name == "repupdate" then
                local position, angles, angles2, time = ...
                if L.AntiAimEnabled and L.FakeLagEnabled then
                    if not L.fakelag_lastRefreshPosition or not L.fakelag_lastRefreshTime then
                        L.fakelag_lastRefreshPosition = position
                        L.fakelag_lastRefreshTime = tick()
                    end
                    local dt = tick() - L.fakelag_lastRefreshTime
                    local dist = (position - L.fakelag_lastRefreshPosition).Magnitude
                    
                    local safeDistance = L.FakeLagRefreshDistance or 5
                    if dt > 0 and (dist / dt) > 25 then
                        safeDistance = math.min(safeDistance, 3.25)
                    end
                    
                    if (dist > safeDistance) or (dt > math.clamp(L.FakeLagRefreshRate or 0.5, 0, 1.5)) then
                        L.fakelag_lastRefreshPosition = position
                        L.fakelag_lastRefreshTime = tick()
                    else
                        return
                    end
                else
                    L.fakelag_lastRefreshPosition = nil
                    L.fakelag_lastRefreshTime = nil
                end
                if L.AntiAimEnabled and L.FakePositionEnabled then
                    L.fakePos_Tick = (L.fakePos_Tick or 0) + 1
                    if L.fakePos_Tick >= (L.FakePositionInterval or 1) then
                        L.fakePos_Tick = 0
                        local rad = L.FakePositionRadius or 1
                        L.fakePos_Offset = Vector3.new((math.random() - 0.5) * 2 * rad, 0, (math.random() - 0.5) * 2 * rad)
                    end
                    position = position + (L.fakePos_Offset or Vector3.zero)
                end
                L.Storage.Repupdate = position
                if L.AntiAimEnabled then
                    local X, Y, Z = angles.X, angles.Y, angles.Z
                    if L.AntiAimYawEnabled then
                        if L.AntiAimYawType == "Custom" then
                            Y = Y + math.rad(L.AntiAimYawAngle)
                        elseif L.AntiAimYawType == "Wave" then
                            Y = Y + math.rad(math.sin(tick() * L.AntiAimYawWaveRate) * L.AntiAimYawWaveDegree)
                        end
                    end
                    if L.AntiAimPitchEnabled then
                        if L.AntiAimPitchType == "Custom" then
                            X = L.AntiAimPitchAngle / 45
                        elseif L.AntiAimPitchType == "Wave" then
                            X = math.sin((tick() - L.StartTime) * L.AntiAimPitchWaveRate) * 2
                        end
                    end
                    if L.AntiAimSpinBotEnabled then
                        Y = Y + (tick() - L.StartTime) * math.rad(L.AntiAimSpinBotDegreeRate * ((L.AntiAimSpinBotType == "Wave") and math.sin(tick()) * (L.AntiAimSpinBotWaveRate) or 1))
                    end
                    angles = Vector3.new(X, Y, Z)
                end
                L.Storage.LookAngles = angles
                if L.newSpawnCache.updateDebt > 0 then
                    L.newSpawnCache.updateDebt = L.newSpawnCache.updateDebt - 1
                    return
                end
                if L.WalkSpeedEnabled and L.newSpawnCache.lastUpdate then
                    send(self, name, L.newSpawnCache.lastUpdate, angles, angles2, time + L.newSpawnCache.latency + L.newSpawnCache.currentAddition)
                    L.newSpawnCache.updateDebt = L.newSpawnCache.updateDebt + 1
                end
                L.newSpawnCache.lastUpdateTime = time
                L.newSpawnCache.lastUpdate = position
                local Object = L.ThirdPerson.ThirdPersonObject;
                if Object and L.ThirdPerson.Active then
                end
                return send(self, name, position, angles, angles2, time + L.newSpawnCache.latency + L.newSpawnCache.currentAddition)
            elseif name == "ping" then
                local a, b, c = ...
                local add = L.newSpawnCache.latency + L.newSpawnCache.currentAddition
                return send(self, name, a, b + add, c + add)
            elseif name == "newbullets" then
                local uniqueId, bulletData, time = ...
                local Object = L.ThirdPerson.ThirdPersonObject;
                if Object and L.ThirdPerson.Active then
                    Object:kickWeapon(0, 0, 0, 0);
                end
                if L.SilentEnabled and (L.SilentHitChance >= math.random(1, 100)) then
                    local targetPos, entry, targetPart = L:GetSilentClosestTarget((L.SilentHeadshotChance >= math.random(1, 100)) and "Head" or "Torso")
                    if targetPos then
                        local activeController = weaponInterface.getActiveWeaponController()
                        local activeWeapon = activeController and activeController:getActiveWeapon()
                                if activeWeapon then
                                    local targetVelocity = vector3_zero
                                    if entry and entry._player then
                                        local player = entry._player
                                        local posCache = L.movementCache.position[player]
                                        local timeCache = L.movementCache.time
                                        if posCache and posCache[15] and timeCache[15] then
                                            targetVelocity = (posCache[15] - posCache[1]) / (timeCache[15] - timeCache[1])
                                        end
                                    end
                                    local speed = activeWeapon._weaponData.bulletspeed
                                    local rawVel = speed and L.complexTrajectory(bulletData.firepos, L.publicSettings.bulletAcceleration, targetPos, speed, targetVelocity)
                                    local velocity = rawVel and rawVel.Unit
                                    for idx, bullet in bulletData.bullets do
                                        if velocity then bullet[1] = velocity end
                                        if idx > 1 then
                                            bullet.isSubPellet = true
                                        end
                                    end
                                end
                    end
                end
                return send(self, name, uniqueId, bulletData, time)
            elseif name == "equip" then
                local Object = L.ThirdPerson.ThirdPersonObject;
                if Object and L.ThirdPerson.Active then
                    local Slot = Arguments[1];
                    if Slot == 3 then
                        Object:equipMelee();
                    else
                        Object:equip(Slot);
                    end;
                end
            elseif name == "sprint" then
                local Object = L.ThirdPerson.ThirdPersonObject;
                if Object and L.ThirdPerson.Active then
                    Object:setSprint(Arguments[1]);
                end
            elseif name == "aim" then
                local Object = L.ThirdPerson.ThirdPersonObject;
                if Object and L.ThirdPerson.Active then
                    Object:setAim(Arguments[1]);
                end
            elseif name == "stab" then
                local Object = L.ThirdPerson.ThirdPersonObject;
                if Object and L.ThirdPerson.Active then
                    Object:stab();
                end
            end
            if name == "changeCamo" and L.UnlockCamos then return end
            if name == "changeAttachment" and L.UnlockAttachments then return end
            if name == "changeWeapon" then
                local slot, weapon = ...
                if L.UnlockKnives and slot == "Knife" then return end
                if L.UnlockAll then
                    local pData = playerDataClientInterface.getPlayerData()
                    local cl = (pData and modules.PlayerDataUtils.getClassData(pData)) and modules.PlayerDataUtils.getClassData(pData).curclass
                    if cl then
                        local newPData = table.clone(pData)
                        newPData.unlockAll = false
                        if slot == "Primary" then
                            L.FakeWeapons[cl][1] = weapon
                            if modules.PlayerDataUtils.ownsWeapon(newPData, weapon) then L.RealWeapons[cl][1] = weapon end
                        elseif slot == "Secondary" then
                            L.FakeWeapons[cl][2] = weapon
                            if modules.PlayerDataUtils.ownsWeapon(newPData, weapon) then L.RealWeapons[cl][2] = weapon end
                        end
                    end
                end
            end
            if name == "falldamage" and L.NoFallDamageEnabled then return end
            return send(self, name, ...)
        end

        L.getWeaponDataOriginal = contentInterface.getWeaponData
        function contentInterface.getWeaponData(weaponName, makeClone)
            local data = L.getWeaponDataOriginal(weaponName, makeClone)
            if makeClone and L.UnlockAll then
                local p = playerDataClientInterface.getPlayerData()
                local cl = (p and modules.PlayerDataUtils.getClassData(p)) and modules.PlayerDataUtils.getClassData(p).curclass
                if cl and L.FakeWeapons[cl] then
                    for s, fn in pairs(L.FakeWeapons[cl]) do
                        if fn == (data.displayname or data.name) and L.RealWeapons[cl][s] then
                            local r = L.getWeaponDataOriginal(L.RealWeapons[cl][s], false)
                            if r then
                                setreadonly(data, false)
                                local cap = r.firecap or (r.variablefirerate and math.max(unpack(r.firerate))) or r.firecap
                                if data.variablefirerate then for i, v in ipairs(data.firerate) do data.firerate[i] = math.min(v, cap) end elseif data.firerate > cap then data.firerate = cap end
                                if data.firecap and data.firecap > cap then data.firecap = cap end
                                if r.magsize then if data.magsize > r.magsize then data.magsize, data.sparerounds = r.magsize, r.sparerounds else data.sparerounds = (r.magsize + r.sparerounds) - data.magsize end end
                                data.pelletcount, data.penetrationdepth, data.bulletspeed = r.pelletcount, r.penetrationdepth, r.bulletspeed
                            end; break
                        end
                    end
                end
            end
            return data
        end

        L.ownsWeaponOriginal = modules.PlayerDataUtils.ownsWeapon
        L.weaponDatabaseFolder = ReplicatedStorage.Content.ProductionContent.WeaponDatabase
        function modules.PlayerDataUtils.ownsWeapon(player, weapon)
            if L.UnlockKnives then
                local w = string.upper(weapon)
                for _, i in ipairs({"ONE HAND BLUNT", "ONE HAND BLADE", "TWO HAND BLUNT", "TWO HAND BLADE"}) do
                    local t = L.weaponDatabaseFolder:FindFirstChild(i)
                    if t and t:FindFirstChild(w) then return true end
                end
            end
            return L.ownsWeaponOriginal(player, weapon)
        end

        L.getUnlocksDataOriginal = modules.PlayerDataUtils.getUnlocksData
        function modules.PlayerDataUtils.getUnlocksData(player)
            local unlocks = L.getUnlocksDataOriginal(player)
            if L.UnlockAttachments and player == playerDataClientInterface.getPlayerData() then
                local old = unlocks
                unlocks = setmetatable({}, {__index = function(self, k) local val = old[k] if not val then val = {} old[k] = val end val.kills = 1e9 return val end, __newindex = function(self, k, v) old[k] = v end})
            end
            return unlocks
        end
        local applyImpulse = recoil.applyImpulse
        function recoil.applyImpulse(...)
            if L.NoRecoil then return end
            return applyImpulse(...)
        end
        local reload = firearmObject.reload
        function firearmObject:reload()
            if L.InstantReload and self._spareCount > 0 then
                if self._spareCount >= self._weaponData.magsize then
                    self._spareCount = self._spareCount - (self._weaponData.magsize - self._magCount)
                    self._magCount = self._weaponData.magsize
                else
                    self._magCount = self._spareCount
                    self._spareCount = 0
                end
                network:send("reload")
                return
            end
            return reload(self)
        end
        local computeWalkSway = firearmObject.computeWalkSway
        function firearmObject:computeWalkSway(dy, dx)
            if L.NoWalkSway then dy = 0; dx = 0 end
            return computeWalkSway(self, dy, dx)
        end
        local computeGunSway = firearmObject.computeGunSway
        function firearmObject.computeGunSway(...)
            if L.NoGunSway then return CFrame.identity end
            return computeGunSway(...)
        end
        local fromAxisAngle = cframeLib.fromAxisAngle
        function cframeLib.fromAxisAngle(x, y, z)
            if L.NoCameraSway then
                local controller = weaponInterface.getActiveWeaponController()
                local weapon = controller and controller:getActiveWeapon()
                return (weapon and weapon._blackScoped and CFrame.identity) or fromAxisAngle(x, y, z)
            end
            return fromAxisAngle(x, y, z)
        end
        local getWeaponStat = firearmObject.getWeaponStat
        function firearmObject:getWeaponStat(stat)
            if L.NoSpread and stat and stat:match('spread') then
                local spreadSpring = self._spreadSpring
                if spreadSpring then
                    spreadSpring._p0 = Vector3.zero
                    spreadSpring._v0 = Vector3.zero
                end
            end
            return getWeaponStat(self, stat)
        end
        local instantAimOriginals = setmetatable({}, {__mode = "k"})
        RunService.RenderStepped:Connect(function()
            local controller = weaponInterface and weaponInterface.getActiveWeaponController()
            local weapon = controller and controller.getActiveWeapon and controller:getActiveWeapon()
            if weapon and weapon.getWeaponType and weapon:getWeaponType() == 'Firearm' then
                local aimStats = weapon._activeAimStats and weapon._activeAimStats[weapon._activeAimStatIndex]
                if aimStats then
                    if not instantAimOriginals[aimStats] then
                        instantAimOriginals[aimStats] = {
                            aimspeed = aimStats.aimspeed,
                            magnifyspeed = aimStats.magnifyspeed,
                            unaimspeed = aimStats.unaimspeed,
                            unmagnifyspeed = aimStats.unmagnifyspeed,
                        }
                    end
                    if L.InstantAim then
                        aimStats.aimspeed = 999
                        aimStats.magnifyspeed = 999
                        aimStats.unaimspeed = 999
                        aimStats.unmagnifyspeed = 999
                    else
                        local orig = instantAimOriginals[aimStats]
                        aimStats.aimspeed = orig.aimspeed
                        aimStats.magnifyspeed = orig.magnifyspeed
                        aimStats.unaimspeed = orig.unaimspeed
                        aimStats.unmagnifyspeed = orig.unmagnifyspeed
                    end
                end
            end
            if L.InstantEquip then
                local charObject = charInterface and charInterface.getCharacterObject()
                if charObject then
                    local equipSpring = charObject:getSpring('equipspring')
                    if equipSpring then
                        equipSpring.s = 999
                    end
                end
            end
        end)
        local mainStep = cameraObject.step
        cameraObject.step = function(self, dt)
            local characterObject = charInterface.getCharacterObject()
            local l_NoCameraSway = L.NoCameraSway
            local l_NoCameraBob = L.NoCameraBob
            local useNoBob = l_NoCameraBob and characterObject
            local stepDt = l_NoCameraSway and 0 or dt
            if useNoBob then
                local oldSpeed = characterObject._speed
                characterObject._speed = 0
                mainStep(self, stepDt)
                characterObject._speed = oldSpeed
            else
                mainStep(self, stepDt)
            end
            if l_NoCameraSway then
                self._lookDt = dt
            end
            if L.ThirdPersonEnabled then
                local cameraCF = Camera.CFrame
                local lookVector = cameraCF.LookVector
                local distance = L.ThirdPersonDistance or 7
                local params = RaycastParams.new()
                params.FilterDescendantsInstances = {workspace:FindFirstChild("Players"), workspace.CurrentCamera, workspace:FindFirstChild("Ignore")}
                params.FilterType = Enum.RaycastFilterType.Exclude
                local rayResult = workspace:Raycast(cameraCF.Position, lookVector * -distance, params)
                if rayResult and rayResult.Instance.CanCollide then
                    distance = (rayResult.Position - cameraCF.Position).Magnitude
                end
                Camera.CFrame *= CFrame.new(0, 0, distance)
            end
        end
        RunService.PreRender:Connect(function()
    if L.ThirdPerson and L.ThirdPerson.Active and L.ThirdPerson.ThirdPersonObject and L.ToggleCharacterVisuals then
        local Character = L.ThirdPerson.ThirdPersonObject._characterModel
        if Character then
            local material = L.CharacterMaterial or "ForceField"
            local texture = L.ForceFieldTextures[L.SelectedForceFieldTexture or "Honeycomb"]
            local color = L.ThirdPersonChamsColor or Color3.fromRGB(131, 146, 255)
            local vColor = Vector3.new(color.R, color.G, color.B)
            for _, Object in ipairs(Character:GetDescendants()) do
                if Object:IsA('BasePart') then
                    if material == "ForceField" then
                        Object.Material = Enum.Material.ForceField
                    else
                        pcall(function() Object.Material = Enum.Material[material] or Enum.Material.ForceField end)
                    end
                    Object.Color = color
                    if Object:IsA('MeshPart') then
                        if material == "ForceField" then
                            pcall(function() Object.TextureID = texture end)
                        else
                            pcall(function() Object.TextureID = "" end)
                        end
                    end
                elseif Object:IsA('SpecialMesh') then
                    if material == "ForceField" then
                        Object.TextureId = texture
                        Object.VertexColor = vColor
                    else
                        Object.TextureId = ""
                        Object.VertexColor = Vector3.new(1, 1, 1)
                    end
                elseif Object:IsA('Decal') or Object:IsA('Texture') then
                    Object.Transparency = 1
                end
            end
        end
    end
end)
Library:Notify('roxy loaded in ' .. string.format("%.2f", tick() - L.StartTime) .. ' seconds', 5)
    else
        warn("roxy.win / failed to hook gun mods modules {fuck} ")
    end
end)
