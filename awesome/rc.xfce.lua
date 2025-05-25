local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local flow = require("flow")

-- HACK: https://github.com/awesomeWM/awesome/issues/1285
local _dbus = dbus; dbus = nil
local naughty = require("naughty")
dbus = _dbus

require("awful.autofocus")

modkey = "Mod4"

workspaces = { "Workspace 1", "Workspace 2", "Workspace 3", "Workspace 4", }

-- Error handling
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
    }
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true
        naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err),
        }
        in_error = false
    end)
end

-- Apply theme
beautiful.init("~/.config/awesome/theme.lua")

-- Table of layouts.
awful.layout.layouts = {
    --flow,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.max,
}

-- Create tags for each screen
awful.screen.connect_for_each_screen(function (s)
    awful.tag(workspaces, s, awful.layout.layouts[1])
end)

-- Key bindings
globalkeys = gears.table.join(
    -- Quit & restart
    awful.key({ modkey, "Shift" }, "q", awesome.quit),
    awful.key({ modkey, "Shift" }, "r", awesome.restart),

    -- Tags manipulation
    awful.key({ modkey, }, "Left", awful.tag.viewprev),
    awful.key({ modkey, }, "Right", awful.tag.viewnext),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

    awful.key({ modkey, }, "j", function () awful.client.focus.byidx(1) end),
    awful.key({ modkey, }, "k", function () awful.client.focus.byidx(-1) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx(-1) end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto),

    awful.key({ modkey, }, "Tab", function ()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end),

    -- Resize windows
    awful.key({ modkey, }, "l", function ()
        if awful.layout.get(awful.screen.focused()) == flow then
            flow.inc_client_size()
        else
            awful.tag.incmwfact(0.05)
        end
    end),
    awful.key({ modkey, }, "h", function ()
        if awful.layout.get(awful.screen.focused()) == flow then
            flow.dec_client_size()
        else
            awful.tag.incmwfact(-0.05)
        end
    end),
    awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end),
    awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end),
    awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1, nil, true) end),
    awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1, nil, true) end),

    -- Change layout
    awful.key({ modkey, }, "s", function () awful.layout.inc(1) end),
    awful.key({ modkey, "Shift" }, "s", function () awful.layout.inc(-1) end),

    awful.key({ modkey, "Shift" }, "n", function ()
        local c = awful.client.restore()
        if c then
            c:emit_signal("request::activate", "key.unminimize", { raise = true, })
        end
    end)
)

-- Bind all key numbers to tags.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag.
        awful.key({ modkey }, "#" .. i + 9, function ()
              local screen = awful.screen.focused()
              local tag = screen.tags[i]
              if tag then
                 tag:view_only()
              end
        end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
           end
        end)
    )
end

-- Set keys
root.keys(globalkeys)

clientkeys = gears.table.join(
    awful.key({ modkey, "Shift" }, "c", function (c) c:kill() end),
    awful.key({ modkey, "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end),

    awful.key({ modkey, }, "q", awful.client.floating.toggle),
    awful.key({ modkey, }, "o", function (c) c:move_to_screen() end),
    awful.key({ modkey, }, "t", function (c) c.ontop = not c.ontop end),
    awful.key({ modkey, }, "n", function (c) c.minimized = true end),

    awful.key({ modkey, }, "f", function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end),

    awful.key({ modkey, }, "m", function (c)
        if c.maximized then
            awful.titlebar.show(c)
            c.border_width = beautiful.border_width
        else
            awful.titlebar.hide(c)
            c.border_width = 0
        end
        c.maximized = not c.maximized
        c:raise()
    end),

    awful.key({ modkey, "Control" }, "m", function (c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end),

    awful.key({ modkey, "Shift" }, "m", function (c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end)
)

-- Move and resize windows
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),

    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),

    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Rules
awful.rules.rules = {
    {
        -- All clients will match this rule.
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        }
    },
    {
        -- Floating clients.
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
                "xfce4-appfinder",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser",  -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
            },

            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",  -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {
            floating = true,
        },
    },
    {
        -- Add titlebars to normal clients and dialogs
        rule_any = { type = { "normal", "dialog", }, },
        properties = { titlebars_enabled = true, },
    },
    {
        -- Set xfdesktop to appear on each virtual desktop.
        rule = { class = "Xfdesktop" },
        properties = { sticky = true, skip_taskbar = true, focusable = false, },
    },
    {
        -- Don't focus xfce4-panel.
        rule = { name = "xfce4-panel" },
        properties = { focusable = false, },
    },
    {
        -- Disable gaps for xfce4-terminal.
        rule = { class = "Xfce4-terminal" },
        properties = { size_hints_honor = false, },
    },
}

-- Signals
client.connect_signal("manage", function (c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end

    if c.name == "xfce4-notifyd" then
        c.focusable = false
        awful.titlebar.hide(c)
        awful.client.focus.history.previous()
        awful.placement.top_right(c, { honor_workarea = true, margins = 16, })
    end

    if c.maximized then
        awful.titlebar.hide(c)
        c.border_width = 0
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function (c)
    local buttons = gears.table.join(
        awful.button({}, 1, function ()
            c:emit_signal("request::activate", "titlebar", { raise = true, })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function ()
            c:emit_signal("request::activate", "titlebar", { raise = true, })
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup {
        {
            layout = wibox.layout.fixed.horizontal,
        },
        {
            {
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            layout = wibox.layout.flex.horizontal,
        },
        {
            layout = wibox.layout.fixed.horizontal(),
        },
        buttons = buttons,
        layout = wibox.layout.align.horizontal,
    }
end)

-- Focus follows mouse
client.connect_signal("mouse::enter", function (c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false, })
end)

client.connect_signal("focus", function (c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function (c) c.border_color = beautiful.border_normal end)

