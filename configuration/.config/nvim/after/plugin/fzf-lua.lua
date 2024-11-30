local fzf_lua = require("fzf-lua")

search_current_buffer_directory = function(opts)
  opts = opts or {}
  
  local current_buffer_path = vim.api.nvim_buf_get_name(0)
  local current_buffer_directory = vim.fn.fnamemodify(current_buffer_path, ":h")
  
  if current_buffer_directory == "" then
    print("Error: Current buffer is not associated with a file.")
    return
  end

  opts.prompt = "Files in " .. current_buffer_directory .. "> "
  opts.cwd = current_buffer_directory
  opts.actions = fzf_lua.defaults.actions.files

  fzf_lua.fzf_exec("ls", opts)
end


vim.keymap.set("n", "<leader>p", fzf_lua.git_files, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>hp", fzf_lua.oldfiles, { desc = "Fzf Files" })
vim.keymap.set('n', '<leader>dp', search_current_buffer_directory, { noremap = true, silent = false })

vim.keymap.set("n", "<leader>b", fzf_lua.buffers, { desc = "Fzf Buffers" })
vim.keymap.set("n", "<leader>f", fzf_lua.live_grep, { desc = "Fzf Grep" })

vim.keymap.set("n", "<leader>cj", fzf_lua.lsp_definitions, { desc = "Jump to Definition" })

vim.keymap.set("n", "<leader>gs", fzf_lua.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gc", fzf_lua.git_bcommits, { desc = "Browse File Commits" })



