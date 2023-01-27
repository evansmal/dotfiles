require'nvim-treesitter.configs'.setup {
	ensure_installed = { "lua", "vim", "help", "javascript", "typescript", "cpp" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
}
