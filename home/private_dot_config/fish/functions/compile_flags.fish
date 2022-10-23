function compile_flags
    if test -f 'compile_flags.txt'
        echo "compile_flags.txt already exists.";
        bat -P 'compile_flags.txt';
        return ;
    end

	set flags "-Wall" "-Wextra" "-Werror";
    printf '%s\n' $flags > compile_flags.txt;

	set includes $argv;
	if test -z "$includes"; 
		set includes '.';
	end

	printf '-I\n%s\n' $includes >> compile_flags.txt;
end
