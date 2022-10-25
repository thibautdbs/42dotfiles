function fish_greeting;
	if test $42DF_SHOWMOTD != 'NEVER';
		set motd "$HOME/.config/fish/motd.bash";
		if test -f $motd;
			cat $motd | bash;
		end
		set -f file "$HOME/.cache/42dotfiles/lastfetch"
		set -f today (date +%Y%m%d)
		if not test -f $file; or test $today -gt (cat $file);
			set_color brblue; 42df fetch;
		end
		mkdir -p (path dirname $file);
		echo $today > $file;
		if test $42DF_SHOWMOTD != 'ALWAYS';
			set 42DF_SHOWMOTD 'NEVER';
		end
	end	
end
