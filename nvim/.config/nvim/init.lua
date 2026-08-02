vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.vscode then
	-- Vscode
else
	-- Plugin must first load
	require("plugins")
	-- Mason second
	require("mason_init")
	-- The rest
	require("configs")
	require("lsp")
	require("plugin-configs")
	require("keymaps")
end
