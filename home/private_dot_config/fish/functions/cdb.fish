function cdb --wraps='make -Bnwke --print-directory | compiledb' --description 'alias cdb make -Bnwke --print-directory | compiledb'
  make -Bnwke --print-directory | compiledb $argv
        
end
