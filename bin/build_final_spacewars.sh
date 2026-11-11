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
