# # ==============================================================
# LinxOS - GitHub Dark Blue Theme & Aliases (.bashrc)
# ==============================================================

# Prompt Design: Dark-Grey Bracket, Pure White User, GitHub Blue Host, Bright Blue Path
export PS1="\[\033[38;5;240m\][\[\033[38;5;255m\]GN9\[\033[38;5;39m\]@Apex \[\033[38;5;75m\]\w\[\033[38;5;240m\]]\[\033[0m\]\$ "

# GitHub Dark Directory & File Colors
export LS_COLORS="di=1;38;5;75:ln=1;38;5;117:so=1;38;5;141:pi=1;38;5;215:ex=1;38;5;84:bd=38;5;240:cd=38;5;240:su=30;41:sg=30;43:tw=30;42:ow=38;5;75"

# Standard-Tools mit Farbunterstützung
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# LinxOS Core Utilities & Pfade
export PATH="$HOME/LinxOS/bin:$PATH"
alias sync='~/LinxOS/bin/linx-sync'
alias pack='~/LinxOS/bin/linx-pack'
alias info='~/LinxOS/bin/linx-info'
alias clean='~/LinxOS/bin/linx-clean'
alias spacewars='~/LinxOS/bin/linx-spacewars'

# Komfort-Aliases
alias logout='exit'
alias godmode='echo "==================================================" && echo "🔥 [GODMODE ENGAGED]: Willkommen im Olymp, GN9!" && echo "==================================================" && export PS1="[GOD-MODE@SEEGURKE:\w]/# "'

