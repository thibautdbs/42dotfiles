--------------------------------------------------------------------------------
--- INSTALL PACKER

(function ()
	local url = 'https://github.com/wbthomason/packer.nvim';
	local path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim';
	if (vim.fn.empty(vim.fn.glob(path)) > 0) then
		vim.fn.system({'git', 'clone', '--depth', '1', url, path});
		vim.cmd('packadd packer.nvim');
	end
end)();

--------------------------------------------------------------------------------
--- CONFIGURE PACKER

local function startup(use)
	-- mandatory plugins
	use('wbthomason/packer.nvim');
	use('lewis6991/impatient.nvim');

	-- autoload plugins in lua/startup/*.lua
	local path = vim.fn.stdpath('config')..'/lua';
	local files = path..'/startup/*.lua';

	for i, file in pairs(vim.split(vim.fn.glob(files), "\n")) do
		local module = file:gsub('^'..path..'/', ""):gsub('%.lua$', '');
		if (module ~= 'startup/init') then
			require(module)(use);
		end
	end
end

require('packer').startup(startup);
require('packer').sync();
