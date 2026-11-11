#!/usr/bin/env bash

# ==========================================
#  LinxOS Extensions & Vanilla GemiN9 Engine
#  Theme: GitHub-Dark Edition
# ==========================================

# 1. Terminal-Farben auf GitHub Dark setzen (Schwarzer Hintergrund / Weiße Schrift)
echo -e "\033[40m\033[97m"

# 2. GitHub-Style Willkommens-Banner
gemin9_init() {
    clear
    echo -e "\033[40;\033[1;90m==================================================\033[0m"
    echo -e "\033[40;\033[1;97m   Vanilla GemiN9 Engine v1.0 [GitHub-Dark]       \033[0m"
    echo -e "\033[40;\033[1;90m==================================================\033[0m"
    echo -e "\033[40;\033[97m[*]\033[36m git branch:\033[97m main"
    echo -e "\033[40;\033[97m[*]\033[92m status:\033[97m LinxOS GitHub Engine aktiv 🚀"
    echo -e "\033[40;\033[1;90m--------------------------------------------------\033[0m"
    echo ""
}

# 3. Custom GitHub Prompt (Dunkelgrauer Grund, Grünes GN9, Weißer Pfad)
export PS1='\[\033[40;\033[1;92m\][GN9@GitHub \[\033[97m\]\w\[\033[92m\]]\$ \[\033[0m\]'

# 4. Helpers & Aliase
sysinfo() {
    echo -e "\033[40;\033[1;92m=== GemiN9 GitHub Status ===\033[0m"
    echo -e "\033[40;\033[97mLinx Root: \033[36m$LINX_ROOT\033[0m"
    echo -e "\033[40;\033[97mGit Commit:\033[92m $(git rev-parse --short HEAD 2>/dev/null || echo 'Kein Git Repo')\033[0m"
    echo -e "\033[40;\033[97mZeit:       \033[97m$(date +'%H:%M:%S')\033[0m"
}

alias info='sysinfo'
alias gst='git status'
alias gpl='git pull origin main'
alias cls='clear && gemin9_init'

# Boot
gemin9_init

# Root / Sudo System Integration
alias 'sudo -i'='tsu'
alias root='$LINX_ROOT/bin/linx-root'

# Sudo & Root System Integration (via Funktion statt Alias mit Leerzeichen)
sudo() {
    if [ "$1" = "-i" ]; then
        shift
        if command -v tsu &> /dev/null; then
            tsu -p -s /system/bin/sh
        else
            su -c "export PS1='\[\033[40;\033[1;31m\][ROOT@LinxOS-GN9 \[\033[97m\]\w\[\033[31m\]]# \[\033[0m\]'; bash"
        fi
    else
        if command -v tsu &> /dev/null; then
            tsu "$@"
        else
            su -c "$*"
        fi
    fi
}

# Sudo & Root System Integration (via Funktion statt Alias mit Leerzeichen)
sudo() {
    if [ "$1" = "-i" ]; then
        shift
        if command -v tsu &> /dev/null; then
            tsu -p -s /system/bin/sh
        else
            su -c "export PS1='\[\033[40;\033[1;31m\][ROOT@LinxOS-GN9 \[\033[97m\]\w\[\033[31m\]]# \[\033[0m\]'; bash"
        fi
    else
        if command -v tsu &> /dev/null; then
            tsu "$@"
        else
            su -c "$*"
        fi
    fi
}

# LinxOS Interactive Sudo / Root Wrapper
sudo() {
    if [ "$1" = "-i" ]; then
        # Ruft direkt dein Root-Challenge Skript auf
        "$LINX_ROOT/bin/linx-root"
    else
        # Normale Befehlsausführung über tsu/su
        if command -v tsu &> /dev/null; then
            tsu "$@"
        else
            su -c "$*"
        fi
    fi
}

# LinxOS Interactive Sudo / Root Wrapper
sudo() {
    if [ "$1" = "-i" ]; then
        # Ruft direkt dein Root-Challenge Skript auf
        "$LINX_ROOT/bin/linx-root"
    else
        # Normale Befehlsausführung über tsu/su
        if command -v tsu &> /dev/null; then
            tsu "$@"
        else
            su -c "$*"
        fi
    fi
}

# LinxOS Interactive Sudo / Root Wrapper
sudo() {
    if [ "$1" = "-i" ]; then
        "$LINX_ROOT/bin/linx-root"
    else
        su -c "$*"
    fi
}
alias lock='/data/data/com.termux/files/home/LinxOS/bin/linx-lock'
