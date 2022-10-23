# ##############################################################################
# ##                   __ _          __ _     _                                #
# ##                  / _(_)        / _(_)   | |                               #
# ##   ___ ___  _ __ | |_ _  __ _  | |_ _ ___| |__                             #
# ##  / __/ _ \| '_ \|  _| |/ _` | |  _| / __| '_ \                            #
# ## | (_| (_) | | | | | | | (_| |_| | | \__ \ | | |                           #
# ##  \___\___/|_| |_|_| |_|\__, (_)_| |_|___/_| |_|                           #
# ##                         __/ |                                             #
# ##                        |___/                                              #
# ##                                                                           #
# ##############################################################################

fish_add_path "$HOME/bin";
fish_add_path "$HOME/.local/bin";
fish_add_path "$HOME/.local/share/42dotfiles/bin";

if status is-interactive;
    if not set -q TMUX; and type -q tmux;
        tmux has-session > /dev/null 2>&1;
        if test $status -eq 0;
			tmux new-window -t default;
            exec tmux attach -t default;
        else
			set -x FISHLOGINSHELL 1
            source "$HOME/.config/fish/profile.fish";
            exec tmux new -s default;
        end
    end
    
	bind \cp "fzfvim";
	bind \cd "fzfcd";

    zoxide init fish | source;
    starship init fish | source;
end
