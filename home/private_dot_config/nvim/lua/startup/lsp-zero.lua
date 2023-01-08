return(function(use)

use({
	'VonHeikemen/lsp-zero.nvim',
	requires = {
		-- LSP Support
		'neovim/nvim-lspconfig',
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',

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
		local lsp = require('lsp-zero');
		lsp.preset('recommended');

		lsp.ensure_installed({
			'clangd'
		});

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

		vim.diagnostic.config({
			virtual_text = true
		});
	end
});

end);
