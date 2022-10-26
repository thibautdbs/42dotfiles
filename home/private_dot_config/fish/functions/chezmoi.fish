function chezmoi --wraps 'chezmoi'
	if test (count $argv) -eq 1; and test $argv[1] = 'cd';
		cd (command 'chezmoi' source-path);
	else
		command 'chezmoi' $argv;
	end
end
