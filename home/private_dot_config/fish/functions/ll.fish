function ll \
--wraps='exa -T -L1 --group-directories-first --icons --classify' \
--description 'alias ll exa -T -L1 --group-directories-first --icons --classify'
	exa -T -L1 --group-directories-first --icons --classify $argv
        
end
