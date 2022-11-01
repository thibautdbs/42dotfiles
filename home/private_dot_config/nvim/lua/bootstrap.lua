local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim';
local packer_url = 'https://github.com/wbthomason/packer.nvim';
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path});
	vim.cmd("packadd packer.nvim");
end

local startup = function(use)

use('wbthomason/packer.nvim');
use('lewis6991/impatient.nvim');

use({
	'sainnhe/everforest',
	config = function()
		vim.opt.termguicolors = true;
		vim.opt.background = 'dark';
		vim.g.everforest_background = 'soft';
		vim.g.everforest_enable_italic = 0;
		vim.g.everforest_disable_italic_comment = 1;
		vim.g.everforest_better_performance = 1;
		vim.cmd("colorscheme everforest");
	end
});
use({
	'nvim-lualine/lualine.nvim',
	requires = 'nvim-tree/nvim-web-devicons',
	config = function()
		local options = {
			theme = 'everforest',
			section_separators = '',
			component_separators = '',
			globalstatus = true
		};
		require('lualine').setup({options = options});
	end
});
use({
	'romgrk/barbar.nvim',
	requires = 'nvim-tree/nvim-web-devicons',
	config = function()
		require('bufferline').setup({
			animation = false,
			auto_hide = false,
			closable = true,
			clickable = true,
			icons = true,
		});
		vim.keymap.set('n', '<leader><left>', '<cmd>BufferPrevious<cr>');
		vim.keymap.set('n', '<leader><right>', '<cmd>BufferNext<cr>');
		vim.keymap.set('n', '<leader>w', '<cmd>BufferClose<cr>');
	end
});

-- #############################################################################
-- #############################################################################
-- #############################################################################

use({ 'L3MON4D3/LuaSnip', opt = true });
use({ 'neovim/nvim-lspconfig', opt = true });
use({ 'hrsh7th/cmp-path', opt = true });
use({ 'hrsh7th/cmp-buffer', opt = true });
use({ 'hrsh7th/cmp-cmdline', opt = true });
use({ 'hrsh7th/cmp-nvim-lsp', opt = true });
use({ 'saadparwaiz1/cmp_luasnip', opt = true });
use({
	'hrsh7th/nvim-cmp',
	opt = true,
	event = 'VimEnter',
	config = function()
		require("packer.load")({'LuaSnip'}, {}, _G.packer_plugins);
		require("packer.load")({'nvim-lspconfig'}, {}, _G.packer_plugins);
		require("packer.load")({'cmp-path'}, {}, _G.packer_plugins);
		require("packer.load")({'cmp-buffer'}, {}, _G.packer_plugins);
		require("packer.load")({'cmp-cmdline'}, {}, _G.packer_plugins);
		require("packer.load")({'cmp_luasnip'}, {}, _G.packer_plugins);
		require("packer.load")({'cmp-nvim-lsp'}, {}, _G.packer_plugins);

		local cmp = require('cmp');
		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body);
				end
			},
			mapping = cmp.mapping.preset.insert({
				['<c-space>'] = cmp.mapping.complete(),
				['<c-e>'] = cmp.mapping.abort(),
				['<cr>'] = cmp.mapping.confirm({ select = false })
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'buffer'},
				{ name = 'path'}
			})
		});
		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		});
		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' },
				{ name = 'cmdline' }
			})
		});
	end
});

-- #############################################################################
-- #############################################################################
-- #############################################################################

use({
	'hrsh7th/cmp-nvim-lua',
	opt = true,
	ft = 'lua',
	config = function()
		local cmp = require('cmp');
		cmp.setup.filetype('lua', {
			sources = cmp.config.sources({
				{ name = 'buffer' },
				{ name = 'nvim_lua'}
			})
		});
	end
});

use({
	'williamboman/mason.nvim',
	opt = true,
	run = function()
		require('mason').setup();
		vim.cmd('MasonInstall clangd');
	end
});
use({ 
	'p00f/clangd_extensions.nvim',
	opt = true,
	ft = 'c',
	config = function()
		require("packer.load")({'mason.nvim'}, {}, _G.packer_plugins);
		require('mason').setup();

		local capabilities = require('cmp_nvim_lsp').default_capabilities();
		local on_attach = function(client, bufnr)
			vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc');

			local bufopts = { noremap=true, silent=true, buffer=bufnr };
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts);
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts);
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts);
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts);
			vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts);
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts);
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts);
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts);
		end;
		require('clangd_extensions').setup({
			server = {
				capabilities = capabilities,
				on_attach = on_attach
			}
		});
	end
});

-- #############################################################################
-- #############################################################################
-- #############################################################################

	use({
		'lukas-reineke/indent-blankline.nvim',
		opt = true,
		event = 'VimEnter',
		config = function()
			require('indent_blankline').setup({
				show_current_context = true,
				show_current_context_start = true,
			});
		end
	});
	use({
		'nvim-treesitter/nvim-treesitter',
		opt = true,
		ft = {"c", "lua", "bash", "fish", "python"},
		run = function()
			require('nvim-treesitter.install').update({ with_sync = true });
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "bash", "fish", "python"},
				sync_install = false,
				auto_install = true,
				additional_vim_regex_highlighting = false,
				highlight = { enable = true }
			});
		end
	});

	use({ 
		'ibhagwan/fzf-lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
		opt = true,
		keys = {
			{'n', '<leader>p'},
			{'n', '<leader>P'},
			{'v', '<leader>s'},
			{'n', '<leader>d'},
			{'n', '<leader>S'}
		},
		config = function()
			cmd = "<cmd>lua require('fzf-lua')"
			vim.keymap.set('n', '<leader>p', cmd .. ".files()<cr>");
			vim.keymap.set('n', '<leader>P', cmd .. ".commands()<cr>");
			vim.keymap.set('v', '<leader>s', cmd .. ".grep_visual()<cr>");
			vim.keymap.set('n', '<leader>d', cmd .. ".grep_cword()<cr>");
			vim.keymap.set('n', '<leader>S', cmd .. ".git_status()<cr>");
		end
	});
	use({
		'numToStr/Comment.nvim',
		opt = true,
		keys = {
			{'n', '<leader>cc'},
			{'n', '<leader>bc'},
			{'v', '<leader>cc'},
			{'v', '<leader>bc'}
		},
		config = function()
			require('Comment').setup({
				toggler = {
					line = '<leader>cc',
					block = '<leader>bc'
				},
				opleader = {
					line = '<leader>cc',
					block = '<leader>bc'
				},
				mappings = {
					basic = true,
					extra = false
				}
			});
		end
	});
	use({
		'42Paris/42header',
		event = 'VimEnter'
	});
end

require('packer').startup({
	startup,
	config = {
		auto_clean = true,
  		compile_on_sync = true
  	}
});

require('packer').sync();