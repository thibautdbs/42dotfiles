#!/usr/bin/env zsh

__fzf_nvim()
{
	local PREVIEW='bat --style=numbers --color=always {} | head -500';
	local FILE=$(												\
		fd	--type f --hidden --follow --exclude .git			\
			| xargs file										\
			| awk -F: '/(ASCII text)|(empty)/ {print $1}'		\
			| fzf	--preview="${PREVIEW}"						\
					--layout=reverse							\
	);
	if [[ -n "${FILE}" ]]; then
		BUFFER="nvim ${FILE}";
		zle accept-line;
	fi
	zle reset-prompt;
}

zle -N __fzf_nvim;
bindkey '^p' __fzf_nvim;
