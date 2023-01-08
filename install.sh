#!/usr/bin/env bash

# ##############################################################################
# ## config                                                                    #
# ##############################################################################

declare -r DOTDIR="${HOME}/.local/share/42dotfiles";

declare -r PULLURL="https://github.com/thibautdbs/42dotfiles.git";
declare -r PUSHURL="git@github.com:thibautdbs/42dotfiles.git";

# ##############################################################################
# ## Main                                                                      #
# ##############################################################################

my::main()
{
	#assert DOTDIR doesn't exist.
	if [ -d "${DOTDIR}" ]; then
		echo "Error: ${DOTDIR} already exists." >&2;
		exit 1;
	fi

	git clone -o "origin" -b "master" --depth 1 "${PULLURL}" "${DOTDIR}";

	git -C "${DOTDIR}" remote set-url "origin" "${PULLURL}";
	git -C "${DOTDIR}" remote set-url --push "origin" "${PUSHURL}";

	export PATH="${DOTDIR}/bin/:${PATH}";
	export PATH="${DOTDIR}/scripts/:${PATH}";
	
	42df config;
}

main;
