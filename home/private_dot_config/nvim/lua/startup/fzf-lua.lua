return(function(use)

use({
	'ibhagwan/fzf-lua',
	requires = { 'kyazdani42/nvim-web-devicons' },
	opt = true,
	keys = {
		{'n', '<leader>p'},
		{'n', '<leader>P'},
		{'v', '<leader>s'},
		{'n', '<leader>d'},
		{'n', '<leader>S'}
	},
	config = function()
		local cmd = "<cmd>lua require('fzf-lua')";
		vim.keymap.set('n', '<leader>p', cmd .. ".files()<cr>");
		vim.keymap.set('n', '<leader>P', cmd .. ".commands()<cr>");
		vim.keymap.set('v', '<leader>s', cmd .. ".grep_visual()<cr>");
		vim.keymap.set('n', '<leader>d', cmd .. ".grep_cword()<cr>");
		vim.keymap.set('n', '<leader>S', cmd .. ".git_status()<cr>");
	end
});

end);
