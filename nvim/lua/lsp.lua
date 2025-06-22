vim.lsp.config['luals'] = {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
}

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		vim.o.signcolumn = 'yes'
	end,
})

vim.lsp.enable('luals')
