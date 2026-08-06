local function safe_setup(module, config)
	local status, plugin = pcall(require, module)
	if status then
		plugin.setup(config)
	end
end

-- ---------------------------------------------------------------------------
-- THEMES
-- ---------------------------------------------------------------------------

vim.cmd.colorscheme("oxocarbon")
safe_setup("lualine", {
	-- options = { theme = "rose-pine", globalstatus = true },
	-- options = { theme = "rose-pine" },
})

-- ---------------------------------------------------------------------------
-- EDITOR TOOLS
-- ---------------------------------------------------------------------------

-- Oil
safe_setup("oil", {
	default_file_explorer = true,
	view_options = {
		show_hidden = true,
	},
	columns = {
		"icon",
	},
	float = {
		-- Padding around the floating window
		padding = 5,
		-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		max_width = 0,
		max_height = 0,
		border = "rounded", -- Options: "rounded", "single", "double", "solid"
		win_options = {
			winblend = 0,
		},
		-- optionally override the oil buffers window title with custom function: fun(winid: integer): string
		get_win_title = nil,
		-- preview_split: Split direction: "auto", "left", "right", "above", "below".
		preview_split = "auto",
		-- This is the config that will be passed to nvim_open_win.
		-- Change values here to customize the layout
		override = function(conf)
			return conf
		end,
	},
	keymaps = {
		["<ESC>"] = "actions.close",
	},
})

-- FZF
safe_setup("fzf-lua", {})

-- Autopairs
safe_setup("nvim-autopairs", {})

-- ---------------------------------------------------------------------------
-- Syntax Highlighting
-- ---------------------------------------------------------------------------

-- Treesitter (current Neovim 0.12 API)
local treesitter_ok, treesitter = pcall(require, "nvim-treesitter")
if treesitter_ok then
	local parsers = {
		"asm",
		"c",
		"cpp",
		"lua",
		"vim",
		"vimdoc",
		"markdown",
		"markdown_inline",
		"python",
		"html",
		"css",
		"javascript",
		"typescript",
		"tsx",
	}

	treesitter.setup({})

	local function has_c_compiler()
		return vim.fn.executable("cc") == 1 or vim.fn.executable("gcc") == 1 or vim.fn.executable("clang") == 1
	end

	local function install_parsers()
		if not has_c_compiler() then
			vim.notify(
				"Tree-sitter parsers need a C compiler; install build-essential (Ubuntu/Debian)",
				vim.log.levels.WARN
			)
			return
		end
		treesitter.install(parsers)
	end

	if vim.fn.executable("tree-sitter") == 1 then
		install_parsers()
	else
		vim.notify("Tree-sitter CLI is not available yet; Mason is installing it", vim.log.levels.INFO)
		vim.api.nvim_create_autocmd("User", {
			desc = "Install parsers after Mason installs the Tree-sitter CLI",
			pattern = "MasonTreeSitterReady",
			once = true,
			callback = install_parsers,
		})
	end

	vim.api.nvim_create_autocmd("FileType", {
		desc = "Enable Tree-sitter highlighting",
		pattern = {
			"asm",
			"c",
			"cpp",
			"lua",
			"vim",
			"vimdoc",
			"markdown",
			"python",
			"html",
			"css",
			"javascript",
			"typescript",
			"typescriptreact",
		},
		callback = function()
			pcall(vim.treesitter.start)
		end,
	})
end

-- ---------------------------------------------------------------------------
-- Formatting
-- ---------------------------------------------------------------------------

-- Conform
safe_setup("conform", {
	-- Define your formatters per filetype
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		javascriptreact = { "prettierd", "prettier", stop_after_first = true },
		typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },
		python = { "ruff_format" }, -- Assuming ruff for Python formatting
		c = { "clang-format" },
		cpp = { "clang-format" },
		sh = { "shfmt" },
		yaml = { "prettier" },
		json = { "prettierd", "prettier", stop_after_first = true },
	},
	-- Optional: Set up format-on-save
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
