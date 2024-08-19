vim.keymap.set("n", "<leader>p", require('fzf-lua').files, { desc = "Fzf Files" })
km.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "Fzf Buffers" })
vim.keymap.set("n", "<leader>f", require("fzf-lua").live_grep, { desc = "Fzf Grep" })

vim.keymap.set("n", "<leader>cj", require("fzf-lua").lsp_definitions, { desc = "Jump to Definition" })

vim.keymap.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gc", require("fzf-lua").git_bcommits, { desc = "Browse File Commits" })

