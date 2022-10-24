function fish_greeting;
	if not set -q MOTDSHOWN;
		set motd "$HOME/.config/fish/motd.bash";
		if test -f $motd;
			cat $motd | bash;
		end
		set 42dfmsg "$(42df fetch)";
		if not test -z $42dfmsg;
			set_color red; echo \n "-> $42dfmsg";
		end
		set -Ux MOTDSHOWN;
	end	
end
