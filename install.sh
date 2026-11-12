#!/bin/bash
echo -e "\033[1;31m⚡ [LinxOS Installer]: Setting up your exact environment...\033[0m"

# 1. Verzeichnisse sicherstellen
mkdir -p "$HOME/LinxOS/bin"
mkdir -p "$HOME/.bin"

# 2. Rechte für alle Skripte und Binaries setzen
chmod +x "$HOME/LinxOS/bin/"* 2>/dev/null

# 3. PATH in .bashrc einbetten, falls noch nicht geschehen
if ! grep -q "LinxOS/bin" "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/LinxOS/bin:$PATH"' >> "$HOME/.bashrc"
    echo -e "\033[1;32m[+] Added LinxOS bin to PATH in .bashrc\033[0m"
fi

echo -e "\033[1;32m[✔] LinxOS successfully installed! Restart your terminal or run: source ~/.bashrc\033[0m"
