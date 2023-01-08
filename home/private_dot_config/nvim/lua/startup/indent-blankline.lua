return(function(use)

use({
	'lukas-reineke/indent-blankline.nvim',
	opt = true,
	event = 'VimEnter',
	config = function()
		require('indent_blankline').setup({
			show_current_context = true, 
			show_current_context_start = true
		});
	end
});

end);
