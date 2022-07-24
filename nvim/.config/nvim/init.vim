source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/general/plugins.vim
" source $HOME/.config/nvim/themes/airline.vim
source $HOME/.config/nvim/keys/commentary.vim
luafile $HOME/.config/nvim/keys/barbar.lua
" luafile $HOME/.config/nvim/lua/barbar.lua
luafile $HOME/.config/nvim/lua/plug-colorizer.lua
luafile $HOME/.config/nvim/lua/lsp.lua
luafile $HOME/.config/nvim/lua/tabnine.lua
source $HOME/.config/nvim/keys/lspkeys.vim
luafile $HOME/.config/nvim/lua/telescope_config.lua
luafile $HOME/.config/nvim/lua/cmp_config.lua
source $HOME/.config/nvim/keys/vimwiki.vim
source $HOME/.config/nvim/plug-config/which-key.vim
source $HOME/.config/nvim/plug-config/startify.vim
source $HOME/.config/nvim/plug-config/nerdtree.vim

set background=dark " or light if you wanna torcher yourself 
colorscheme gruvbox
