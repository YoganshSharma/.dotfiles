lua << EOF
vim.lsp.diagnostic.virtual_text = false
EOF
nnoremap <silent>gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent>K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent><C-k> :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent><space>wa :lua vim.lsp.buf.add_workspace_folder()<CR>
nnoremap <silent><space>wr :lua vim.lsp.buf.remove_workspace_folder()<CR>
nnoremap <silent><space>wl :lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
nnoremap <silent><space>D :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent><space>cr :lua vim.lsp.buf.rename()<CR>
nnoremap <silent><space>ca :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent><space>cq :lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent>gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent><space>e :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
" nnoremap <silent>[d :lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent>]d :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent><space>q :lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent><space>f :lua vim.lsp.buf.formatting()<CR>
nnoremap <silent><space>j :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent><space>k :lua vim.lsp.diagnostic.goto_prev()<CR>

