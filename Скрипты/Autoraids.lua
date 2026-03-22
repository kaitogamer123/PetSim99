local baseUrl = "https://github.com/kaitogamer123/PetSim99/tree/main/%D0%A1%D0%BA%D1%80%D0%B8%D0%BF%D1%82%D1%8B"

local nested = {
    {"Antilag", "AntiLag.lua"},
    {"Antilag", "Disable3d.lua"},
    {"DeleteGuis", "DeleteGuis.lua"},
    {"FpsBoost2", "FpsBoost2.lua"}
}

local rootScripts = {
    "autotap.lua",
    "automagnet.lua", 
    "autogifts.lua", 
    "auto%20titanic.lua", 
    "Raidfarm.lua", 
    "megaspeedpets.lua"
}

for _, data in ipairs(nested) do
    task.spawn(function()
        local folder = data[1]
        local file = data[2]
        local fullPath = baseUrl .. folder .. "/" .. file
        pcall(function() loadstring(game:HttpGet(fullPath))() end)
    end)
    task.wait(0.2)
end

for _, scriptName in ipairs(rootScripts) do
    task.spawn(function()
        local fullPath = baseUrl .. scriptName
        pcall(function() loadstring(game:HttpGet(fullPath))() end)
    end)
    task.wait(0.2)
end

task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet(baseUrl .. "WebhooksPets/webhookPets.lua"))()
    end)
end)

print("--- [Hub]: Все системы запущены! ---")
