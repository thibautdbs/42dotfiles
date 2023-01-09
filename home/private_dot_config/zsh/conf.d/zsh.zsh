#!/usr/bin/env zsh

################################################################################
### MOVEMENT

setopt AUTO_CD;

################################################################################
### HISTORY

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history;
SAVEHIST=5000;
HISTSIZE=2000;

setopt HIST_IGNORE_ALL_DUPS;
setopt HIST_SAVE_NO_DUPS;

setopt INC_APPEND_HISTORY;

if ! type history-substring-search-up >/dev/null 2>&1; then
	return;
fi

if ! type history-substring-search-down >/dev/null 2>&1; then
	return;
fi

bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down
