function fzfvim --description "select text files to open in vim with fzf"
	set files (fd --type file -x file					\
		| awk -F: '/(ASCII text)|(empty)/ {print $1}'	\
		| fzf)
	if not test -z $files;
		vim $files
	end
end
