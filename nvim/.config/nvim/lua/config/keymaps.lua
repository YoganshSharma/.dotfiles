-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<TAB>", "<cmd>bnext<cr>")
vim.keymap.set("n", "<S-TAB>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<leader>bf", function()
  vim.b.autoformat = not vim.b.autoformat
  print(vim.b.autoformat and "Formatting on Save Enabled" or "Formatting on Save Disabled")
end, { desc = "Toggle autoformat" })
