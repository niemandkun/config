-- Neovim config file

-- Status line

local start = " "
local separator = "  "
local ending = " "

local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""] = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""] = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}

local fileformats = {
    ["unix"] = "LF",
    ["dos"] = "CRLF",
}

local function get_editor_mode()
    local mode = vim.fn.mode()
    return modes[mode] or string.upper(mode)
end

local function get_filetype()
    local ftype = vim.bo.filetype
    return string.upper(string.sub(ftype, 1, 1)) .. string.lower(string.sub(ftype, 2, -1))
end

local function get_tab_type()
    if vim.bo.expandtab then
        return string.format("Spaces:%d", vim.bo.shiftwidth)
    end
    return string.format("Tabs:%d", vim.bo.tabstop)
end

local function get_fileformat()
    local ff = vim.bo.fileformat
    return fileformats[ff] or string.upper(ff)
end

local function get_fileencoding()
    return string.upper(vim.bo.fileencoding)
end

local function get_filename()
    local modified = vim.bo.modified and "*" or ""
    local readonly = (vim.bo.readonly or not vim.bo.modifiable) and " (readonly)" or ""
    return string.format("%s%s%s", "%t", modified, readonly)
end

local function get_lsp_info()
    local levels = { "Error", "Warn", "Info", "Hint" }
    local info = {}
    local first = true

    for _, level in ipairs(levels) do
        local count = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
        if count > 0 or level == "Error" or level == "Warn" then
            if first then
                first = false
            else
                table.insert(info, " ")
            end
            table.insert(info, "%#StatusLine")
            table.insert(info, level)
            table.insert(info, "#%#StatusLine# ")
            table.insert(info, count)
        end
    end

    return table.concat(info)
end

local function get_selection_info()
    local vbytes = vim.fn.wordcount().visual_bytes
    if not vbytes then
        return ""
    end
    return string.format("(%d selected)", vbytes)
end

local function build_statusline(tokens)
    local filtered = { "%<", start }
    local first = true
    for _, token in ipairs(tokens) do
        if token ~= "" then
            if first then
                first = false
            else
                table.insert(filtered, separator)
            end
            table.insert(filtered, token)
        end
    end
    table.insert(filtered, ending)
    return table.concat(filtered)
end

Statusline = {}

function Statusline.active()
    return build_statusline({
        get_editor_mode(),
        get_filename(),
        get_lsp_info(),
        "%=",
        "%l:%c",
        get_selection_info(),
        get_tab_type(),
        get_fileencoding(),
        get_fileformat(),
        get_filetype(),
    })
end

function Statusline.inactive()
    return build_statusline({
        "%t",
    })
end

function Statusline.tree()
    return build_statusline({
        "NETRW",
    })
end

local augroup = vim.api.nvim_create_augroup("statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    callback = function() vim.opt_local.statusline = "%!v:lua.Statusline.active()" end,
    pattern = { "*" },
    group = augroup,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    callback = function() vim.opt_local.statusline = "%!v:lua.Statusline.inactive()" end,
    pattern = { "*" },
    group = augroup,
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "FileType" }, {
    callback = function() vim.opt_local.statusline = "%!v:lua.Statusline.tree()" end,
    pattern = { "netrw" },
    group = augroup,
})
