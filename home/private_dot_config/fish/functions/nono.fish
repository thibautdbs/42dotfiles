function nono --wraps 'norminette'
    set sources (fd -e .c);
    set headers (fd -e .h);
    
    set h_err "$(norminette -R CheckDefine $headers | grep Error)";
	set c_err "$(norminette -R CheckForbiddenSourceHeader $sources | grep Error)";
	if test -z $h_err; and test -z $c_err;
		echo everything ok;
		return ;
	end
	echo "$h_err";
	echo "$c_err";
end
