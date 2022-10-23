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

local ensure_packer = function()
	local fn = vim.fn;
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim';
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path});
		vim.cmd("packadd packer.nvim");
		return true;
	end
	return false;
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
	function(use)
		use('wbthomason/packer.nvim');
		use('williamboman/mason.nvim');
		use('sainnhe/everforest');
		use('42Paris/42header');
		use({
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons' }
		});
		use {
			'romgrk/barbar.nvim',
			requires = { 'kyazdani42/nvim-web-devicons' }
		};
		use('numToStr/Comment.nvim');
		use('lukas-reineke/indent-blankline.nvim');
		use({ 'ibhagwan/fzf-lua',
			requires = { 'kyazdani42/nvim-web-devicons' }
		});
		use({
			'nvim-treesitter/nvim-treesitter',
			run = function() require('nvim-treesitter.install').update({ with_sync = true }); end,
		});
		use('neovim/nvim-lspconfig');
		use('p00f/clangd_extensions.nvim');
		use({
			'hrsh7th/nvim-cmp',
			requires = {
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-buffer',
				'hrsh7th/cmp-path',
				'hrsh7th/cmp-cmdline',
				'hrsh7th/cmp-nvim-lua'
			}
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require('packer').sync()
		end
	end,
	config = {
		display = {
			open_fn = require('packer.util').float,
		}
  	}
})
