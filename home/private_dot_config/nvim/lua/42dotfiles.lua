-- #############################################################################
-- ##  _  _ ___     _       _    __ _ _             _                          #
-- ## | || |__ \   | |     | |  / _(_) |           | |                         #
-- ## | || |_ ) |__| | ___ | |_| |_ _| | ___  ___  | |_   _  __ _              #
-- ## |__   _/ // _` |/ _ \| __|  _| | |/ _ \/ __| | | | | |/ _` |             #
-- ##    | |/ /| (_| | (_) | |_| | | | |  __/\__ \_| | |_| | (_| |             #
-- ##    |_|____\__,_|\___/ \__|_| |_|_|\___||___(_)_|\__,_|\__,_|             #
-- ##                                                                          #
-- #############################################################################

require('plugins');

vim.opt.belloff = 'all';
vim.opt.clipboard = 'unnamed';

vim.opt.tabstop = 4;
vim.opt.shiftwidth = 4;

vim.opt.signcolumn = 'yes';
vim.opt.cursorline = true;
vim.opt.number = true;
vim.opt.cc = '81';

vim.g.mapleader = " ";

-- switch between opt number absolute/hybrid in normal and insert mode
local numbertogglegroup = vim.api.nvim_create_augroup("numbertoggle", {});
vim.api.nvim_create_autocmd(
	{ "BufEnter", "FocusGained", "InsertLeave" },
	{
		pattern = '*',
		callback = function()
			vim.wo.relativenumber = true;
		end,
		group = numbertogglegroup
	}
);
vim.api.nvim_create_autocmd(
	{ "BufLeave", "FocusLost", "InsertEnter" },
	{
		pattern = '*',
		callback = function()
			vim.wo.relativenumber = false;
		end,
		group = numbertogglegroup
	}
);

-- #############################################################################
-- #############################################################################
-- #############################################################################
-- #############################################################################
-- #############################################################################

function safeload(plugin, callback)
	local status, value = pcall(require, plugin);
	if status then
		return callback(value);
	end
end

-- #############################################################################
-- ## sainnhe/everforest                                                       #
-- #############################################################################

if vim.fn.has('termguicolors') == 1 then
	vim.opt.termguicolors = true;
end

vim.opt.background = 'dark';
vim.g.everforest_background = 'soft';
vim.g.everforest_enable_italic = 0;
vim.g.everforest_disable_italic_comment = 1;

vim.g.everforest_better_performance = 1;

pcall(vim.cmd("colorscheme everforest"));

-- #############################################################################
-- ## nvim-lualine/lualine.nvim                                                #
-- #############################################################################


safeload('lualine', function(lualine)
	local options = {
		theme = 'everforest',
		section_separators = '',
		component_separators = '',
		globalstatus = true
	};
	lualine.setup({options = options});
end);

-- #############################################################################
-- ## romgrk/barbar.nvim                                                       #
-- #############################################################################

-- options
safeload("bufferline", function(bufferline)
	bufferline.setup({
		animation = false,
		auto_hide = false,
		closable = true,
		clickable = true,
		icons = true,
	});

	-- Move to previous/next
	vim.keymap.set('n', '<leader><left>', '<cmd>BufferPrevious<cr>');
	vim.keymap.set('n', '<leader><right>', '<cmd>BufferNext<cr>');
	vim.keymap.set('n', '<leader>w', '<cmd>BufferClose<cr>');
end);

-- #############################################################################
-- ## numToStr/Comment.nvim                                                    #
-- #############################################################################

safeload("Comment", function(Comment)
	Comment.setup({
		toggler = {
			---Line-comment toggle keymap
			line = '<leader>cc',
			---Block-comment toggle keymap
			block = '<leader>bc'
		},
		mappings = {
			basic = true,
			extra = false
		}
	});
end);

-- #############################################################################
-- ## lukas-reineke/indent-blankline.nvim                                      #
-- #############################################################################

safeload("indent_blankline", function(indent_blankline)
	indent_blankline.setup({
		-- for example, context is off by default, use this to turn it on
		show_current_context = true,
		show_current_context_start = true,
	});
end);

-- #############################################################################
-- ## ibhagwan/fzf-lua                                                         #
-- #############################################################################

safeload("fzf-lua", function()
	vim.keymap.set('n', '<leader>p', "<cmd>lua require('fzf-lua').files()<cr>");
	vim.keymap.set('n', '<leader>P', "<cmd>lua require('fzf-lua').commands()<cr>");
	vim.keymap.set('v', '<leader>s', "<cmd>lua require('fzf-lua').grep_visual()<cr>");
	vim.keymap.set('n', '<leader>d', "<cmd>lua require('fzf-lua').grep_cword()<cr>");
	vim.keymap.set('n', '<leader>S', "<cmd>lua require('fzf-lua').git_status()<cr>");
end);

-- #############################################################################
-- ## nvim-treesitter/nvim-treesitter                                          #
-- #############################################################################

safeload("nvim-treesitter.configs", function(treesitter)
	treesitter.setup({
		ensure_installed = { "c", "lua", "bash", "fish", "python"},
		sync_install = true,
		auto_install = true,
		additional_vim_regex_highlighting = false,
		highlight = { enable = true }
	});
end);

-- #############################################################################
-- ## hrsh7th/nvim-cmp                                                         #
-- #############################################################################

safeload("cmp", function(cmp)
	cmp.setup({
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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

	-- Set configuration for specific filetype.
	cmp.setup.filetype('lua', {
		sources = cmp.config.sources({
			{ name = 'buffer' },
			{ name = 'nvim_lua'}
		})
	});

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	});

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' },
			{ name = 'cmdline' }
		})
	});
end);

-- #############################################################################
-- ## neovim/nvim-lspconfig                                                    #
-- #############################################################################

local on_attach = safeload("cmp_nvim_lsp", function(cmp_nvim_lsp)
	local capabilities = cmp_nvim_lsp.default_capabilities();

	local opts = { noremap=true, silent=true };
	vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts);

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	return function(client, bufnr)
	  -- Enable completion triggered by <c-x><c-o>
	  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc');

	  -- Mappings.
	  -- See `:help vim.lsp.*` for documentation on any of the below functions
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
end);

-- #############################################################################
-- ## p00f/clangd_extensions.nvim                                              #
-- #############################################################################

safeload("clangd_extensions", function(clangd_extensions)
	clangd_extensions.setup({
		server = {
			capabilities = capabilities,
			on_attach = on_attach
		}
	});
end);

-- #############################################################################
-- ## williamboman/mason.nvim                                                  #
-- #############################################################################

safeload("mason", function(mason)
	require("mason").setup();
end);

