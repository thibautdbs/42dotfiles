return(function(use)

use({
	'romgrk/barbar.nvim',
	requires = 'nvim-tree/nvim-web-devicons',
	config = function()
		require('bufferline').setup({
			animation = false,
			auto_hide = false,
			closable = true,
			clickable = true,
			icons = true
		});
		vim.keymap.set('n', '<leader><left>', '<cmd>BufferPrevious<cr>');
		vim.keymap.set('n', '<leader><right>', '<cmd>BufferNext<cr>');
		vim.keymap.set('n', '<leader>w', '<cmd>BufferClose<cr>');
	end
});

end);
