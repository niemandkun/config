vim.lsp.config['luals'] = {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
}

vim.lsp.config['clangd'] = {
	cmd = { 'clangd', '--background-index' },
	filetypes = { 'c', 'cpp' },
	root_markers = { '.clangd', '.clang-format', 'compile_commands.json', '.git/' },
}

vim.lsp.config['csharp-ls'] = {
	cmd = { 'csharp-ls' },
	cmd_env = { FrameworkPathOverride = '/usr/lib/mono/4.7.2-api/' },
	filetypes = { 'cs' },
	root_markers = { '*.csproj' },
}

vim.lsp.config['rust-analyzer'] = {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { { 'rust-project.json', 'Cargo.toml' }, '.git' },
}

local vscode = vim.fn.exists('vscode') == 1
local show_signcolumn = false

if not vscode then
	if show_signcolumn then
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function()
				vim.o.signcolumn = 'yes'
			end,
		})
	end

	vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
		callback = function()
			vim.lsp.buf.document_highlight()
		end,
	})

	vim.api.nvim_create_autocmd('CursorMoved', {
		callback = function()
			vim.lsp.buf.clear_references()
		end,
	})

	vim.lsp.enable('luals')
	vim.lsp.enable('clangd')
	vim.lsp.enable('csharp-ls')
	vim.lsp.enable('rust-analyzer')
end
