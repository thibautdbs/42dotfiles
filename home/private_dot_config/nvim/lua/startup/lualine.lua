return(function(use)

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

end);
