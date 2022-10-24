function 42df
	set chezmoiflags --source "$HOME/.local/share/42dotfiles/";
	if test (count $argv) -eq 0;
		return ;
	end
	if test $argv[1] = 'fetch';
		set gitcmd status --short --branch --porcelain=2;
		if test -z (chezmoi $chezmoiflags git -- $gitcmd | grep 'branch.ab' | grep '\-0');
			echo '42df update available, please run `42df update`.';
		else
			echo '42df is up to date.';
		end
	end
	if test $argv[1] = 'update';
		chezmoi $chezmoiflags update
	end
end
