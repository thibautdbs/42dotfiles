#!/usr/bin/env zsh

__fzf_nvim()
{
	# Select regular file using fzf.
	declare -r PREVIEW='bat --style=numbers --color=always {} | head -500';
	declare -r FILE=$(														\
		fd	--type f --hidden --follow --exclude .git 						\
			| fzf	--preview="${PREVIEW}" --layout=reverse -q "${BUFFER}"	\
	);

	# Open selected file in neovim (if selection is not empty).
	if [[ -n "${FILE}" ]]; then
		BUFFER="nvim ${FILE}";
		zle accept-line;
	fi

	# Redraw prompt.
	declare PRECMD;
	for PRECMD in ${precmd_functions}; do
		${PRECMD};
	done
	zle reset-prompt;
}

zle -N __fzf_nvim;
bindkey '^p' __fzf_nvim;
