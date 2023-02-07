#!/usr/bin/env zsh

if ! command -v fd fzf bat nvim >&/dev/null; then
	return ;
fi

__fzf_nvim()
{
	# File preview command.
	typeset -r PREVIEW='bat --style=numbers --color=always {} | head -500';

	# Select regular file using fzf.
	fd --hidden --follow --type file --exclude '.git' --exclude '*.zwc'	\
		| fzf --preview="${PREVIEW}" --layout=reverse					\
		| read FILE;

	# Open selected file in neovim (if selection is not empty).
	if [[ -n "${FILE}" ]]; then
		BUFFER="nvim ${FILE}";
		zle accept-line;
	fi
}

zle -N __fzf_nvim;
bindkey '^p' __fzf_nvim;
