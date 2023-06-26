local util = require("util")

local M = {}

-- vim.lsp.handlers["textDocument/hover"] = function(_, method, result)
--   print(vim.inspect(result))
-- end

M.autoformat = false

function M.toggle()
	M.autoformat = not M.autoformat
	if M.autoformat then
		util.info("enabled format on save", "Formatting")
	else
		util.warn("disabled format on save", "Formatting")
	end
end

function M.format(client, buf)
	if M.autoformat then
		vim.lsp.buf.format()
	end
end

function M.setup(client, buf)
	local ft = vim.api.nvim_buf_get_option(buf, "filetype")
	local nls = require("config.lsp.null-ls")

	local enable = false
	if nls.has_formatter(ft) then
		enable = client.name == "null-ls"
	else
		enable = not (client.name == "null-ls")
	end

	if client.name == "tsserver" then
		enable = false
	end

	-- util.info(client.name .. " " .. (enable and "yes" or "no"), "format")

	client.server_capabilities.documentFormattingProvider = enable
	-- format on save
	if client.server_capabilities.documentFormattingProvider then
		vim.cmd([[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("config.lsp.formatting").format(client, buf)
      augroup END
    ]])
	end
end

return M
