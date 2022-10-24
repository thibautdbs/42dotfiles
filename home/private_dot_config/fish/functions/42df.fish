function 42df																\
--wraps="chezmoi --source $HOME/.local/share/42dotfiles"					\
--description "alias 42df chezmoi --source $HOME/.local/share/42dotfiles"	
	chezmoi --source "$HOME/.local/share/42dotfiles" $argv
   
end
