local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local tools = {
	"basedpyright",
	"beautysh",
	"djlint",
	"codelldb",
	"clangd",
	"clang-format",
	"css-lsp",
	"eslint-lsp",
	"eslint_d",
	"flake8",
	"html-lsp",
	"lua-language-server",
	"luacheck",
	"prettier",
	"prettierd",
	"ruff",
	"stylua",
	"shfmt",
	"shellcheck",
	"taplo",
	"typescript-language-server",
	"tree-sitter-cli",
	"yamlfmt",
}

-- Mason builds asm-lsp from source, so only request it when Rust is available.
-- Assembly parsing and debugging still work without this optional language server.
if vim.fn.executable("cargo") == 1 then
	table.insert(tools, "asm-lsp")
end

mason.setup({})

local is_win = vim.loop.os_uname().sysname == "Windows_NT"
if is_win then
	return
end

local mr = require("mason-registry")

local function ensure_installed()
	for _, tool in ipairs(tools) do
		local tool_name = tool
		if mr.has_package(tool_name) then
			local p = mr.get_package(tool_name)
			local available_on_path = tool_name == "tree-sitter-cli" and vim.fn.executable("tree-sitter") == 1
			if not p:is_installed() and not available_on_path then
				vim.notify("Mason: Installing " .. tool_name .. "...", vim.log.levels.INFO)
				p:install():once("closed", function()
					if p:is_installed() then
						vim.notify("Mason: Successfully installed " .. tool_name, vim.log.levels.INFO)
						if tool_name == "tree-sitter-cli" then
							vim.api.nvim_exec_autocmds("User", { pattern = "MasonTreeSitterReady" })
						end
					else
						vim.notify("Mason: Failed to install " .. tool_name, vim.log.levels.ERROR)
					end
				end)
			end
		else
			vim.notify("Mason: Package '" .. tool_name .. "' not found", vim.log.levels.WARN)
		end
	end
end

if mr.refresh then
	mr.refresh(ensure_installed)
else
	ensure_installed()
end
