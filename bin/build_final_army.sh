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
