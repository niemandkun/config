-- Neovim config file

local vimrc = vim.api.nvim_create_augroup('vimrc', { clear = true })

-- Determines whether to use spaces or tabs on the current buffer.
local function detect_tabs()
    if vim.fn.getfsize(vim.fn.bufname("%")) > 256000 then
        return
    end

    local num_tabs = vim.fn.len(vim.fn.filter(vim.fn.getbufline(vim.fn.bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
    local num_spaces = vim.fn.len(vim.fn.filter(vim.fn.getbufline(vim.fn.bufname("%"), 1, 250), 'v:val =~ "^ "'))

    if num_tabs < num_spaces then
        vim.opt_local.expandtab = true
    end
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter', 'BufWinEnter' }, {
    callback = detect_tabs,
    pattern = { '*' },
    group = vimrc,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank() end,
    group = vimrc,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    callback = function() vim.opt_local.filetype = 'lua' end,
    pattern = { '*.script', '*.gui_script', '*.render_script', '*.editor_script' },
    group = vimrc,
})

-- Autosave session on exit
local function save_session()
    local session_file = '~/.nvimsession'
    if #vim.v.this_session > 0 then
        session_file = vim.v.this_session
    end
    vim.cmd.mksession({ args = { session_file }, bang = true })
end

vim.api.nvim_create_autocmd('VimLeavePre', {
    callback = save_session,
    pattern = { '*' },
    group = vimrc,
})
