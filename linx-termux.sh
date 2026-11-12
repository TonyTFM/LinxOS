#!/bin/bash
# =====================================================================
# LinxTermux v1.0 Final — "Die Krieger von Es"
# Native Android Termux / Bash Initialization Engine für GN9
# =====================================================================

CLEAR="\033[0m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
RED="\033[1;31m"

echo -e "${GREEN}"
echo "======================================================"
echo "    LINXTERMUX v1.0 FINAL: DIE KRIEGER VON ES         "
echo "    Commander: GN9 | Status: GODMODE                  "
echo "======================================================"
echo -e "${CLEAR}"

# 1. System-Eigenschaften laden, falls vorhanden
if [ -f "$HOME/LinxOS/build.prop" ]; then
    echo -e "${CYAN}[+] Lade Imperiale Build-Properties...${CLEAR}"
    source "$HOME/LinxOS/build.prop"
    echo -e "    -> Codename: ${YELLOW}$ro_linxos_codename${CLEAR}"
    echo -e "    -> Version:  ${YELLOW}$ro_linxos_version${CLEAR}"
fi

# 2. Umgebung und Aliase in die .bashrc hämmern, falls noch nicht geschehen
BASHRC="$HOME/.bashrc"
if ! grep -q "LinxTermux - Die Krieger von Es" "$BASHRC" 2>/dev/null; then
    echo -e "${CYAN}[+] Konfiguriere permanente Bash-Umgebung...${CLEAR}"
    cat << 'BASHCONFIG' >> "$BASHRC"

# --- LinxTermux: Die Krieger von Es (Config Start) ---
export PS1="\[\033[1;32m\][GN9@Es-Termux \W]\$\[\033[0m\] "
alias linx-start="cd ~/LinxOS && ./linx-termux.sh"
alias linx-server="cd ~/LinxOS && ./bin/linx-server"
alias linx-status="echo '=== DIE KRIEGER VON ES ==='; cat ~/LinxOS/build.prop"
# --- LinxTermux (Config End) ---
BASHCONFIG
    echo -e "${GREEN}[✔] Bash-Prompt erfolgreich auf GN9 & Es-Termux angepasst!${CLEAR}"
fi

# 3. Verzeichnisse sicherstellen
mkdir -p "$HOME/LinxOS/bin" "$HOME/LinxOS/lua_scripts"

echo -e "${GREEN}[✔] LinxTermux Hauptquartier ist bereit, Mr. President!${CLEAR}"
echo -e "Tippe ${YELLOW}linx-status${CLEAR} oder starte deine Server über das Menü."
