return(function(use)

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

end);
