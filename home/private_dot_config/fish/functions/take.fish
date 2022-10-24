function take --description "create a directory before moving into it" --wraps 'cd'
    set dir $argv[1];
    
    mkdir -p $dir;
    cd $dir;
end
