#!/usr/bin/env bash

# LinxOS-Projektpfad dynamisch ermitteln
export LINX_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Prüfen, ob die System-Konfiguration existiert
if [ -f "$LINX_ROOT/core/system.sh" ]; then
    # Startet eine neue Bash-Instanz mit deiner isolierten LinxOS-Konfiguration
    exec bash --rcfile "$LINX_ROOT/core/system.sh"
else
    echo "Fehler: core/system.sh wurde in $LINX_ROOT nicht gefunden!"
    exit 1
fi