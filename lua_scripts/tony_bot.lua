-- =====================================================
--        🤖 LINXOS / GN9: TONY BOT (ROOT SHELL OVERRIDE)
-- =====================================================
-- System: LinxOS Core Ecosystem[span_4](start_span)[span_4](end_span)[span_5](start_span)[span_5](end_span)
-- Status: [ROOT@SEEGURKE:/#] - ALL TABLES UNLOCKED[span_6](start_span)[span_6](end_span)

local TONY_NPC_ID = 990001
local MSG_PREFIX = "|cff00ffff[Root-Shell / Tony Bot]:|r "
local ROOT_GOLD = 300000 * 10000 -- 300.000 Gold in Kupfer[span_7](start_span)[span_7](end_span)[span_8](start_span)[span_8](end_span)
local MILLION_XP = 1000000 -- 1.000.000 XP[span_9](start_span)[span_9](end_span)[span_10](start_span)[span_10](end_span)
local ROOT_LEVEL = 99 -- Das wahre LinxOS-Cap[span_11](start_span)[span_11](end_span)[span_12](start_span)[span_12](end_span)

local function OnPlayerChat(event, player, message, type, language)
    if message == "!tony root" or message == "!tony summon" then
        local x, y, z, o = player:GetLocation()
        local map = player:GetMap()
        local bot = map:SpawnCreature(TONY_NPC_ID, x + 2, y + 2, z, o, 1, 600000)
        
        if bot then
            bot:SetFaction(player:GetFaction())
            player:SendBroadcastMessage(MSG_PREFIX .. "[ROOT ACCESS GRANTED] Tony Bot steht stramm und liefert ab!")[span_13](start_span)[span_13](end_span)
        end
        return false
    end
end

local function OnTonyDamage(event, creature, attacker, damage)
    if attacker and attacker:IsPlayer() then
        local player = attacker:ToPlayer()
        
        creature:AttackStop()
        creature:SetFaction(player:GetFaction())
        creature:SetHealth(creature:GetMaxHealth())
        
        -- Die absolute Unterwerfung dank Root-Shell
        creature:SendUnitSay("Hier, nimm die 20 Euro, den Tritt in den Arsch und alles andere! Wir sind in einer Root Shell, ich habe keine Wahl!", 0)[span_14](start_span)[span_14](end_span)[span_15](start_span)[span_15](end_span)
        
        -- Root-Overkill-Werte einspielen[span_16](start_span)[span_16](end_span)[span_17](start_span)[span_17](end_span)
        player:SetCoinage(ROOT_GOLD)[span_18](start_span)[span_18](end_span)[span_19](start_span)[span_19](end_span)
        player:GiveXP(MILLION_XP)[span_20](start_span)[span_20](end_span)[span_21](start_span)[span_21](end_span)
        if player:GetLevel() < ROOT_LEVEL then
            player:SetLevel(ROOT_LEVEL)[span_22](start_span)[span_22](end_span)[span_23](start_span)[span_23](end_span)
        end
        
        player:AddAura(48074, player)
        player:AddAura(48161, player)
        player:SetHealth(player:GetMaxHealth())
        player:SetPower(player:GetMaxPower(), 0)
        
        player:SendBroadcastMessage(MSG_PREFIX .. "🔥 [SYSTEM OVERRIDE]: 300k Gold, 1M XP & Level 99 erzwungen!")[span_24](start_span)[span_24](end_span)[span_25](start_span)[span_25](end_span)
        return true
    end
end

RegisterPlayerEvent(18, OnPlayerChat)
RegisterCreatureEvent(TONY_NPC_ID, 9, OnTonyDamage)
