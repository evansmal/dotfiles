-- Set leader
vim.g.mapleader = " "

-- Paste into highlighted text without changing register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank into system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- Shorcut for formatting
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

