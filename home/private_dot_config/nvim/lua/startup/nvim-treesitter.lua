return(function(use)

use({
	'nvim-treesitter/nvim-treesitter',
	run = ':TSUpdateSync',
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "lua", "bash", "python"},
			sync_install = true,
			auto_install = true,
			additional_vim_regex_highlighting = false,
			highlight = { enable = true }
		});
	end
});

end);
