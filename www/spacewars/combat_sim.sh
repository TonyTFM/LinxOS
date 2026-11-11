#!/bin/bash
DB="$HOME/LinxOS/www/spacewars/spacewars.db"

echo "=================================================="
echo " 🌌 SPACEWARS: KAMPFSIMULATION & SEKTOR-SCHLACHT"
echo "=================================================="

# Eigene Flotte & Verteidigung aus DB holen
FIGHTERS=$(sqlite3 "$DB" "SELECT count FROM ships WHERE name='light_fighter';")
CARGOS=$(sqlite3 "$DB" "SELECT count FROM ships WHERE name='small_cargo';")
CRUISERS=$(sqlite3 "$DB" "SELECT count FROM ships WHERE name='cruiser';")
BATTLESHIPS=$(sqlite3 "$DB" "SELECT count FROM ships WHERE name='battleship';")

RAPPINGS=$(sqlite3 "$DB" "SELECT count FROM defense WHERE name='rocket_launcher';")
LASERS=$(sqlite3 "$DB" "SELECT count FROM defense WHERE name='light_laser';")
GAUSS=$(sqlite3 "$DB" "SELECT count FROM defense WHERE name='gauss_cannon';")
PLASMAS=$(sqlite3 "$DB" "SELECT count FROM defense WHERE name='plasma_turret';")

echo "[DEINE STREITKRÄFTE IN 20:7:5:50]"
echo " - Leichte Jäger: $FIGHTERS"
echo " - Kleine Transporter: $CARGOS"
echo " - Kreuzer (Cougers): $CRUISERS"
echo " - Schlachtschiffe: $BATTLESHIPS"
echo " - Raketenwerfer: $RAPPINGS | Laser: $LASERS | Gauss: $GAUSS | Plasma: $PLASMAS"
echo "--------------------------------------------------"

echo "[FEINDLICHER KLAN TRITT AN]"
echo " Ein abtrünniger Couger-Verband (gleicher Stärke) nähert sich dem Sektor!"
echo "--------------------------------------------------"

# Einfache Kampfwert-Berechnung (Schiffsanzahl * Feuerkraftfaktor)
# Jäger: 10, Transporter: 5, Kreuzer: 50, Schlachtschiff: 150
# Verteidigung: Rakete=20, Laser=25, Gauss=100, Plasma=500

MY_POWER=$(( (FIGHTERS * 10) + (CARGOS * 5) + (CRUISERS * 50) + (BATTLESHIPS * 150) + (RAPPINGS * 20) + (LASERS * 25) + (GAUSS * 100) + (PLASMAS * 500) ))
ENEMY_POWER=$(( (CRUISERS * 60) + (BATTLESHIPS * 160) + 1200 )) # Angreifer hat etwas mehr Wumms

echo "Deine Kampf-ID / Feuerkraft-Score:   $MY_POWER"
echo "Feindliche Angriffs-Kampfkraft:       $ENEMY_POWER"
echo "--------------------------------------------------"

if [ "$MY_POWER" -ge "$ENEMY_POWER" ]; then
    echo "🎉 SIEG FÜR SEKTOR 20:7:5:50!"
    echo " Die Plasmatorürme und Cougers haben den Feind in der Umlaufbahn zerrissen!"
    echo " Keine eigenen Verluste dank massiver Luth-Schildgeneratoren."
else
    echo "⚠️ SCHwere SCHLACHT! Der feindliche Verband war zu stark."
    echo " Deine Verteidigung hat gehalten, aber ein paar Einheiten wurden beschädigt."
    # Kleiner Abzug bei Jägern als Simulation
    sqlite3 "$DB" "UPDATE ships SET count = CASE WHEN count > 2 THEN count - 2 ELSE 0 END WHERE name='light_fighter';"
    echo " -> 2 Leichte Jäger mussten in der Werft repariert werden."
fi
echo "=================================================="
