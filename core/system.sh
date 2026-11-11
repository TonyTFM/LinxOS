#!/usr/bin/env bash

# Eigenes LinxOS-Bin-Verzeichnis zum PATH hinzufügen
export PATH="$LINX_ROOT/bin:$PATH"

# Eigenes Command-History-File (damit Termux-Befehle getrennt bleiben)
export HISTFILE="$LINX_ROOT/.linx_history"
export HISTSIZE=5000
export SAVEHIST=5000

# Dein eigener Prompt
export PS1='\[\033[01;34m\]GN9@LinxOS\[\033[00m\]:\[\033[01;32m\]\w\[\033[00m\]\$ '
export TERM=xterm-256color

# Nützliche Aliase für dein LinxOS
alias ll='ls -alF --color=auto'
alias update='$LINX_ROOT/core/update.sh'
alias reload='exec bash --rcfile $LINX_ROOT/core/system.sh'

echo -e "\033[01;34m=========================================="
echo -e "       LinxOS Environment Started        "
echo -e "==========================================\033[00m"
# Extensions automatisch laden/füttern
if [ -f "$LINX_ROOT/core/extensions.sh" ]; then
    source "$LINX_ROOT/core/extensions.sh"
fi