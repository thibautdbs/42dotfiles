#!/usr/bin/env zsh

if ! type exa >/dev/null 2>&1; then
	return;
fi

################################################################################
### LL

alias ll='exa -T -L1 --group-directories-first --icons --classify';

alias ll2='ll -L2';
alias ll3='ll -L3';
alias ll4='ll -L4';

################################################################################
### LA

alias la='ll -a';

alias la2='la -L2';
alias la3='la -L3';
alias la4='la -L4';
