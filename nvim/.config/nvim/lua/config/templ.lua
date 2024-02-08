vim.filetype.add({
 extension = {
  templ = "templ",
 },
}
require("lspconfig").tailwindcss.setup({
  filetypes = {
    'templ'
    -- include any other filetypes where you need tailwindcss
  },
  init_options = {
    userLanguages = {
        templ = "html"
    }
  }
}))
