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
