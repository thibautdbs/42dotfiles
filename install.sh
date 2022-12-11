#!/usr/bin/env bash

# ##############################################################################
# ## config                                                                    #
# ##############################################################################

FTDOTDIR="${HOME}/.local/share/42dotfiles";

PULLURL="https://github.com/thibautdbs/42dotfiles.git";
PUSHURL="git@github.com:thibautdbs/42dotfiles.git";

# ##############################################################################
# ## Main                                                                      #
# ##############################################################################

main()
{
	if [ -d "${FTDOTDIR}" ]; then
		echo "error: ${FTDOTDIR} already exists" >&2;
		exit 1;
	fi
	git clone -o "origin" -b "master" --depth 1 ${PULLURL} ${FTDOTDIR};

	git -C "${FTDOTDIR}" remote set-url origin "${PULLURL}";
	git -C "${FTDOTDIR}" remote set-url --push origin "${PUSHURL}";

	${FTDOTDIR}/bin/42df config;
}

main;
