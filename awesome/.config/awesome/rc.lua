--                                      _
--         ___ _ __   ___ _ __ ___   __| |
--        / __| '_ \ / __| '_ ` _ \ / _` |
--        \__ | |_) | (__| | | | | | (_| |
--        |___| .__/ \___|_| |_| |_|\__,_|
--             |_|
--
--                    rc.lua
--               Created by: spcmd
--           http://spcmd.github.io
--           https://github.com/spcmd
--           https://gist.github.com/spcmd


-- {{{  Load libraries
--------------------------------------

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- Vicious library
vicious = require("vicious")
-- blingbling library
blingbling = require("blingbling")

-- }}}
-- {{{  Autostart
--------------------------------------

-- Enable compositing
--awful.util.spawn_with_shell("compton --backend glx --paint-on-overlay --vsync opengl-swc &")
awful.util.spawn_with_shell("compton -b --config /home/spcmd/.config/compton/compton.conf")

-- }}}
-- {{{  Errors
--------------------------------------

-- Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

-- }}}
-- {{{  Variables
-------------------------------------

-- Applications
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "nano"

-- Default modkey.
modkey = "Mod4"

-- }}}
-- {{{  Theme, Layout, Wallpaper, Tags, Menu, Launcher
------------------------------------------

-- Theme
beautiful.init("~/.config/awesome/themes/archie-blue/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{

    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.floating,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier

}

--  Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- Tags
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ " term", "🌍 web", "files", " mus", "⇣torr", "⛬misc", 7, 8, 9 }, s, layouts[1])
end

-- Menu
myawesomemenu = {
                    { "restart", awesome.restart },
                    { "quit", awesome.quit }
                }

mymainmenu = awful.menu({ items = {
                                    { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "terminal", terminal },
                                    { "clear admin", "/home/spcmd/.local/share/applications/ClearAdmin.desktop" },
                                    { "----------", "" },
                                    { "shutdown", "systemctl poweroff" }
                                  }
                        })

mylauncher = awful.widget.launcher({
                                     image = beautiful.awesome_icon,
                                     menu = mymainmenu
                                  })

-- Add margin to the launcher icon
local mylauncher_margin = wibox.layout.margin(mylauncher,0,1,0,0)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- }}}
--{{{   Wibox & Widgets 
-------------------------------------------

-- Vicious: Volume (unicode icons (ttf-symbola needed!): 🔊  ♫ )
volumewidget = wibox.widget.textbox()

local amixer =
{
	channel = "Master",
	step = "2%",
	colors =
	{
		unmute = "#dedede",
		mute = "#d80000"
	},
	termcmd = terminal .. " -e alsamixer",
}

volumewidget:buttons (awful.util.table.join (
        -- Left mouse button
        awful.button ({}, 1, function()
                -- You may need to specify a card number if you're not using your main set of speakers.
                -- You'll have to apply this to every call to 'amixer sset'.
                -- awful.util.spawn ("amixer sset -c " .. yourcardnumber .. " " .. amixer.channel .. " toggle")
		awful.util.spawn ("amixer sset " .. amixer.channel .. " toggle")
		vicious.force ({ volumewidget }) -- force refresh the widget when using the mouse on it
	end),
        -- Middle mouse button
        awful.button ({}, 2, function()
		awful.util.spawn (amixer.termcmd)
	end),
        -- Right mouse button
        awful.button ({}, 3, function()
		awful.util.spawn ("amixer sset " .. amixer.channel .. " 100 " )
		vicious.force ({ volumewidget }) -- force refresh the widget when using the mouse on it
	end),
        -- Mouse wheel down
        awful.button ({}, 4, function()
		awful.util.spawn ("amixer sset " .. amixer.channel .. " " .. amixer.step .. "-")
		vicious.force ({ volumewidget }) -- force refresh the widget when using the mouse on it
	end),
        -- Mouse wheel up
        awful.button ({}, 5, function()
		awful.util.spawn ("amixer sset " .. amixer.channel .. " " .. amixer.step .. "+")
		vicious.force ({ volumewidget }) -- force refresh the widget when using the mouse on it
	end)

))

vicious.register(volumewidget, vicious.widgets.volume,
                 function(widget, args)
                    local label = { ["♫"] = "🔊", ["♩"] = "<span color='#d80000'>🔊 </span>" }
                    return " " .. label[args[2]] .. " " .. args[1] .. " "
                 end, 300, "Master" -- 300 = 5 mins update time. We don't need fast widget refresh (low number/time) because the buttons will update the widget instantly.
                )


-- Vicious: Battery widget
battwidget = wibox.widget.textbox()

battwidget_tip = awful.tooltip({ objects = { battwidget }})
vicious.register(battwidget, vicious.widgets.bat, function (widget, args)
                    battwidget_tip:set_text( args[3] )
                    return args[3]
                end, 60, 'BAT0')

battwidget:buttons (awful.util.table.join (
        awful.button ({}, 1, function()
		vicious.force ({ battwidget }) -- force refresh the widget when using the mouse on it
	end)
))

vicious.register(battwidget, vicious.widgets.bat, ' $1$2 ', 60, 'BAT0')

-- Ethernet connection widget
function check_eth()
 local eth_file = io.open("/sys/class/net/ens3/operstate", "r")
 local eth_state = eth_file:read()
 eth_file:close()
 return eth_state
end

eth_widget = wibox.widget.textbox()

function eth_status()
    if (check_eth() == "up") then
        eth_widget:set_text("   on ")
    else
        eth_widget:set_text("   off ")
    end
end
eth_status()

eth_timer = timer({timeout=60})
eth_timer:connect_signal("timeout",eth_status)
eth_timer:start()

-- Wifi connection widget
-- symbols (unicode and fontawesome ttf): 📶     
function check_wls()
 local wls_file = io.open("/sys/class/net/wls2/operstate", "r")
 local wls_state = wls_file:read()
 wls_file:close()
 return wls_state
end

wls_widget = wibox.widget.textbox()

function wls_status()
    if (check_wls() == "up") then
        wls_widget:set_text(" on ")
    else
        wls_widget:set_text(" off ")
    end
end
wls_status()

wls_timer = timer({timeout=60})
wls_timer:connect_signal("timeout",wls_status)
wls_timer:start()

-- toggle Wifi with mouse click (using NetworkManager: nmcli)
wls_widget:buttons (awful.util.table.join (
	awful.button ({}, 1, function()
        if (check_wls() == "down") then
			awful.util.spawn("nmcli r wifi on")
			wls_widget:set_text(" on ")
		else
			awful.util.spawn("nmcli r wifi off")
			wls_widget:set_text(" off ")
		end
	end)
))

-- Textclock widget
mytextclock = awful.widget.textclock()

-- Clock & Date with Calendar ( https://github.com/cedlemo/blingbling )
-- styling:
    --background_color
    --background_text_color
    --h_margin v_margin
    --rounded_size
    --text_color, font, font_size
calendar = blingbling.calendar()
calendar:set_link_to_external_calendar(false)
calendar:set_current_day_widget_style({
    background_color = beautiful.bg_focus,
    text_color = beautiful.fg_focus,
})
calendar:set_weeks_number_widget_style({
    text_color = beautiful.bg_normal -- hide the week numbers
})

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
            awful.button({ }, 1, awful.tag.viewonly), -- Mouse left click: view tag
            awful.button({ modkey }, 1, awful.client.movetotag), -- Mod+Mouse left: move window to tag
            awful.button({ }, 3, awful.tag.viewtoggle), -- Mouse right click: view another tag's window inside current tag
            awful.button({ modkey }, 3, awful.client.toggletag) -- Mod+Right click: show current tag's window when clicking on the toggled tag
            --awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end), -- Cycle through tags with the mouse wheel
            --awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end) -- Cycle through tags with the mouse wheel
            )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = 20, screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    --left_layout:add(mylauncher)
    left_layout:add(mylauncher_margin)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    --if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(eth_widget)
    right_layout:add(wls_widget)
    right_layout:add(volumewidget)
    right_layout:add(battwidget)
    --right_layout:add(mytextclock)
    right_layout:add(calendar)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end

-- }}}
-- {{{  Key and Mouse bindings
--------------------------------------------------

-- Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = awful.util.table.join(

    --~~~~~~~~~~~~~~~~~~~~~~~~~~
    --~ Custom key bindings  ~~~
    --~~~~~~~~~~~~~~~~~~~~~~~~~~

    -- Spotify: Play/Pause, Prev, Next
    awful.key({ modkey,           }, "s", function () awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") end),
    awful.key({ modkey,           }, "Left", function () awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous") end),
    awful.key({ modkey,           }, "Right", function () awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next") end),

    -- Volume
    awful.key({ modkey,           }, "Up", function () awful.util.spawn("amixer sset Master 2%+") vicious.force ({ volumewidget }) end),
    awful.key({ modkey,           }, "Down", function () awful.util.spawn ("amixer sset Master 2%-") vicious.force ({ volumewidget }) end),
    
     -- Start several applications at the same time
    awful.key({ modkey, "Mod1"    }, "1", function () 
                                                awful.util.spawn("firefox") 
                                                awful.util.spawn("spotify") 
                                                awful.util.spawn(terminal .. " -t ranger -e ranger")
                                                awful.util.spawn(terminal .. " -t rtorrent -e rtorrent")
                                          end),

    -- Run Applications
    awful.key({ modkey, "Mod1"    }, "f", function () awful.util.spawn("firefox") end),
    awful.key({ modkey, "Mod1"    }, "s", function () awful.util.spawn("spotify") end),
    awful.key({ modkey, "Mod1"    }, "c", function () awful.util.spawn("gcolor2") end),
    awful.key({ modkey, "Mod1"    }, "r", function () awful.util.spawn(terminal .. " -t ranger -e ranger") end),
    awful.key({ modkey, "Mod1"    }, "t", function () awful.util.spawn(terminal .. " -t rtorrent -e rtorrent") end),

    -- Backlight
    awful.key({ modkey, "Control" }, "Left", function () awful.util.spawn("/home/spcmd/Scripts/qxbacklight --down") end),
    awful.key({ modkey, "Control" }, "Right", function () awful.util.spawn("/home/spcmd/Scripts/qxbacklight --up") end),
    awful.key({ modkey, "Control" }, "#90", function () awful.util.spawn("/home/spcmd/Scripts/qxbacklight --default") end),

    -- Set wallpaper with feh (useful when errors happen and Awesome falls back to the default wallpaper)
    awful.key({ modkey, "Mod1"    }, "w", function () awful.util.spawn_with_shell("sh ~/.fehbg") end),

    -- Scrot (entire screen)
    awful.key({ modkey, "Mod1"    }, "p", function () awful.util.spawn_with_shell("scrot ~/Pictures/scrot_%Y-%m-%d_%T.png && notify-send ' scrot ' ' taken '") end),
    -- Scrot (selected area)
    awful.key({ modkey, "Mod1"    }, "o", function () awful.util.spawn_with_shell("sleep 1s && scrot -s ~/Pictures/scrot_%Y-%m-%d_%T.png && notify-send ' scrot ' ' taken '") end),


    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    --~ end of Custom key bindings ~~~
    --~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    awful.key({ modkey,           }, "#34",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "#35",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "Menu", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Restore minimized windows
    awful.key({ modkey, "Control" }, "n", awful.client.restore),


    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- Launcher bar
    awful.key({ modkey }, "a", function() menubar.show() end)
)

-- Client keys
clientkeys = awful.util.table.join(

    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)

) -- end of client keys

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

-- }}}
-- {{{  Rules
--------------------------------------------------

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false } },

    -- Float rules
    { rule_any = { class = { "mpv", "Zathura", "feh", "Gcolor2", "Gifview", "Wine", "gimp" } },
        properties = { floating = true } },
    
    -- Tag 2 rules
    { rule_any = { class = { "Firefox", "Iceweasel", "Chromium", "Chrome" } },
        properties = { tag = tags[1][2] } },

    -- Tag 3 rules
    { rule_any = { class = { "Thunar" } , name = { "ranger" }  },
        properties = { tag = tags[1][3] } },

    -- Tag 4 rules
    { rule_any = { class = { "Spotify" }  },
        properties = { tag = tags[1][4] } },
     
    -- Tag 5 rules
    { rule_any = { name = { "rtorrent" }  },
        properties = { tag = tags[1][5] } },

    -- Tag 6 rules
    { rule_any = { class = { "Gimp", "Inkscape", "libreoffice", "VirtualBox", "Gtkpod" } },
        properties = { tag = tags[1][6] } },


}

-- }}}
-- {{{  Signals, Titlebar settings
----------------------------------------------------

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)

    -- Sloppy focus
    --[[
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)
    ]]

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    -- Enable titlbar for floating applications
    local titlebars_enabled = true
    if titlebars_enabled and (
                              c.class == "mpv" or
                              c.class == "feh" or
                              c.class == "Gcolor2" or
                              c.class == "Gifview" or
                              c.class == "Zathura" or
                              c.class == "Wine" or
                              c.type == "dialog"
                             )
    then

        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )


        -- Window Titlebar Layout (buttons, title, etc.)

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        --left_layout:buttons(buttons)
        left_layout:add(awful.titlebar.widget.closebutton(c))
        --left_layout:add(awful.titlebar.widget.floatingbutton(c))
        left_layout:add(awful.titlebar.widget.stickybutton(c))
        left_layout:add(awful.titlebar.widget.maximizedbutton(c))
        --left_layout:add(awful.titlebar.widget.ontopbutton(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        --right_layout:add(awful.titlebar.widget.floatingbutton(c))
        --right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        --right_layout:add(awful.titlebar.widget.stickybutton(c))
        --right_layout:add(awful.titlebar.widget.ontopbutton(c))
        --right_layout:add(awful.titlebar.widget.closebutton(c))
        right_layout:add(awful.titlebar.widget.iconwidget(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Disabled clients bo be urgent by default
-- https://awesome.naquadah.org/wiki/FAQ#Why_are_new_clients_urgent_by_default.3F
client.disconnect_signal("request::activate", awful.ewmh.activate)
   function awful.ewmh.activate(c)
       if c:isvisible() then
           client.focus = c
           c:raise()
       end
   end
   client.connect_signal("request::activate", awful.ewmh.activate)

-- }}}
