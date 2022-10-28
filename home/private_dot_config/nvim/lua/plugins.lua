-- #############################################################################
-- ##        _             _             _                                     #
-- ##       | |           (_)           | |                                    #
-- ##  _ __ | |_   _  __ _ _ _ __  ___  | |_   _  __ _                         #
-- ## | '_ \| | | | |/ _` | | '_ \/ __| | | | | |/ _` |                        #
-- ## | |_) | | |_| | (_| | | | | \__ \_| | |_| | (_| |                        #
-- ## | .__/|_|\__,_|\__, |_|_| |_|___(_)_|\__,_|\__,_|                        #
-- ## | |             __/ |                                                    #
-- ## |_|            |___/                                                     #
-- ##                                                                          #
-- #############################################################################

-- #############################################################################
-- ## packer                                                                   #
-- #############################################################################

local ensure_packer = function()
	local fn = vim.fn;
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim';
	local packer_url = 'https://github.com/wbthomason/packer.nvim';
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', packer_url, install_path});
		vim.cmd("packadd packer.nvim");
		return true;
	end
	return false;
end

local packer_bootstrap = ensure_packer();

vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]);

local startup = function(use)
	use('wbthomason/packer.nvim');

	use({
		'sainnhe/everforest',
		config = function()
			if vim.fn.has('termguicolors') == 1 then
				vim.opt.termguicolors = true;
			end
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
		requires = { 
			'kyazdani42/nvim-web-devicons',
			'sainnhe/everforest'
		},
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
		requires = {
			'kyazdani42/nvim-web-devicons',
			'sainnhe/everforest'
		},
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
		'williamboman/mason.nvim',
		-- opt = true,
		-- event = 'VimEnter',
		config = function ()
			require("mason").setup();
		end
	});
	use({
		'hrsh7th/nvim-cmp',
		requires = {
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-cmdline'},
			{'hrsh7th/cmp-nvim-lua'},
			{'L3MON4D3/LuaSnip'},
			{'saadparwaiz1/cmp_luasnip'},
			{'neovim/nvim-lspconfig'},
			{'p00f/clangd_extensions.nvim'}
		},
		-- opt = true,
		-- event = 'VimEnter',
		config = function()
			local cmp = require('cmp');
			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
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
			cmp.setup.filetype('lua', {
				sources = cmp.config.sources({
					{ name = 'buffer' },
					{ name = 'nvim_lua'}
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

			local opts = { noremap=true, silent=true };
			vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts);
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
			end
			require('clangd_extensions').setup({
				server = {
					capabilities = capabilities,
					on_attach = on_attach
				}
			});
		end
	});
	-- use({
	-- 	'p00f/clangd_extensions.nvim',
	-- 	requires = {
	-- 		{'neovim/nvim-lspconfig', opt = true},
	-- 		{'hrsh7th/cmp-nvim-lsp', opt = true}
	-- 	},
	-- 	ft = {'c'},
	-- 	-- after = {'nvim-cmp'},
	-- 	config = function()
	-- 		local opts = { noremap=true, silent=true };
	-- 		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts);
	-- 		local capabilities = require('cmp_nvim_lsp').default_capabilities();
	-- 		local on_attach = function(client, bufnr)
	-- 			vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc');
	--
	-- 			local bufopts = { noremap=true, silent=true, buffer=bufnr };
	-- 			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts);
	-- 			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts);
	-- 			vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts);
	-- 			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts);
	-- 			vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts);
	-- 			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts);
	-- 			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts);
	-- 			vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts);
	-- 		end
	-- 		require('clangd_extensions').setup({
	-- 			server = {
	-- 				capabilities = capabilities,
	-- 				on_attach = on_attach
	-- 			}
	-- 		});
	-- 	end
	-- });

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

	if packer_bootstrap then
		require('packer').sync();
	end
end

return require('packer').startup({
	startup,
	config = {
		auto_clean = true,
  		compile_on_sync = true,
		display = {
			open_fn = require('packer.util').float
		},
		profile = {
			enable = true,
			threshold = 1
		}
  	}
});
