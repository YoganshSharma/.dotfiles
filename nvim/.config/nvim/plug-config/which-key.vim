nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" After pressing leader the guide buffer will pop up when there are no further keystrokes within timeoutlen.
" By default timeoutlen is 1000 ms
" set timeoutlen=500


" Define prefix dictionary
let g:which_key_map =  {}

let g:which_key_map['o'] = {
      \ 'name' : '+open' ,
      \ }

let g:which_key_map['c'] = {
      \ 'name' : '+code' ,
      \ 'a' : [ ":lua vim.lsp.buf.code_action()", "Code Action" ],
      \ 'd' : [
          \":Telescope diagnostics",
          \"Document Diagnostics",
        \],
      \ 'w' : [
          \":Telescope lsp_workspace_diagnostics",
          \"Workspace Diagnostics",
        \],
      \ 'f' : [ ":lua vim.lsp.buf.formatting()", "Format" ],
      \ 'i' : [ ":LspInfo", "Info" ],
      \ 'j' : [
          \":lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})",
          \"Next Dignostic",
        \],
      \ 'k' : [
          \":lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})",
          \"Prev Diagnostic",
        \],
      \ 'p' : {
        \ 'name' : "+Peek",
        \ 'd' : [ ":lua require('lsp.peek').Peek('definition')", "Definition" ],
        \ 't' : [ ":lua require('lsp.peek').Peek('typeDefinition')", "Type Definition" ],
        \ 'i' : [ ":lua require('lsp.peek').Peek('implementation')", "Implementation" ],
        \},
      \ 'q' : [ ":lua vim.lsp.diagnostic.set_loclist()", "Quickfix" ],
      \ 'r' : [ ":lua vim.lsp.buf.rename()", "Rename" ],
      \ 's' : [ ":Telescope lsp_document_symbols", "Document Symbols" ],
      \ 'S' : [
          \":Telescope lsp_dynamic_workspace_symbols",
          \"Workspace Symbols",
        \],
      \}

let g:which_key_map['t'] = {
      \ 'name' : '+tree' ,
      \ 't' : [':NERDTreeToggle'     , 'toggle'],
      \ 'f' : [':NERDTreeFocus'     , 'focus'],
      \ 'c' : [':NERDTreeClose'     , 'close'],
      \ 'l' : 'VimWiki toggle list',
      \ }

let g:which_key_map['w'] = {
      \ 'name' : '+vimwiki' ,
      \ 'w' : 'VimWiki Index',
      \ }

let g:which_key_map['b'] = {
      \ 'name' : '+buffers' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ }



" s is for search/session
let g:which_key_map.s = {
      \ 'name' : '+search/session' ,
      \ 'b' : [':Telescope current_buffer_fuzzy_find'         , 'current buffer'],
      \ 'B' : [':Telescope buffers'                           , 'open buffers'],
      \ 'f' : [':Telescope find_files'                        , 'files'],
      \ 'g' : [':Telescope git_files'                         , 'git files'],
      \ 'r' : [':Telescope registers'                         , 'registers'],
      \ 'H' : [':Telescope command_history'                   , 'command history'],
      \ 'p' : [':Telescope help_tags'                         , 'help tags'] ,
      \ 'S' : [':Telescope colorscheme'                       , 'color schemes'],
      \ 't' : [':Telescope live_grep'                         , 'Live grep'],
      \ 'y' : [':Telescope filetypes'                         , 'file types'],
      \ 'z' : [':FZF'                                         , 'FZF'],
      \ }
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen' ]
let g:which_key_map['e'] = 'Show line Diagnostics'
let g:which_key_map['q'] = 'Quickfix'
" Register which key map
call which_key#register('<Space>', "g:which_key_map")
