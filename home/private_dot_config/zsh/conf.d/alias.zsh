#!/usr/bin/env zsh

declare -r FTDF_ALIASES="${HOME}/.cache/42dotfiles/aliases.zsh";

if [[ -f "${FTDF_ALIASES}" ]]; then
	if [[ ! "${FTDF_ALIASES}.zwc" -nt "${FTDF_ALIASES}" ]]; then
		zcompile "${FTDF_ALIASES}";
	fi
	source "${FTDF_ALIASES}";
fi

if [[ ! -f "${FTDF_ALIASES}" && -f "${FTDF_ALIASES}.zwc" ]]; then
	rm -f "${FTDF_ALIASES}.zwc";
fi

function __save_alias()
{
	declare -r KEY="${1/%=*/}";
	declare -r VALUE="${1/#*=/}";

	declare -r TMP=$(mktemp "${FTDF_ALIASES}.bak.XXXXXXXX")

	if [[ -f "${FTDF_ALIASES}" ]]; then
		grep -v "^alias '${KEY}'=" "${FTDF_ALIASES}" > "${TMP}";
	fi
	echo "alias '${KEY}'='${VALUE}';" >> "${TMP}";
	sort -u "${TMP}" > "${FTDF_ALIASES}";
	rm -f "${TMP}";
}

function __unsave_alias()
{
	declare -r KEY="${1/%=*/}";
	declare -r VALUE="${1/#*=/}";

	if [[ ! -f "${FTDF_ALIASES}" ]]; then
		return 0;
	fi

	declare -r TMP=$(mktemp "${FTDF_ALIASES}.bak.XXXXXXXX")

	grep -v "^alias '${KEY}'=" "${FTDF_ALIASES}" > "${TMP}";
	sort -u "${TMP}" > "${FTDF_ALIASES}";
	rm -f "${TMP}";
}

function alias()
{
	if [[ "$1" == "-S" ]]; then
		shift;
		builtin alias "${@}" >&/dev/null || return "$?";
		__save_alias "${1}";
		return "$?";
	fi
	builtin alias "${@}";
}

function unalias()
{
	if [[ "$1" == "-S" ]]; then
		shift;
		builtin unalias "${@}" >&/dev/null || return "$?";
		__unsave_alias "${1}";
		return "$?";
	fi
	builtin unalias "${@}";
}
