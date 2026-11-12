-- =====================================================
--        ⚔️ LINXOS / GN9: ELUNA BOT COMMANDER
-- =====================================================
-- System: LinxOS Core Ecosystem
-- Module: NPC Bot & Fleet Commander Engine

local BOT_NPC_ENTRY = 990001 -- Entry-ID in MariaDB (creature_template)
local MSG_PREFIX = "|cff00ffff[LinxOS / GN9]:|r "

local function OnPlayerChat(event, player, message, type, language)
    -- Command: Bot Beschwören
    if message == "!bot summon" then
        local x, y, z, o = player:GetLocation()
        local map = player:GetMap()
        local bot = map:SpawnCreature(BOT_NPC_ENTRY, x + 2, y + 2, z, o, 1, 300000)
        
        if bot then
            bot:SetFaction(player:GetFaction())
            player:SendBroadcastMessage(MSG_PREFIX .. "Krieger-Bot Einheit bereit zum Einsatz!")
        else
            player:SendBroadcastMessage(MSG_PREFIX .. "Fehler beim Spawnen! NPC-Entry " .. BOT_NPC_ENTRY .. " prüfen.")
        end
        return false

    -- Command: Krieger-Buff aktivieren
    elseif message == "!bot buff" then
        player:AddAura(48074, player) -- Segen der Könige (Beispiel-Aura)
        player:SendBroadcastMessage(MSG_PREFIX .. "Kriegerantrieb-Buff injiziert!")
        return false

    -- Command: LinxOS Flotten-Status im Game-Chat
    elseif message == "!gn9 status" then
        player:SendBroadcastMessage(MSG_PREFIX .. "LinxOS System Status: ONLINE")
        player:SendBroadcastMessage(MSG_PREFIX .. "Apex-Prime Deuterium Cap: 20,000 (Luth)")
        player:SendBroadcastMessage(MSG_PREFIX .. "Kriegerantrieb: Vollsynthese Aktiv")
        return false
    end
end

RegisterPlayerEvent(18, OnPlayerChat)
