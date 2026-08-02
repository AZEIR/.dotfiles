-- ---------------------------------------------------------------------------
-- UI & VISUALS
-- ---------------------------------------------------------------------------

-- Line Numbers
vim.o.number = true -- Show absolute line number
vim.o.relativenumber = true -- Show relative numbers (easier for jumps)
vim.o.numberwidth = 4 -- Width of the gutter
vim.o.signcolumn = "yes" -- Always show the sign column (prevents jumping)
vim.o.statuscolumn = "%l %s" -- Custom gutter layout (number + signs)

-- Colors & Cursor
vim.o.termguicolors = true -- Enable 24-bit RGB colors
vim.o.cursorline = true -- Highlight the current line
vim.o.cursorlineopt = "number" -- Only highlight the number part of the line
vim.opt.fillchars = { eob = " " } -- Hide the '~' characters at the end of buffer

-- ---------------------------------------------------------------------------
-- EDITOR BEHAVIOR
-- ---------------------------------------------------------------------------

-- Whitespace & Indentation
vim.o.tabstop = 4 -- Number of spaces a Tab counts for
vim.o.shiftwidth = 4 -- Number of spaces for auto-indents
vim.o.softtabstop = 4 -- Tab/BS behavior when editing
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.showtabline = 1 -- Show tab bar only if there are at least two

-- General Logic
vim.o.wrap = false -- Don't wrap long lines
vim.o.swapfile = false -- Don't use swapfiles
vim.o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

-- ---------------------------------------------------------------------------
-- COMPLETION & POP-UP MENU
-- ---------------------------------------------------------------------------

vim.o.autocomplete = true
vim.o.pumheight = 10 -- Max height of the completion menu
vim.o.completeopt = "menuone,noselect,fuzzy" -- Completion menu behavior
vim.opt.complete:append("o") -- Include omni-completion in the list

-- ---------------------------------------------------------------------------
-- DISABLED BUILT-INS
-- ---------------------------------------------------------------------------

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
