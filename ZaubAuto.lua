--Settings
_G.ZapHubSettings = {
    ["WhiteScreen"] = {Enable = false},
    ["AutoDisableBreakablesModels"] = {Enable = false},
    ["AutoDisablePetsRendering"] = {Enable = false},
    ["AutoDisableConfettiRendering"] = {Enable = false},
    ["AutoDisableLootboxAnimation"] = {Enable = false},
    ["AutoOptimizeGame"] = {Enable = false},
    ["AutoBuyNearestLuckyEventEgg"] = {Enable = false},
    ["AutoTeleportToBestLuckyEventEggArea"] = {Enable = false},
    ["AutoCraftHorseshoeGifts"] = {Enable = true},
    ["AutoCombineLuckyRaidBossKeys"] = {Enable = false},
    ["AutoCompeleteLuckyRaid"] = {Enable = false, TeleportToBreakable = false, MaxLevel = 50000, ChestList = {"Titanic Chest", "Huge Chest", "Loot Chest", "Leprechaun Chest", "Tier 1000 Chest"}, BossList = {"Tier 100 Boss", "Tier 1000 Boss", "Tier 5000 Boss"}, TurnBossHeroicList = {"Tier 100 Boss", "Tier 1000 Boss", "Tier 5000 Boss"}, TurnBossMythicList = {"Tier 100 Boss", "Tier 1000 Boss",  "Tier 5000 Boss"}, TeleportToEgg = false, EggDelay = 5},
    ["AutoBuyLuckyRaidUpgrades"] = {Enable = false, Upgrades = {"Lucky Raid Damage", "Lucky Raid XP", "Lucky Raid Huge Chest", "Lucky Raid Titanic Chest", "Lucky Raid Boss Huge Chances", "Lucky Raid Boss Titanic Chances"}},
    ["AutoUseLuckyRaidDamageBooster"] = {Enable = true, DamageBooster = {"Tier 1", "Tier 2"}},
    ["AutoUseLuckyRaidXPBooster"] = {Enable = true, XPBoosters = {"Tier 1", "Tier 2"}},
    ["AutoUseInstantLuckyRaidXPBoosters"] = {Enable = true, InstantXPBoosters = {"Tier 1", "Tier 2"}},
    ["AutoNewGargantuanPets"] = {Enable = true, Webhook = "https://discord.com/api/webhooks/1484795255889858591/lQqem1bmoN0Wj2aKoLIuZH3gWInctOBOlsKxJfI6hPu7CEWymuHFEv67In_DofhWm8QD"},
    ["AutoNewTitanicPets"] = {Enable = true, Webhook = "https://discord.com/api/webhooks/1484795255889858591/lQqem1bmoN0Wj2aKoLIuZH3gWInctOBOlsKxJfI6hPu7CEWymuHFEv67In_DofhWm8QD"},
    ["AutoNewHugePets"] = {Enable = true, Webhook = "https://discord.com/api/webhooks/1484795416829493401/LSAgRczDI3TlDGLvH-S_XAyzBPrFbDb028RO4MKHvD4Q-h6Cjjf_4wzupzgqmS81pzRy"},
    ["AutoNewExclusivePets"] = {Enable = true, Webhook = ""},
    ["AutoInfinitePetSpeed"] = {Enable = true},
    ["AutoTap"] = {Enable = true},
    ["AutoEfficientFarm"] = {Enable = false},
    ["AutoCollectOrbs"] = {Enable = true},
    ["AutoUseUltimate"] = {Enable = false},
    ["AutoDisableEggAnimation"] = {Enable = true},
    ["AutoClaimMailbox"] = {Enable = false},
    ["AutoClaimFreeGifts"] = {Enable = true},
    ["AutoClaimRankRewards"] = {Enable = false},
    ["AutoClaimDefaultForeverPackFreeGift"] = {Enable = true},
    ["AutoLeaveStairwayToHeaven"] = {Enable = true},
    ["AutoEatFruit"] = {Enable = true, Amount = 3, Type = "Normal", Fruits = {"Apple", "Orange", "Banana", "Pineapple", "Watermelon", "Rainbow"}},
    ["AutoUseBuffs"] = {Enable = true, Buffs = {"Toy Ball", "Squeaky Toy", "Toy Bone"}},
    ["AutoUsePotions"] = {Enable = true, Potions = {"Coins", "Lucky", "Treasure Hunter", "Walkspeed", "Diamonds", "Damage"}},
    ["AutoEquipEnchants"] = {Enable = false, Enchants = {"Strong Pets", "Tap Power", "Criticals"}},
    ["StatGUI"] = {Enable = true,
        Items = {
            {Class = "Currency", Item = "Diamonds"},{Class = "Pet", Item = "Titanic Mucki"},
            {Class = "Pet", Item = "Titanic Irish Wolfhound"},{Class = "Pet", Item = "Huge Lucki Hydra"},
            {Class = "Pet", Item = "Huge Leprechaun Fox"},{Class = "Pet", Item = "Huge Irish Badger"},
            {Class = "Pet", Item = "Huge Clover Phoenix"}, {Class = "Pet", Item = "Huge Clover Phoenix"},
        }
    }
}

--Key
script_key="gxYqjNELCtOzzeTwaibLnMiHwTJSqdyk"; -- Your premium key here	

--Script
loadstring(game:HttpGet('https://zaphub.xyz/ExecLuckyRaidEvent'))()
