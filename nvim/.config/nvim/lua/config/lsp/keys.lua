local wk = require("which-key")
local util = require("util")

local M = {}

function M.setup(client, bufnr)
	-- Mappings.
	local opts = { noremap = true, silent = true, buffer = bufnr }

	local keymap = {
		c = {
			name = "+code",
			r = {
				function()
					vim.lsp.buf.rename()
					-- require("inc_rename").rename({ default = vim.fn.expand("<cword>") })
				end,
				"Rename",
			},
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },

			f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format Document" },
			l = {
				name = "+lsp",
				i = { "<cmd>LspInfo<cr>", "Lsp Info" },
				a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Folder" },
				r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Folder" },
				l = {
					"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
					"List Folders",
				},
			},
		},
		x = {
			d = { "<cmd>Telescope diagnostics<cr>", "Search Diagnostics" },
		},
	}

	-- if not client.server_capabilities.renameProvider then
	-- 	keymap.c.r = nil
	-- end

	if client.name == "tsserver" then
		keymap.c.o = { "<cmd>:TypescriptOrganizeImports<CR>", "Organize Imports" }
		keymap.c.R = { "<cmd>:TypescriptRenameFile<CR>", "Rename File" }
	end

	local keymap_visual = {
		c = {
			name = "+code",
			a = { ":<C-U>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" },
			f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format Range" },
		},
	}

	local keymap_goto = {
		name = "+goto",
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
		r = { "<cmd>Telescope lsp_references<cr>", "References" },
		R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
		I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
		t = { "<cmd>Telescope lsp_type_definitions<cr>", "Goto Type Definition" },
	}

    print("CLIENT:",client.name)
	util.nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	util.nnoremap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	util.nnoremap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	util.nnoremap("[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
	util.nnoremap("]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
	util.nnoremap("[w", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARNING})<CR>", opts)
	util.nnoremap("]w", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARNING})<CR>", opts)
	util.inoremap("<C-l>", function() vim.lsp.buf.signature_help() end, opts)

	local trigger_chars = client.server_capabilities.signatureHelpTriggerCharacters
	trigger_chars = { "," }
	for _, c in ipairs(trigger_chars) do
		util.inoremap(c, function()
			vim.defer_fn(function()
				pcall(vim.lsp.buf.signature_help)
			end, 0)
			return c
		end, {
			noremap = true,
			silent = true,
			buffer = bufnr,
			expr = true,
		})
	end

	-- Set some keybinds conditional on server capabilities
	-- if client.server_capabilities.documentFormatting then
	-- 	keymap.c.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
	-- elseif client.server_capabilities.documentRangeFormatting then
	-- 	keymap_visual.c.f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format Range" }
	-- end

	wk.register(keymap, { buffer = bufnr, prefix = "<leader>" })
	wk.register(keymap_visual, { buffer = bufnr, prefix = "<leader>", mode = "v" })
	wk.register(keymap_goto, { buffer = bufnr, prefix = "g" })
end

return M
