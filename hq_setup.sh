#!/bin/bash
echo "=================================================="
echo "  LinxOS v1.0 Final: Die Krieger von Es "
echo "  Hauptquartier wird initialisiert..."
echo "=================================================="

# Ordnerstruktur sicherstellen
mkdir -p ~/LinxOS/bin ~/LinxOS/lua_scripts ~/LinxOS/www

# Build.prop ins System laden
if [ -f "build.prop" ]; then
    echo "[+] Lade System-Properties: Die Krieger von Es..."
    cat build.prop
fi

echo "[✔] Hauptquartier bezugsfertig, Mr. President!"
