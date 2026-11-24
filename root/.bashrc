#$ If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

#@ Exports
export TERM="xterm-256color"
export MANPAGER="bat -l man -p"
export VISUAL="nvim"
export EDITOR="$VISUAL"
#$ for dolphin theming
export QT_QPA_PLATFORMTHEME=qt6ct


#@ Wikiman
source /usr/share/wikiman/widgets/widget.bash

#@ starship
eval "$(starship init bash)"

#@ zoxide
eval "$(zoxide init bash)"

#@ yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

#@ eza
alias ls="eza -l --color-scale=all --icons=always --group-directories-first --git --git-repos --time-style '+%_d %b %y %_I.%M %p'"
alias la="eza -l --color-scale=all --icons=always --group-directories-first --git --git-repos --time-style '+%_d %b %y %_I.%M %p' -a"
alias ll="eza -l --color-scale=all --icons=always --group-directories-first --git --git-repos --time-style '+%_d %b %y %_I.%M %p' --total-size -a"

#@ nvim
alias v="nvim"

#@ lazygit
alias lg="lazygit"

#@ custom aliases
alias snaphome='sudo snapper -c home create --description "Manual Save"'
alias freepacman='sudo rm /var/lib/pacman/db.lck'
alias proxy='ALL_PROXY=socks5h://127.0.0.1:10808'