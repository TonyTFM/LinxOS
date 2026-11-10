#!/usr/bin/env bash

# ==========================================
#  LinxOS Apex Engine (Termux Core Booster)
# ==========================================

echo -e "\033[01;35m[Apex Engine]\033[00m Initialisiere Termux-Hardware-Kontext..."

# 1. Speicher- & Performance-Optimierung
export TMPDIR="$LINX_ROOT/tmp"
mkdir -p "$TMPDIR"

# 2. VirtIO / Termux-Grafik & Terminal-Beschleunigung
export TERM=xterm-256color
export COLORTERM=truecolor

# 3. Termux-spezifische Pfad-Einbindung (Falls Vorhanden)
if [ -d "/data/data/com.termux/files/usr/bin" ]; then
    export PATH="$PATH:/data/data/com.termux/files/usr/bin"
fi

# 4. Status-Meldung
sys_boost() {
    echo -e "\033[01;32m[Apex Engine]\033[00m LinxOS läuft mit maximaler Performance auf Termux-Basis! 🚀"
}

sys_boost