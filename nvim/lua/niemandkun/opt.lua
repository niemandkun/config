-- Neovim config file

local gui_running = vim.fn.has('gui_running') == 1
local vscode = vim.fn.exists('vscode') == 1

-- Default settings
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- Disable menu item and separator
vim.cmd('aunmenu PopUp.How-to\\ disable\\ mouse')
vim.cmd('aunmenu PopUp.-2-')

-- Attempt to set terminal window title
vim.opt.title = true
vim.opt.titlestring = 'Neovim'

-- Colorscheme
vim.cmd.colorscheme('onedark')
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- Gui font
if gui_running then
    vim.o.guifont = 'Cascadia Mono:h10'
    vim.o.linespace = 3
end

-- Use system clipboard for yank and paste
vim.opt.clipboard = 'unnamedplus'

-- Disable mouse
vim.opt.mouse = 'a'

-- Disable beeping and blinking
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Editor settings
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'no'
vim.opt.foldcolumn = '0'
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.number = true

-- Show whitespaces
vim.opt.list = true
vim.opt.listchars = { tab = '> ', trail = '~', extends = '>', precedes = '<', space = '.', nbsp = '_' }

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = false
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Confirm exit if there is unsaved files
vim.opt.confirm = true

-- Indentation settings
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- By default, use tabs characters.
vim.opt.expandtab = false

-- Linebreak setting
vim.opt.iskeyword = { '@', '48-57', '_', '192-255' }
vim.opt.wrap = false
vim.opt.display = 'lastline'
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0

-- Autocomplete
vim.opt.completeopt = { 'fuzzy', 'menuone', 'popup' }
vim.opt.complete = { '.', 'w', 'b', 'u', 'i' }

-- Statusline
if vscode then
    vim.opt.showmode = true
    vim.opt.laststatus = 0
else
    vim.opt.showmode = false
    vim.opt.laststatus = 3
end

-- Wildmenu
vim.opt.path:append('**')
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.wildmode = { 'lastused:full' }
vim.opt.wildoptions = { 'pum' }
vim.opt.wildcharm = 9  -- '<Tab>'

-- Float
vim.opt.winborder = "solid"

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 50
