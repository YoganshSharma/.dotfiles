local lsp = require('lsp-zero').preset({})
lsp.preset("recommended")
lsp.ensure_installed({
	-- Replace these with whatever servers you want to install
	'tsserver',
	'eslint',
	'rust_analyzer',
	'pylsp',
	'bashls',
	'cssls',
	'html',
	'lua_ls',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
	require('config.lsp.keys').setup(client,bufnr)
	  -- local opts = {buffer = bufnr, remap = false}
	  -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	  -- vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	  -- vim.keymap.set("n", "<leader>cws", function() vim.lsp.buf.workspace_symbol() end, opts)
	  -- vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.open_float() end, opts)
	  -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	  -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	  -- vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
	  -- vim.keymap.set("n", "<leader>crr", function() vim.lsp.buf.references() end, opts)
	  -- vim.keymap.set("n", "<leader>crn", function() vim.lsp.buf.rename() end, optu)
	  -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


lsp.skip_server_setup({'rust_analyzer'})
lsp.setup()
require("config.rust_tools")
require('go').setup()

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   print("start") 
   require('go.format').goimport()
   print("end") 
  end,
  group = format_sync_grp,
})
