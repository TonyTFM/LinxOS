#!/usr/bin/env bash

# ==========================================
#  LinxOS Extensions & Auto-Feeder
# ==========================================

# 1.# In core/extensions.sh
echo -e "\033[01;32m[GemiN9 Engine]\033[00m LinxOS-Erweiterungen erfolgreich geladen." Automatische Start-Befehle (Befehle einspeisen)

fuettern() {
    echo -e "\033[01;33m[LinxOS Feeder]\033[00m Füttere Shell mit benutzerdefinierten Befehlen..."
    # Hier kannst du beliebige Start-Befehle ablegen:
    # pkg update -y
}

# 2. Eigene erweiterte Funktionen
sysinfo() {
    echo -e "\033[01;34m=== LinxOS System Info ===\033[00m"
    echo -e "Projekt-Pfad: $LINX_ROOT"
    echo -e "Shell:        $SHELL"
    echo -e "Uhrzeit:      $(date)"
}

# 3. Zusätzliche Aliase füttern
alias info='sysinfo'
alias cls='clear'
alias edsys='code $LINX_ROOT/core/system.sh'
alias edext='code $LINX_ROOT/core/extensions.sh'

# Skript-Start ausführen
fuettern