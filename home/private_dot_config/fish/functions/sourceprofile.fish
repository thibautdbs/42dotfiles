function sourceprofile														\
--wraps="source $HOME/.config/fish/profile.fish"							\
--description "alias sourceprofile source $HOME/.config/fish/profile.fish"
	source "$HOME/.config/fish/profile.fish $argv"
        
end
