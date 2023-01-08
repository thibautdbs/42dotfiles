return(function(use)

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

end);
