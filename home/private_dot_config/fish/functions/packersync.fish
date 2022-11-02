function packersync --description 'alias packersync=nvim -u NORC --headless -c "autocmd User PackerComplete quitall" -c "lua require([[bootstrap]])"'
  nvim -u NORC --headless -c 'autocmd User PackerComplete quitall' -c 'lua require([[bootstrap]])' $argv
        
end
