function fzfcd --description 'cd into directory choosen with fzf';
	set exaflags '-T -L1 --icons --group-directories-first --classify';
	set dir (fd --type directory | fzf --preview "exa $exaflags {} | bat");
	if not test -z $dir;
		cd $dir;
		commandline -f repaint;
	end
end
