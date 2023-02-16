require("no-clown-fiesta").setup({
  transparent = false, -- Enable this to disable the bg color
  styles = { 
    comments = {},
    keywords = {},
    functions = {fg = "#FFFFFF"},
    variables = {fg = "#FFFFFF"},
    type = { bold = true },
  },
})

function SetColor()
    vim.cmd [[ set background=dark ]]
    vim.cmd[[colorscheme no-clown-fiesta]]
end

SetColor()
