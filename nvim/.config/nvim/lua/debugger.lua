local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")

if not dap_ok or not dapui_ok then
	return
end

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}

local function executable()
	return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
end

local function arguments()
	local input = vim.fn.input("Arguments: ")
	if input == "" then
		return {}
	end
	return vim.split(input, " ", { trimempty = true })
end

local launch = {
	name = "Launch executable",
	type = "codelldb",
	request = "launch",
	program = executable,
	args = arguments,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	initCommands = {
		"settings set target.x86-disassembly-flavor intel",
	},
}

local attach = {
	name = "Attach to process",
	type = "codelldb",
	request = "attach",
	pid = require("dap.utils").pick_process,
	cwd = "${workspaceFolder}",
}

dap.configurations.c = { launch, attach }
dap.configurations.cpp = dap.configurations.c
dap.configurations.asm = dap.configurations.c

dapui.setup({
	controls = {
		enabled = true,
	},
	icons = {
		collapsed = "▸",
		current_frame = "▸",
		expanded = "▾",
	},
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.40 },
				{ id = "stacks", size = 0.25 },
				{ id = "breakpoints", size = 0.20 },
				{ id = "watches", size = 0.15 },
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{ id = "repl", size = 0.60 },
				{ id = "console", size = 0.40 },
			},
			position = "bottom",
			size = 12,
		},
	},
})

local virtual_text_ok, virtual_text = pcall(require, "nvim-dap-virtual-text")
if virtual_text_ok then
	virtual_text.setup({
		commented = true,
		clear_on_continue = true,
	})
end

dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("n", "<F5>", dap.continue, "Debug: start/continue")
map("n", "<F10>", dap.step_over, "Debug: step over")
map("n", "<F11>", dap.step_into, "Debug: step into")
map("n", "<F12>", dap.step_out, "Debug: step out")
map("n", "<leader>db", dap.toggle_breakpoint, "Debug: toggle breakpoint")
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Debug: conditional breakpoint")
map("n", "<leader>dc", dap.continue, "Debug: start/continue")
map("n", "<leader>dl", dap.run_last, "Debug: run last")
map("n", "<leader>dp", dap.pause, "Debug: pause")
map("n", "<leader>dr", dap.repl.open, "Debug: open REPL")
map("n", "<leader>dt", dap.terminate, "Debug: terminate")
map("n", "<leader>du", dapui.toggle, "Debug: toggle UI")
map({ "n", "v" }, "<leader>de", dapui.eval, "Debug: evaluate expression")
