-- ---------------------------------------------------------------------------
-- UTILS & LEADERS
-- ---------------------------------------------------------------------------

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Helper function to simplify keymap creation
function Map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- ---------------------------------------------------------------------------
-- NAVIGATION & WINDOWS
-- ---------------------------------------------------------------------------

-- Vertical scroll and center cursor
Map("n", "<C-d>", "<C-d>zz")
Map("n", "<C-u>", "<C-u>zz")

-- Search and center cursor (zv opens folds)
Map("n", "n", "nzzzv")
Map("n", "N", "Nzzzv")

-- Better window navigation (Ctrl + hjkl)
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")

-- Resize windows with arrows (Normal & Terminal modes)
Map("n", "<C-Up>", ":resize -2<CR>")
Map("n", "<C-Down>", ":resize +2<CR>")
Map("n", "<C-Left>", ":vertical resize -2<CR>")
Map("n", "<C-Right>", ":vertical resize +2<CR>")

Map("t", "<C-Up>", "<cmd>resize -2<CR>")
Map("t", "<C-Down>", "<cmd>resize +2<CR>")
Map("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
Map("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- ---------------------------------------------------------------------------
-- EDITING & VISUAL MODE
-- ---------------------------------------------------------------------------

-- Move blocks of code up/down
Map("v", "J", ":m '>+1<CR>gv=gv")
Map("v", "K", ":m '<-2<CR>gv=gv")

-- Stay in visual mode while indenting
Map("v", "<", "<gv")
Map("v", ">", ">gv")

-- ---------------------------------------------------------------------------
-- BUFFERS & TABS
-- ---------------------------------------------------------------------------

Map("n", "<TAB>", ":bn<CR>") -- Next buffer
Map("n", "<S-TAB>", ":bp<CR>") -- Previous buffer
Map("n", "<leader>bx", ":bd<CR>", { desc = "Close buffer" })

-- -----------------------------------------------------------------------------
-- --- PLUGIN: FZF-LUA ---
-- -----------------------------------------------------------------------------

Map("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Fzf: Find Files" })
Map("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "Fzf: Buffers" })
Map("n", "<leader>fc", function()
	require("fzf-lua").colorschemes()
end, { desc = "Fzf: Colorschemes" })
Map("n", "<leader>f/", function()
	require("fzf-lua").blines()
end, { desc = "Fzf: Current Buffer (blines)" })
Map("n", "<leader>fg", function()
	require("fzf-lua").live_grep({
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden -e",
	})
end, { desc = "Fzf: Live Grep" })

-- ---------------------------------------------------------------------------
-- PLUGIN: OIL & CONFORM
-- ---------------------------------------------------------------------------

-- Oil (File Explorer)
Map("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory in float" })

-- Conform (Formatting)
Map("n", "<leader>cf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format current buffer" })

-- ---------------------------------------------------------------------------
-- BUILD & QUICKFIX
-- ---------------------------------------------------------------------------

Map("n", "<leader>cm", function()
	vim.cmd("silent make!")
	if #vim.fn.getqflist() > 0 then
		vim.cmd("cwindow")
	end
end, { desc = "Build project (:make)" })
Map("n", "<leader>cq", "<cmd>copen<CR>", { desc = "Open build errors" })
Map("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "Next build error" })
Map("n", "<leader>cp", "<cmd>cprevious<CR>", { desc = "Previous build error" })
