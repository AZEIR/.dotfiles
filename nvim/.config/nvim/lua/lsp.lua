vim.lsp.enable({
	"asm_lsp",
	"basedpyright",
	"clangd",
	"cssls",
	"html",
	"lua_ls",
	"ts_ls",
})

-- <C-w-d> for diagnostic

-- Enable native auto-completion as you type
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Enable native LSP autocompletion",
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		-- Check if the attached server supports completion before enabling it
		if client and client:supports_method("textDocument/completion") then
			-- Just enable it for the buffer; the global option handles the trigger now
			vim.lsp.completion.enable(true, client.id, args.buf)
		end
	end,
})

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
})
