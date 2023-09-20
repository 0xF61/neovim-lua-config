for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config')..'/lua/config', [[v:val =~ '\.lua$']])) do
	if file ~= "init.lua" then
		require('config.'..file:gsub('%.lua$', ''))
	end
end

require('neodev').setup()

