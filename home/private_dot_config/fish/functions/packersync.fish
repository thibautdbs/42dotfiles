function packersync --wraps=nvim\ --headless\ -c\ \'autocmd\ User\ PackerComplete\ quitall\'\ -c\ \'lua\ require\(\[\[bootstrap\]\]\)\' --description alias\ packersync=nvim\ --headless\ -c\ \'autocmd\ User\ PackerComplete\ quitall\'\ -c\ \'lua\ require\(\[\[bootstrap\]\]\)\'
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'lua require([[bootstrap]])' $argv
        
end
