return(function(use)

use({
    'VonHeikemen/lsp-zero.nvim',
    requires = {
        -- Lib
        'nvim-lua/plenary.nvim',

        -- LSP Support
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',

        -- Formatters
        'jose-elias-alvarez/null-ls.nvim',
        'jayp0521/mason-null-ls.nvim',

        -- Autocompletion
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',

        -- Snippets
        'L3MON4D3/LuaSnip'
    },
    config = function ()
        local lsp = require('lsp-zero').preset('recommended');

        -- COMPLETIONS
        local cmp = require('cmp');
        lsp.setup_nvim_cmp({
            mapping = cmp.mapping.preset.insert({
                ['<c-space>'] = cmp.mapping.complete(),
                ['<c-e>'] = cmp.mapping.abort(),
                ['<cr>'] = cmp.mapping.confirm({ select = false })
            })
        });

        lsp.nvim_workspace({
            library = vim.api.nvim_get_runtime_file('', true)
        });

        lsp.setup();

        -- null_ls: admit non-lsp sources
        local null_ls = require("null-ls");
        local null_opts = lsp.build_options('null-ls', {});

        null_ls.setup({
            on_attach = function(client, bufnr)
                null_opts.on_attach(client, bufnr);

                local opts = {buffer = bufnr}
                local bind = vim.keymap.set

                -- use <leader>f to format buffer.
                local cmd = '<cmd>lua vim.lsp.buf.format()<cr>';
                bind('n', '<leader>f', cmd, opts);
                -- more keybindings...
            end
        });

        -- Allow null-ls sources to be installed with Mason
        require("mason-null-ls").setup({
            ensure_installed = nil,
            automatic_installation = true,
            automatic_setup = true
        });

        -- Required when `automatic_setup` is true
        require("mason-null-ls").setup_handlers({});

        vim.diagnostic.config({
            virtual_text = true
        });
    end
});

end);
