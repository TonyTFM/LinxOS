#!/bin/bash
# =====================================================
# Git Termux Auto-Installer — "git termux" v1.0 Final
# Befehl: pkg install git termux -> i installed Git-Termux
# =====================================================

echo "[*] Install Git Termux"
pkg update -y && pkg install -y git curl zip

echo "[*] Start Git Clone Termux..."
git clone https://github.com/TonyTFM/LinxOS.git ~/git-termux 2>/dev/null || {
    echo "[*] Git Termux is updating..."
    cd ~/git-termux && git pull origin main
}

cd ~/git-termux
chmod +x hq_setup.sh linx-termux.sh

echo "[*] Start Git Termux installation protocols..."
./linx-termux.sh

echo "[✔] Git installed in Termux"
