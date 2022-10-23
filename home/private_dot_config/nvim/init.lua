-- #############################################################################
-- ##  _       _ _     _                                                       #
-- ## (_)     (_) |   | |                                                      #
-- ##  _ _ __  _| |_  | |_   _  __ _                                           #
-- ## | | '_ \| | __| | | | | |/ _` |                                          #
-- ## | | | | | | |_ _| | |_| | (_| |                                          #
-- ## |_|_| |_|_|\__(_)_|\__,_|\__,_|                                          #
-- ##                                                                          #
-- #############################################################################

require("plugins");

vim.opt.belloff = 'all';

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
vim.cmd("colorscheme everforest");

-- #############################################################################
-- ## nvim-lualine/lualine.nvim                                                #
-- #############################################################################

options = {
	theme = everforest,
	section_separators = '', 
	component_separators = '',
	globalstatus = true
};

require('lualine').setup({options = options});

-- #############################################################################
-- ## romgrk/barbar.nvim                                                       #
-- #############################################################################

-- options
require('bufferline').setup({
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

-- #############################################################################
-- ## numToStr/Comment.nvim                                                    #
-- #############################################################################

require('Comment').setup({
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

require("indent_blankline").setup({
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
});

-- #############################################################################
-- ## ibhagwan/fzf-lua                                                         #
-- #############################################################################

vim.keymap.set('n', '<leader>p', "<cmd>lua require('fzf-lua').files()<cr>");
vim.keymap.set('n', '<leader>P', "<cmd>lua require('fzf-lua').commands()<cr>");
vim.keymap.set('v', '<leader>s', "<cmd>lua require('fzf-lua').grep_visual()<cr>");
vim.keymap.set('n', '<leader>d', "<cmd>lua require('fzf-lua').grep_cword()<cr>");
vim.keymap.set('n', '<leader>S', "<cmd>lua require('fzf-lua').git_status()<cr>");

-- #############################################################################
-- ## nvim-treesitter/nvim-treesitter                                          #
-- #############################################################################

require('nvim-treesitter.configs').setup({
	ensure_installed = { "c", "lua", "bash", "fish", "python"},
	sync_install = true,
	auto_install = true,
	additional_vim_regex_highlighting = false,
	highlight = { enable = true }
});

-- #############################################################################
-- ## hrsh7th/nvim-cmp                                                         #
-- #############################################################################

local cmp = require('cmp');

cmp.setup({
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

-- #############################################################################
-- ## neovim/nvim-lspconfig                                                    #
-- #############################################################################

local capabilities = require('cmp_nvim_lsp').default_capabilities();

-- #############################################################################
-- ## p00f/clangd_extensions.nvim                                              #
-- #############################################################################

require('clangd_extensions').setup({
	server = {
		capabilities = capabilities
	}
});

-- #############################################################################
-- ## williamboman/mason.nvim                                                  #
-- #############################################################################

require("mason").setup();
