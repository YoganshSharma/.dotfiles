#SHELL=/bin/zsh
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
eval "$(starship init zsh)"
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Case insensitivity while TAB completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# # vi mode
# # bindkey -v
# # export KEYTIMEOUT=1

source ~/.config/shell/aliasrc
source ~/.config/shell/functionrc

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lfub -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'
bindkey -s '^n' 'cd ..\n'


bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

source ~/.config/zsh/plugins/copy-pasta/copy-pasta.plugin.zsh 
#source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh
source ~/.config/zsh/plugins/ohmyzsh/plugins/dirhistory/dirhistory.plugin.zsh
# eval "$(lua ~/.config/zsh/plugins/z.lua --init zsh)"
# [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
eval "$(zoxide init zsh)"

#auto-notify plugin settings
# Set threshold to 20seconds
export AUTO_NOTIFY_THRESHOLD=20
AUTO_NOTIFY_IGNORE+=("ranger" "fzf" "lf" "pulsemixer" "mpv" "bat" "zathura")

# python autoenv setup, in the directory make .env file and write activation command
# source `which activate.sh` 


#PF_INFO="ascii title os host shell wm kernel uptime pkgs memory palette" pfetch

eval $(thefuck --alias) # https://github.com/nvbn/thefuck

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm node version manager
# source /usr/share/nvm/init-nvm.sh

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip
# pip zsh completion end

#[ -f "/home/yogansh/.ghcup/env" ] && source "/home/yogansh/.ghcup/env" # ghcup-env

# bun completions
[ -s "/home/yogansh/.bun/_bun" ] && source "/home/yogansh/.bun/_bun"
# fortune -a -c |cowsay
# fortune |cowsay -f tux

# opam configuration
[[ ! -r /home/yogansh/.opam/opam-init/init.zsh ]] || source /home/yogansh/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
# Load syntax highlighting; should be last.
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/yogansh/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f "/home/yogansh/.ghcup/env" ] && source "/home/yogansh/.ghcup/env" # ghcup-env
