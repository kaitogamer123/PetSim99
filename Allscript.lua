
-- Turn off 3D graphic?
_G.VisualConfig = { Disable3D = false }
_G.AutoTap = true
_G.AutoMagnet = true
_G.ScriptEnabled = false



loadstring(game:HttpGet('https://github.com/kaitogamer123/PetSim99/blob/main/ZaubAuto.lua'))()
loadstring(game:HttpGet('https://github.com/kaitogamer123/PetSim99/blob/main/%D0%A1%D0%BA%D1%80%D0%B8%D0%BF%D1%82%D1%8B/Autoraids'))()


getgenv().LuckyRaidSettings = {
    TargetRaidLevel = "Max",
    BossChest1 = true, BossChest2 = true, BossChest3 = true,
    OpenChests = {
        TitanicChest = true, HugeChest = true, LootChest = true, 
        LeprechaunChest = true, Tier1000Chest = true
    }
}

-- === 2. СЕРВИСЫ И ПЕРЕМЕННЫЕ ===
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local Net = ReplicatedStorage:WaitForChild("Network")
local Library = ReplicatedStorage:WaitForChild("Library")

-- Загрузка сигналов и модулей рейда
local Signal = require(Library:WaitForChild("Signal"))
local RaidCmds = require(Library.Client.RaidCmds)
local RaidInstance = require(Library.Client.RaidCmds.ClientRaidInstance)
local NetworkMod = require(Library.Client.Network)

local things = workspace:WaitForChild("__THINGS")
local breakables = things:WaitForChild("Breakables")
local Active = things:WaitForChild("__INSTANCE_CONTAINER"):WaitForChild("Active")
local hrp = (player.Character or player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")

local lastBossRoom = 0
local boss2Purchased = false 
local lastLeave = 0
local isCurrentlySafe = nil -- Состояние безопасности

-- === 3. ФУНКЦИИ КОНТРОЛЯ СОСТОЯНИЯ ===

local function switchToLegit()
    if isCurrentlySafe == false then return end
    isCurrentlySafe = false
    _G.ScriptEnabled = false -- СТОП твой фарм
    
    task.wait(0.1)
    pcall(function() Signal.Fire("Migration_InitAutoRaid") end)
    warn("!!! [ALARM]: Игрок зашел. Включен легитный авторейд.")
end

local function switchToCustom()
    if isCurrentlySafe == true then return end
    isCurrentlySafe = true
    
    -- Сначала вырубаем легитный рейд игры
    pcall(function() Signal.Fire("Instance Home Clicked") end)
    task.wait(1.5) -- Пауза, чтобы окна закрылись
    
    _G.ScriptEnabled = true -- ПУСК твой фарм
    print(">>> [SAFE]: Вы один. Включен кастомный фарм.")
end

-- === 4. ГЛАВНЫЙ КОНТРОЛЛЕР (40 СЕК + ПРОВЕРКА) ===
task.spawn(function()
    print(">>> Инициализация системы защиты (40 сек)...")
    task.wait(10)
    
    while true do
        local playerCount = #Players:GetPlayers()
        
        if playerCount > 1 then
            switchToLegit() -- Если не один -> Легит
        else
            switchToCustom() -- Если один -> Кастом
        end
        
        task.wait(1.5) -- Частота проверки сервера
    end
end)

-- === 5. ЛОГИКА ТВОЕГО АВТОФАРМА (РАБОТАЕТ ПРИ _G.ScriptEnabled) ===

local function getBreakable()
    for _, v in pairs(breakables:GetChildren()) do
        local id = v:GetAttribute("BreakableID")
        if id and string.find(tostring(id), "LuckyRaid") then return v end
    end
    return nil
end

local function forceBuy(bossId, roomNum)
    if not _G.ScriptEnabled then return end
    pcall(function()
        Net.LuckyRaid_PullLever:InvokeServer(bossId)
        task.wait(0.1)
        Net.Raids_StartBoss:InvokeServer(bossId)
    end)
    if bossId == 2 then boss2Purchased = true end
end

-- Цикл ТП к объектам
task.spawn(function()
    while task.wait(0.1) do
        if _G.ScriptEnabled then
            local target = getBreakable()
            if target and target.Parent then
                hrp.CFrame = target:GetPivot() * CFrame.new(0, 4, 0)
            end
        end
    end
end)

-- Главный цикл Рейда
task.spawn(function()
    while task.wait(0.5) do
        if not _G.ScriptEnabled then continue end
        
        local raid = RaidInstance.GetCurrent()
        if not raid then
            lastBossRoom = 0
            boss2Purchased = false
            if tick() - lastLeave > 3 then
                local myRaid = RaidInstance.GetByOwner(player)
                if myRaid and not myRaid:IsComplete() then
                    NetworkMod.Invoke("Raids_Join", myRaid:GetId())
                else
                    local portal
                    for i = 1, 10 do if not RaidInstance.GetByPortal(i) then portal = i break end end
                    if portal then
                        local lvl = (getgenv().LuckyRaidSettings.TargetRaidLevel == "Max") and RaidCmds.GetLevel() or 1
                        RaidCmds.Create({Difficulty = lvl, Portal = portal, PartyMode = 1})
                    end
                end
                lastLeave = tick()
            end
        else
            local room = raid:GetRoomNumber()
            local raidFolder = Active:FindFirstChild("LuckyRaid")

            -- Сбор сундуков
            if raidFolder and raidFolder:FindFirstChild("INTERACT") then
                for _, obj in ipairs(raidFolder.INTERACT:GetChildren()) do
                    if getgenv().LuckyRaidSettings.OpenChests[obj.Name] then
                        pcall(function() Net.Raids_OpenChest:InvokeServer(obj.Name) end)
                    end
                end
            end

            -- Рычаги боссов
            if lastBossRoom ~= room then
                if room == 3 then forceBuy(1, 3) lastBossRoom = room
                elseif room == 6 then forceBuy(2, 6) lastBossRoom = room
                end
            end

            -- Проверка финала
            if not getBreakable() then
                if boss2Purchased and lastBossRoom < 9 then
                    task.wait(3)
                    if not getBreakable() and _G.ScriptEnabled then
                        local finalPath = things.__INSTANCE_CONTAINER.Active:FindFirstChild("LuckyRaid")
                        if finalPath and finalPath:FindFirstChild("FinalArea") then
                            hrp.CFrame = finalPath.FinalArea:GetPivot()
                            task.wait(0.5)
                            for i = 1, 3 do
                                pcall(function()
                                    Net.LuckyRaid_PullLever:InvokeServer(3)
                                    task.wait(0.2)
                                    Net.Raids_StartBoss:InvokeServer(3)
                                end)
                            end
                            lastBossRoom = 9 
                        end
                    end
                end

                -- Ресет рейда
                if room >= 10 then
                    task.wait(5)
                    if not getBreakable() and _G.ScriptEnabled then
                        lastLeave = tick()
                        pcall(function()
                            Net.Instancing_PlayerLeaveInstance:FireServer("LuckyRaid")
                            task.wait(0.5)
                            Net.Instancing_PlayerEnterInstance:InvokeServer("LuckyEventWorld")
                        end)
                    end
                end
            end
        end
    end
end)

-- === 6. МАГНИТ И КЛИКИ (ДОПЫ) ===
task.spawn(function()
    while task.wait(0.3) do
        if _G.ScriptEnabled and _G.AutoMagnet then
            local orbs = things:FindFirstChild("Orbs")
            if orbs then
                for _, orb in pairs(orbs:GetChildren()) do
                    if not _G.ScriptEnabled then break end
                    pcall(function() Net:FindFirstChild("Orbs: Collect"):FireServer({[1] = tonumber(orb.Name)}) end)
                    orb:Destroy()
                end
            end
        end
    end
end)

