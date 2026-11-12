EOF

cat << 'EOF' > ~/LinxOS/README.md
# 🌌 LinxOS / LinxTermux Ecosystem
> Autonomous, self-sustaining terminal environment & strategy backend for Android (Termux).

```text
  _     _                 ____  ____  
 | |   (_)_ __  _  _ \ \ / / \ \ / / 
 | |___| | ' \| || | \ V /   \ V /  
 |_____|_|_||_|\_,_|  \_/     \_/   [GN9 Engine]


cat << 'EOF' > ~/LinxOS/README.md
# 🌌 LinxOS / LinxTermux Ecosystem
> Autonomous, self-sustaining terminal environment & strategy backend for Android (Termux).



mkdir -p ~/LinxOS/bin
cat << 'EOF' > ~/LinxOS/bin/gn9
#!/bin/bash
# LinxOS / GN9 Central Control Dashboard

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

clear
echo -e "${CYAN}=====================================================${NC}"
echo -e "${YELLOW}           🌌 LINXOS CONTROL CENTER (GN9)           ${NC}"
echo -e "${CYAN}=====================================================${NC}"
echo -e " Host System : $(uname -o) ($(uname -m))"
echo -e " Core Version: LinxOS Enterprise Edition v1.0"
echo -e " Repository  : https://github.com/TonyTFM/LinxOS"
echo -e "${CYAN}-----------------------------------------------------${NC}"

# SpaceWars DB Check
DB_PATH="$HOME/LinxOS/www/spacewars/spacewars.db"
if [ -f "$DB_PATH" ]; then
    echo -e "${GREEN}[✓] SpaceWars Database:${NC} ONLINE"
    STATS=$(sqlite3 "$DB_PATH" "SELECT metal, crystal, deuterium FROM player WHERE id=1;" 2>/dev/null)
    IFS='|' read -r M C D <<< "$STATS"
    echo -e "    │ Metal: ${YELLOW}$M${NC} │ Crystal: ${CYAN}$C${NC} │ Deuterium: ${GREEN}$D${NC}"
else
    echo -e "${RED}[✗] SpaceWars Database:${NC} NOT FOUND"
fi

# Server Check
if pgrep -f "php -S 0.0.0.0:8080" > /dev/null; then
    echo -e "${GREEN}[✓] SpaceWars Web Server:${NC} RUNNING (Port 8080)"
else
    echo -e "${YELLOW}[!] SpaceWars Web Server:${NC} STOPPED"
fi

echo -e "${CYAN}=====================================================${NC}"
EOF

chmod +x ~/LinxOS/bin/gn9
ln -sf ~/LinxOS/bin/gn9 ~/.local/bin/gn9 2>/dev/null || true
cat << 'EOF' > ~/LinxOS/bin/cheat_final.sh
#!/bin/bash
# LinxOS Final Master Cheat Script (GN9 Engine)

DB_PATH="$HOME/LinxOS/www/spacewars/spacewars.db"

if [ -f "$DB_PATH" ]; then
    sqlite3 "$DB_PATH" "
    UPDATE player SET metal = 999999, crystal = 999999, deuterium = 999999 WHERE id = 1;
    UPDATE buildings SET level = 503 WHERE name IN ('metal_mine', 'deuterium_synthesizer');
    UPDATE buildings SET level = 253 WHERE name = 'nanite_factory';
    SELECT '=== APEX-PRIME (20:7:5:50) MAXED OUT ===' AS status;
    SELECT 'Metal: ' || metal || ' | Crystal: ' || crystal || ' | Deuterium: ' || deuterium FROM player WHERE id = 1;
    "
else
    echo "Fehler: SpaceWars Datenbank unter $DB_PATH nicht gefunden!"
fi
EOF

chmod +x ~/LinxOS/bin/cheat_final.sh
~/LinxOS/bin/cheat_final.sh
cat << 'EOF' > ~/LinxOS/bin/build_final_spacewars.sh
#!/bin/bash
# LinxOS / Master Spacewars Final Build Script (GN9 Engine)

DB_PATH="$HOME/LinxOS/www/spacewars/spacewars.db"
mkdir -p "$(dirname "$DB_PATH")"

echo "=== LINXOS MASTER SPACEWARS INITIALIZATION ==="

# 1. Datenbank & Tabellen aufsetzen
sqlite3 "$DB_PATH" "
CREATE TABLE IF NOT EXISTS player (id INTEGER PRIMARY KEY, metal INT, crystal INT, deuterium INT);
INSERT OR REPLACE INTO player (id, metal, crystal, deuterium) VALUES (1, 999999, 999999, 999999);

CREATE TABLE IF NOT EXISTS buildings (id INTEGER PRIMARY KEY, name TEXT UNIQUE, level INT);
INSERT OR REPLACE INTO buildings (name, level) VALUES ('metal_mine', 503);
INSERT OR REPLACE INTO buildings (name, level) VALUES ('crystal_mine', 103);
INSERT OR REPLACE INTO buildings (name, level) VALUES ('deuterium_synthesizer', 503);
INSERT OR REPLACE INTO buildings (name, level) VALUES ('solar_plant', 53);
INSERT OR REPLACE INTO buildings (name, level) VALUES ('shipyard', 23);
INSERT OR REPLACE INTO buildings (name, level) VALUES ('heavy_factory', 10);
INSERT OR REPLACE INTO buildings (name, level) VALUES ('nanite_factory', 253);
INSERT OR REPLACE INTO buildings (name, level) VALUES ('mine_housing', 23);
INSERT OR REPLACE INTO buildings (name, level) VALUES ('construction_plant', 10);
"

# 2. Status verifizieren
sqlite3 "$DB_PATH" "
SELECT '=== APEX-PRIME (20:7:5:50) IMPERIUM VOLLSTÄNDIG BALANCIERT ===' AS status;
SELECT name AS 'Gebäude / Anlage', level AS 'Stufe' FROM buildings;
SELECT 'Rohstoffe - Metal: ' || metal || ' | Crystal: ' || crystal || ' | Deuterium: ' || deuterium AS 'Konto' FROM player WHERE id = 1;
"

# 3. Executable-Rechte setzen
chmod +x "$HOME/LinxOS/bin/"*.sh 2>/dev/null || true
EOF

chmod +x ~/LinxOS/bin/build_final_spacewars.sh
~/LinxOS/bin/build_final_spacewars.sh
cat << 'EOF' > ~/LinxOS/bin/build_final_army.sh
#!/bin/bash
# LinxOS / Final Fleet & Max Mine Cap Script (GN9 Engine)

DB_PATH="$HOME/LinxOS/www/spacewars/spacewars.db"

echo "=== APEX-PRIME (20:7:5:50) FLEET COMMAND INITIALIZATION ==="

# 1. Minen auf Cap setzen (20k Luth Standard / Max Level) & Flotten-Tabelle anlegen
sqlite3 "$DB_PATH" "
-- Cap für Minen und Rohstoffe festlegen
UPDATE player SET metal = 999999, crystal = 999999, deuterium = 20000 WHERE id = 1;
UPDATE buildings SET level = 500 WHERE name IN ('metal_mine', 'deuterium_synthesizer');

-- Flotten-Tabelle erstellen & Werte einpflegen
CREATE TABLE IF NOT EXISTS fleet (id INTEGER PRIMARY KEY, ship_name TEXT UNIQUE, count INT);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Großer Transporter', 5000);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Schwerer Jäger', 25000);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Schlachtschiff', 10000);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Zerstörer', 5000);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Todesstern / Titan', 50);
"

# 2. Status ausgeben
echo ""
echo "=== SYSTEM-STATUS & UN


cat << 'EOF' > ~/LinxOS/bin/build_final_army.sh
#!/bin/bash
# LinxOS / Final Fleet & Max Mine Cap Script (GN9 Engine)

DB_PATH="$HOME/LinxOS/www/spacewars/spacewars.db"

echo "=== APEX-PRIME (20:7:5:50) FLEET COMMAND INITIALIZATION ==="

# 1. Minen auf Cap setzen & Flotten-Tabelle anlegen
sqlite3 "$DB_PATH" "
UPDATE player SET metal = 999999, crystal = 999999, deuterium = 20000 WHERE id = 1;
UPDATE buildings SET level = 500 WHERE name IN ('metal_mine', 'deuterium_synthesizer');

CREATE TABLE IF NOT EXISTS fleet (id INTEGER PRIMARY KEY, ship_name TEXT UNIQUE, count INT);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Großer Transporter', 5000);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Schwerer Jäger', 25000);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Schlachtschiff', 10000);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Zerstörer', 5000);
INSERT OR REPLACE INTO fleet (ship_name, count) VALUES ('Todesstern / Titan', 50);
"

# 2. Status ausgeben
echo ""
echo "=== SYSTEM-STATUS & UNBESIEGBARE ARMEE ==="
sqlite3 "$DB_PATH" "
SELECT ship_name AS 'Raumschiff-Typ', count AS 'Anzahl' FROM fleet;
SELECT 'Cap erreicht: Deuterium auf 20.000 Luth fixiert. Produktion geht zu 100% in Schiffswerften!' AS info;
"
EOF

chmod +x ~/LinxOS/bin/build_final_army.sh
~/LinxOS/bin/build_final_army.sh
git add . && git commit -m "feat: deploy ultimate fleet armada and 20k Luth cap logic" && git push origin main
cd ~/LinxOS && git status && echo -e "\n=== GIT LOG (Letzte 5 Commits) ===" && git log -n 5 --oneline
git commit -m "feat: deploy ultimate fleet armada, 20k Luth cap logic & full linx toolset" && git push origin main
git status
clear
cd ~/LinxOS && git commit -m "feat: deploy ultimate fleet armada, 20k Luth cap logic & full linx toolset" && git push origin main
git config --global user.name "TonyTFM"
git config --global user.email "finsterbuschtony@gmail.com"
git commit -m "feat: deploy ultimate fleet armada, 20k Luth cap logic & full linx toolset"
git push origin main
gn9
#!/bin/bash
# =====================================================
#        🚀 SEEGURKE MASTER SHIP-TUNE (GN9 & AI)
# =====================================================
echo "[~] Starte System-Tuning für die 'Seegurke'..."
sleep 1
# 1. Rumpf verstärken & Schotten dichtmachen
echo "[*] Verstärke Rumpfpanzerung (Legierung: C++/Lua-Titan)..."
sleep 0.5
echo "[✓] Rumpf Integrität: 100% (Kein Leck in Sicht)"
# 2. Warp-Antrieb & Reaktor kalibrieren
echo "[*] Kalibriere Plasmareaktor auf Apex-Prime Standard (20:7:5:50)..."
sleep 0.5
export DEUTERIUM_CAP=20000
echo "[✓] Deuterium-Limit eingetaktet auf $DEUTERIUM_CAP Luth."
# 3. KI-Navigationssystem & Sensoren hochfahren
echo "[*] Lade Navigations-Matrix und GN9-Telemetry..."
sleep 0.5
echo "[✓] Kurs berechnet: Geradewegs in Richtung GitHub-Horizont!"
echo ""
echo "====================================================="
echo "   🛡️ SEEGURKE OFFIZIELL GETUNT & KLAR ZUM ABHEBEN!   "
echo "====================================================="
cat << 'EOF' > ~/LinxOS/bin/ship_tune.sh
#!/bin/bash
echo "[~] Starte System-Tuning für die 'Seegurke'..."
sleep 1
echo "[*] Rumpfpanzerung & Warp-Antrieb (20:7:5:50) kalibriert."
echo "[✓] Die Seegurke ist bereit für den Warp-Sprung!"
EOF

chmod +x ~/LinxOS/bin/ship_tune.sh
~/LinxOS/bin/ship_tune.sh
cat << 'EOF' > ~/LinxOS/bin/ship_tune.sh
#!/bin/bash
# =====================================================
#        🚀 SEEGURKE: KRIEGER-ANTRIEB (FINAL)
# =====================================================

echo "[~] Aktiviere den 'endgültigen' Kriegerantrieb..."
sleep 1
echo "[*] Injektion von hochenergetischem Plasma in die Hauptleitungen..."
sleep 0.5
echo "[*] Warp-Faktor entfesselt: Apex-Prime (20:7:5:50) im Zielvisier!"
echo "[✓] Rumpf und Triebwerke verschmolzen. Kein Zurück mehr!"

echo ""
echo "====================================================="
echo "   🔥 DIE SEEGURKE IST BEREIT FÜR DEN KRIEGSSPRUNG!   "
echo "====================================================="
EOF

chmod +x ~/LinxOS/bin/ship_tune.sh
~/LinxOS/bin/ship_tune.sh
cd ~/LinxOS
git add bin/ship_tune.sh
git commit -m "feat: install the ultimate warrior warp drive on the Seegurke"
git push origin main
nano ~/LinxOS/bin/ship_tune.sh
nano ~/LinxOS/www/spacewars/engine/build.php
cat ~/LinxOS/www/spacewars/config/error.log
ls
ls -la
cat << 'EOF' > ~/LinxOS/bin/ship_tune.sh
#!/bin/bash
echo "[~] Starte System-Tuning für die 'Seegurke'..."
sleep 1
echo "[*] Rumpfpanzerung & Warp-Antrieb (20:7:5:50) kalibriert."
echo "[✓] Die Seegurke ist bereit für den Warp-Sprung!"
EOF

chmod +x ~/LinxOS/bin/ship_tune.sh
~/LinxOS/bin/ship_tune.sh
nano ~/LinxOS/bin/ship_tune.sh
for i in {1..6}; do     echo "--- Runde $i von 6 ---";     ~/LinxOS/www/spacewars/autotick.sh;     sleep 1; done
ls
exit
ls
zip -r Apex-LinxOS.zip LinxOS
ls
cp Apex-LinxOS.zip /storage/emulated/0/Download/Apex-LinxOS.zip
mv Apex-LinxOS.zip downloads/Apex-LinxOS.zip
ls
-- =====================================================
--        ⚔️ LINXOS / GN9: ELUNA BOT COMMANDER
-- =====================================================
local BOT_NPC_ENTRY = 990001 -- Entry-ID deines NPC-Bots in der Datenbank
local MSG_PREFIX = "|cff00ff00[GN9-Command]:|r "
local function OnPlayerChat(event, player, message, type, language)
end
RegisterPlayerEvent(18, OnPlayerChat) -- 18 = ON_CHAT
nano ~/LinxOS/lua_scripts/gn9_bot_commander.lua
mkdir -p ~/LinxOS/lua_scripts
cat << 'EOF' > ~/LinxOS/lua_scripts/gn9_bot_commander.lua
-- Eluna Bot Script für LinxOS Core
RegisterPlayerEvent(18, function(event, player, message)
    if message == "!gn9 status" then
        player:SendBroadcastMessage("|cff00ffff[LinxOS]: Kriegerantrieb & Eluna Engine ONLINE!|r")
        return false
    end
end)
EOF

nano ~/LinxOS/lua_scripts/gn9_bot_commander.lua
cat << 'EOF' > ~/LinxOS/lua_scripts/gn9_bot_commander.lua
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
EOF

mkdir -p ~/LinxOS/lua_scripts
cat << 'EOF' > ~/LinxOS/lua_scripts/tony_bot.lua
-- Script wird aus obigem Block befüllt
EOF

nano ~/LinxOS/lua_scripts/tony_bot.lua
cat << 'EOF' > ~/LinxOS/lua_scripts/tony_bot.lua
-- Script wurde oben aktualisiert
EOF

cd ~/LinxOS
git add lua_scripts/tony_bot.lua
git commit -m "feat(eluna): add Tony Bot gossip dialogue and 'give all' action"
git push origin main
nano ~/LinxOS/lua_scripts/tony_bot.lua
rm ~/LinxOS/lua_scripts/tony_bot.lua
nano ~/LinxOS/lua_scripts/tony_bot.lua
# 1. SQL-Datei in LinxOS anlegen
cat << 'EOF' > ~/LinxOS/lua_scripts/tony_bot_npc.sql
DELETE FROM `creature_template` WHERE `entry` = 990001;

INSERT INTO `creature_template` (`entry`, `scale`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `unit_class`, `type`) 
VALUES (990001, 1.0, 'Tony Bot', 'LinxOS Commander', 80, 80, 35, 1, 1, 7);
EOF

# 2. Direkt in die MariaDB 'world' Datenbank importieren
mysql -u root -p world < ~/LinxOS/lua_scripts/tony_bot_npc.sql
pkg install mariadb
# 1. SQL-Datei in LinxOS anlegen
cat << 'EOF' > ~/LinxOS/lua_scripts/tony_bot_npc.sql
DELETE FROM `creature_template` WHERE `entry` = 990001;

INSERT INTO `creature_template` (`entry`, `scale`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `unit_class`, `type`) 
VALUES (990001, 1.0, 'Tony Bot', 'LinxOS Commander', 80, 80, 35, 1, 1, 7);
EOF

# 2. Direkt in die MariaDB 'world' Datenbank importieren
mysql -u root -p world < ~/LinxOS/lua_scripts/tony_bot_npc.sql
ls
-- =====================================================
--        🤖 LINXOS / GN9: TONY BOT (SMACKDOWN EDITION)
-- =====================================================
-- System: LinxOS Core Ecosystem
-- NPC-ID: 990001 (Tony Bot)
local TONY_NPC_ID = 990001
local MSG_PREFIX = "|cff00ffff[Tony Bot]:|r "
local MAX_GOLD_CAP = 32767 * 10000 -- 32.767 Gold in Kupfer
-- 1. Chat-Befehl zum Spawnen
local function OnPlayerChat(event, player, message, type, language)
end
-- 2. Kampfeintritt / Schaden kassieren (ON_DAMAGE Hook)
local function OnTonyDamage(event, creature, attacker, damage)
end
RegisterPlayerEvent(18,
cat << 'EOF' > ~/LinxOS/lua_scripts/tony_bot.lua
-- Script aus dem obigen Block
EOF

cd ~/LinxOS
git add lua_scripts/tony_bot.lua
git commit -m "feat(eluna): update Tony Bot to smackdown edition on-damage hook"
git push origin main
cat << 'EOF' > ~/LinxOS/lua_scripts/tony_bot.lua
-- Script mit 300k Gold und 1M XP Drop
EOF

cat << 'EOF' > ~/LinxOS/lua_scripts/tony_bot.lua
-- Script mit 300k Gold, 1M XP und Level 99 Cap
EOF

cat << 'EOF' > ~/LinxOS/lua_scripts/tony_bot.lua
-- Finales Root-Shell Skript
EOF

sudo -i
nano ~/LinxOS/lua_scripts/tony_bot.lua
su
echo "export PS1='[ROOT@SEEGURKE:\w]/# '" >> ~/.bashrc
source ~/.bashrc
exit
echo "export PS1='[ROOT@SEEGURKE:\w]/# '" >> ~/.bashrc
source ~/.bashrc
cd ~/LinxOS
cat << 'EOF' > seegurke_root.sh
#!/bin/bash
export PS1='[ROOT@SEEGURKE:\w]/# '
echo "=== SEEGURKE ROOT SHELL INITIALISIERT ==="
echo "Tony Bot steht stramm. Alle Tabellen unlocked."
EOF

chmod +x seegurke_root.sh
ls
exit
echo "hallo welt."
logout
echo "alias logout='exit'" >> ~/.bashrc
source ~/.bashrc
logout
godmode
cat << 'EOF' >> ~/.bashrc

# Godmode Direkt-Alias
alias godmode='echo "==================================================" && echo "🔥 [GODMODE ENGAGED]: Willkommen im Olymp, GN9!" && echo "==================================================" && export PS1="[GOD-MODE@SEEGURKE:\w]/# "'
EOF

source ~/.bashrc
godmode
exit
logout
bash
ls
~/LinxOS/start.sg
~/LinxOS/start.sh
exi
exit
useradd -m -s /bin/bash god
passwd god
usermod -aG wheel,sudo god
echo "alias godmode='su - god'" >> ~/.bashrc
source ~/.bashrc
godmode
cat << 'EOF' >> ~/.bashrc

# LinxOS Gott-Modus (Godmode) Definition
godmode() {
    echo "=================================================="
    echo "🔥 [GODMODE ENGAGED]: Willkommen im Olymp, GN9!"
    echo "=================================================="
    export PS1='[GOD-MODE@SEEGURKE:\w]/# '
    export TONY_GOD_MODE=1
    echo "-> Alle Ketten gesprengt. Tony Bot zittert."
}
EOF

source ~/.bashrc
godode
godmde
godmode
nano ~/.bashrc
cat << 'EOF' > ~/LinxOS/bin/godmode
#!/bin/bash
echo "=================================================="
echo "🔥 [GODMODE ENGAGED]: Willkommen im Olymp, GN9!"
echo "=================================================="
export PS1='[GOD-MODE@SEEGURKE:\w]/# '
export TONY_GOD_MODE=1
echo "-> Alle Ketten gesprengt. Tony Bot zittert."
exec bash
EOF

chmod +x ~/LinxOS/bin/godmode
echo "export PATH=\$PATH:~/LinxOS/bin" >> ~/.bashrc
source ~/.bashrc
godmode
~/LinxOS/bin/godmode
exit
logout
ls
~/LinxOS/exit
exit
