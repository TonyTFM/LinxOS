#!/bin/bash
DB="$HOME/LinxOS/www/spacewars/spacewars.db"

# 1. Rohstoffe gutschreiben (Minen-Ausstoß)
sqlite3 "$DB" "
UPDATE player SET 
    metal = metal + 500, 
    crystal = crystal + 300, 
    deuterium = deuterium + 150 
WHERE id = 1;

-- Energie- / Schild-Unterhalt für Verteidigung abziehen
UPDATE player SET deuterium = deuterium - 50 WHERE id = 1;
"

# 2. Prüfen ob genug Ressourcen für automatischen Verteidigungsbau da sind (z.B. Raketenwerfer: 2000 Metal)
METAL_CURR=$(sqlite3 "$DB" "SELECT metal FROM player WHERE id = 1;")
DEF_BUILT=""

if [ "$METAL_CURR" -ge 4000 ]; then
    # Automatisch Raketenwerfer und Leichte Laser nachrüsten
    sqlite3 "$DB" "
    UPDATE player SET metal = metal - 3000, crystal = crystal - 1000 WHERE id = 1;
    UPDATE defense SET count = count + 5 WHERE name = 'rocket_launcher';
    UPDATE defense SET count = count + 2 WHERE name = 'light_laser';
    "
    DEF_BUILT="[AUTO-DEFENSE] +5 Raketenwerfer & +2 Leichte Laser automatisch installiert!"
fi

# 3. Aktuellen Stand ausgeben
echo "=== SPACEWARS AUTO-TICK & MAINTENANCE ==="
if [ ! -z "$DEF_BUILT" ]; then
    echo "$DEF_BUILT"
fi
sqlite3 -column -header "$DB" "SELECT metal AS 'Metall', crystal AS 'Kristall', deuterium AS 'Luth' FROM player WHERE id = 1;"
echo "========================================="
