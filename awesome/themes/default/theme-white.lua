-------------------------
-- White awesome theme --
-------------------------

theme = {}

theme.font          = "Ubuntu 10"

theme.bg_normal     = "#F9F9F9" 
theme.bg_focus      = "#F9F9F9"
theme.bg_urgent     = "#550000" 
theme.bg_minimize   = "#F9F9F9"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#696969"
theme.fg_focus      = "#1793D1"
theme.fg_urgent     = theme.fg_normal
theme.fg_minimize   = theme.fg_normal

theme.border_width  = 3
theme.border_normal = "#212021"
theme.border_focus  = "#515051"
theme.border_marked = "#990000"

theme.titlebar_bg_normal = "#313031"
theme.titlebar_bg_focus = "#1793D1"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
-- theme.taglist_squares_sel   = "~/.config/awesome/themes/default/taglist/squarefw.png"
-- theme.taglist_squares_unsel = "~/.config/awesome/themes/default/taglist/squarew.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "~/.config/awesome/themes/default/submenu.png"
theme.menu_height = 15
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "~/.config/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "~/.config/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "~/.config/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "~/.config/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "~/.config/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "~/.config/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "~/.config/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "~/.config/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "~/.config/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "~/.config/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "~/.config/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "~/.config/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "~/.config/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "~/.config/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "~/.config/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "~/.config/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "~/.config/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "~/.config/awesome/themes/default/titlebar/maximized_focus_active.png"

theme.wallpaper = "~/.config/awesome/themes/default/background.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = "~/.config/awesome/themes/default/layouts/fairh.png"
theme.layout_fairv = "~/.config/awesome/themes/default/layouts/fairv.png"
theme.layout_floating  = "~/.config/awesome/themes/default/layouts/floating.png"
theme.layout_magnifier = "~/.config/awesome/themes/default/layouts/magnifier.png"
theme.layout_max = "~/.config/awesome/themes/default/layouts/max.png"
theme.layout_fullscreen = "~/.config/awesome/themes/default/layouts/fullscreen.png"
theme.layout_tilebottom = "~/.config/awesome/themes/default/layouts/tilebottom.png"
theme.layout_tileleft   = "~/.config/awesome/themes/default/layouts/tileleft.png"
theme.layout_tile = "~/.config/awesome/themes/default/layouts/tile.png"
theme.layout_tiletop = "~/.config/awesome/themes/default/layouts/tiletop.png"
theme.layout_spiral  = "~/.config/awesome/themes/default/layouts/spiral.png"
theme.layout_dwindle = "~/.config/awesome/themes/default/layouts/dwindle.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from ~/.config/icons and ~/.config/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
