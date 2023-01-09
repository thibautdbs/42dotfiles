#!/usr/bin/env zsh

if ! type nvim >/dev/null 2>&1; then
	return;
fi

export EDITOR='nvim';
export VISUAL='nvim';

alias vim='nvim';
alias vi='nvim';
alias v='nvim';
