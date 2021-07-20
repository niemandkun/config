---------------------------------------------------------------------------
-- Infinite flow layout
--
-- @author Ivan Poroshin
-- @copyright 2021 Ivan Poroshin
---------------------------------------------------------------------------

local naughty = require("naughty")
local ascreen = require("awful.screen")
local xresources = require("beautiful.xresources")

local ipairs = ipairs
local pairs = pairs
local pcall = pcall

local capi =
{
    client = client,
    mouse = mouse,
    mousegrabber = mousegrabber
}


local global_offset = 0
local preview_area = xresources.apply_dpi(16)
local weights = { 1, 2/3, 1/2, 1/3 }
local flow = {}

local function get_possible_client_sizes(workarea_size)
    local sizes = {}
    local available_space = workarea_size - 2 * preview_area
    for k, weight in ipairs(weights) do
        sizes[k] = weight * available_space
    end
    return sizes
end

local function get_deltas(client_size, possible_sizes)
    local deltas = {}
    for k, size in ipairs(possible_sizes) do
        deltas[k] = math.abs(client_size - size)
    end
    return deltas
end

local function find_client_size_idx(client_size, possible_sizes)
    local deltas = get_deltas(client_size, possible_sizes)
    local min = 1
    for k, delta in ipairs(deltas) do
        if delta < deltas[min] then
            min = k
        end
    end
    return min
end

local function get_next_client_size(client_size, workarea_size, dx)
    local possible_sizes = get_possible_client_sizes(workarea_size)
    local idx = find_client_size_idx(client_size, possible_sizes)
    if idx + dx >= 1 and idx + dx <= 4 then
        return possible_sizes[idx + dx]
    else
        return possible_sizes[idx]
    end
end

local function calculate_sizes(clients, workarea_size)
    local possible_sizes = get_possible_client_sizes(workarea_size)
    local sizes = {}
    for _, client in pairs(clients) do
        local g = client:geometry()
        sizes[client] = possible_sizes[find_client_size_idx(g.width, possible_sizes)]
    end
    return sizes
end

local function do_flow(p)
    if #p.clients == 0 then
        return
    end

    -- naughty.notify { text = "global_offset=" .. global_offset }

    -- Precalculate clients widths
    local clients_width = calculate_sizes(p.clients, p.workarea.width)

    -- Clamp global_offset to avoid showing empty areas
    local total_width = 0
    for _, w in pairs(clients_width) do
        total_width = total_width + w
    end

    total_width = total_width - p.workarea.width +  preview_area

    -- naughty.notify { text = "tw=" .. total_width .. ", go=" .. global_offset }

    -- global_offset = math.max(math.min(global_offset, preview_area), -total_width)
    global_offset = math.min(math.max(global_offset, -total_width), preview_area)

    -- Calculate clients geometries
    local offset = global_offset
    for _, client in pairs(p.clients) do
        local new_geometry = {
            x = p.workarea.x + offset,
            y = p.workarea.y,
            width = clients_width[client],
            height = p.workarea.height,
        }
        p.geometries[client] = new_geometry
        offset = offset + new_geometry.width
    end

    -- Autoscroll to focused client
    local autoscroll_amount = 0
    local focused_client = capi.client.focus
    if focused_client then
        local fg = p.geometries[focused_client]
        local right_workarea_corner = p.workarea.x + p.workarea.width - preview_area
        local right_client_corner = fg.x + fg.width
        local overshoot =  right_workarea_corner - right_client_corner
        -- naughty.notify { text = "rwc=" .. right_workarea_corner .. ", rcc=" .. right_client_corner }
        if overshoot < 0 then
            -- naughty.notify { text = "overshoot=" .. overshoot }
            autoscroll_amount = overshoot
        end

        local left_workarea_corner = p.workarea.x + preview_area
        local left_client_corner = fg.x
        local undershoot = left_workarea_corner - left_client_corner
        -- naughty.notify { text = "lwc=" .. left_workarea_corner .. ", lcc=" .. left_client_corner }
        if undershoot > 0 then
            -- naughty.notify { text = "undershoot=" .. undershoot }
            autoscroll_amount = undershoot
        end
    end

    -- Apply autoscroll
    if autoscroll_amount ~= 0 then
        global_offset = global_offset + autoscroll_amount
        for _, c in pairs(p.clients) do
            p.geometries[c].x = p.geometries[c].x + autoscroll_amount
        end
    end
end

local function adjust_focused_client_size(direction)
    local fc = capi.client.focus
    if fc then
        local g = fc:geometry()
        local new_width = get_next_client_size(g.width, fc.screen.workarea.width, direction)
        fc:geometry {
            x = g.x,
            y = g.y,
            width  = new_width,
            height = g.height,
        }
    end
end

function call_safely(func)
    local status, err = pcall(func)
    if err then
        naughty.notify { text = err }
    end
end

function flow.resize_handler(c, context, hints)
    local possible_sizes = get_possible_client_sizes(c.screen.workarea.width)
    local idx = find_client_size_idx(hints.width, possible_sizes)

    g = c:geometry()
    c:geometry {
        x = hints.x,
        y = g.y,
        width  = possible_sizes[idx],
        height = g.height,
    }

    global_offset = global_offset + (hints.x - g.x)
end

function flow.inc_client_size()
    call_safely(function() adjust_focused_client_size(-1) end)
end

function flow.dec_client_size()
    call_safely(function() adjust_focused_client_size(1) end)
end

function flow.arrange(params)
    call_safely(function() do_flow(params) end)
end

--- The flow layout.
-- @clientlayout awful.layout.suit.

flow.name = "flow"

return flow

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
