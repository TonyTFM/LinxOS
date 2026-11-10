#!/usr/bin/env bash

# Projekt-Wurzelverzeichnis dynamisch ermitteln
LINX_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LINX_ROOT

# Prüfen ob die Kern-Konfiguration existiert
if [ -f "$LINX_ROOT/core/system.sh" ]; then
    exec bash --rcfile "$LINX_ROOT/core/system.sh"
else
    echo "Fehler: core/system.sh wurde nicht gefunden in $LINX_ROOT!"
    exit 1
fi