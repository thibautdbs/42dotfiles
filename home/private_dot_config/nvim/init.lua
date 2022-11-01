-- #############################################################################
-- ##  _       _ _     _                                                       #
-- ## (_)     (_) |   | |                                                      #
-- ##  _ _ __  _| |_  | |_   _  __ _                                           #
-- ## | | '_ \| | __| | | | | |/ _` |                                          #
-- ## | | | | | | |_ _| | |_| | (_| |                                          #
-- ## |_|_| |_|_|\__(_)_|\__,_|\__,_|                                          #
-- ##                                                                          #
-- #############################################################################

require('impatient');

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
