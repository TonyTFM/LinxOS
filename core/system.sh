#!/usr/bin/env bash
# Standard Termux/LinxOS Umgebung
export PS1='\[\033[01;34m\]GN9@LinxOS\[\033[00m\]:\[\033[01;32m\]\w\[\033[00m\]\$ '
export TERM=xterm-256color

# Nützliche Aliase für dein System
alias ll='ls -alF'
alias update='$LINX_ROOT/core/update.sh'

echo "=========================================="
echo "       LinxOS Environment Started        "
echo "=========================================="