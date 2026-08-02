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
	"yamlfmt",
}

mason.setup({})

local is_win = vim.loop.os_uname().sysname == "Windows_NT"
if is_win then
	return
end

local mr = require("mason-registry")

local function ensure_installed()
	for _, tool in ipairs(tools) do
		if mr.has_package(tool) then
			local p = mr.get_package(tool)
			if not p:is_installed() then
				vim.notify("Mason: Installing " .. tool .. "...", vim.log.levels.INFO)
				p:install():once("closed", function()
					if p:is_installed() then
						vim.notify("Mason: Successfully installed " .. tool, vim.log.levels.INFO)
					else
						vim.notify("Mason: Failed to install " .. tool, vim.log.levels.ERROR)
					end
				end)
			end
		else
			vim.notify("Mason: Package '" .. tool .. "' not found", vim.log.levels.WARN)
		end
	end
end

if mr.refresh then
	mr.refresh(ensure_installed)
else
	ensure_installed()
end
