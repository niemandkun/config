-- Neovim config file

-- Quickly switch between buffers
vim.keymap.set('n', '<c-tab>', ':bnext<cr>')
vim.keymap.set('n', '<c-s-tab>', ':bNext<cr>')

-- Map <cr> to confirm selection in menu
local function insert_cr_wrapper()
    return vim.fn.pumvisible() == 1 and '<c-y>' or '<cr>'
end

vim.keymap.set('i', '<cr>', insert_cr_wrapper, { expr = true })

-- Smart tab
local function insert_tab_wrapper()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    if col and line then
        local char = line:sub(col - 1, col - 1)
        if char and #char ~= 0 and not string.match(char, '%s') then
            return '<c-n>'
        end
    end
    return '<tab>'
end

vim.keymap.set('i', '<tab>', insert_tab_wrapper, { expr = true })

-- Swap left/right and up/down while navigating wildmenu (pum)
local function wildmenu_wrapper(menu_binding, normal_binding)
    return function()
        if vim.fn.wildmenumode() == 1 then
            return menu_binding
        else
            return normal_binding
        end
    end
end

vim.keymap.set('c', '<Up>', wildmenu_wrapper('<Left>', '<Up>'), { expr = true })
vim.keymap.set('c', '<Down>', wildmenu_wrapper('<Right>', '<Down>'), { expr = true })
vim.keymap.set('c', '<Left>', wildmenu_wrapper('<Up>', '<Left>'), { expr = true })
vim.keymap.set('c', '<Right>', wildmenu_wrapper(' <bs><Tab>', '<Right>'), { expr = true })
