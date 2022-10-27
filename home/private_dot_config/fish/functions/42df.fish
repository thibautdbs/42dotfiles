function 42df
	set chezmoiflags --source "$HOME/.local/share/42dotfiles/";
	if test (count $argv) -eq 0;
		return ;
	end
	if test $argv[1] = 'fetch';
		set gitcmd status --short --branch --porcelain=2;
		
		echo -n '42df: fetching update  '
		command chezmoi $chezmoiflags git -- fetch > /dev/null 2>&1 &;
		function on_exit --on-process-exit $last_pid;
			set -g -e SPIN;
		end
		set -g SPIN;
		while set -q SPIN;
			for c in '|' '/' '-' '\\';
				printf "\b%c \b" $c; 
				sleep 0.1;
			end
		end
		printf '\r'; tput el;

		if test -z (chezmoi $chezmoiflags git -- $gitcmd | grep -e 'branch.ab' -e '\-0');
			echo '42df: update available, update with `42df update`.';
		else
			echo '42df: up to date';
		end
	end
	if test $argv[1] = 'update';
		chezmoi $chezmoiflags update
	end
end
