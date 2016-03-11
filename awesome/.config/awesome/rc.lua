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
-- {{{  Applications & Variables
-------------------------------------

-- Applications
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "nano"
compton = "compton -b --config /home/spcmd/.config/compton/compton.conf"
ranger = terminal .. " -name ranger -e ranger"
newsbeuter = terminal .. " -name newsbeuter -e newsbeuter"
rtorrent = terminal .. " -name rTorrent -e rtorrent"
mutt = terminal .. " -name mutt -e mutt -F ~/.mutt/account.1.muttrc"
moc = terminal .. " -name moc -e mocp"
firefox = "/home/spcmd/bin/firefox-esr/firefox"
dmenu = "/home/spcmd/Scripts/dmenu_run -i -l 10 -fn 'terminus' -sb '#0D497B' -nb '#121212'"

-- Default modkey.
modkey = "Mod4"

-- }}}
-- {{{  Autostart
--------------------------------------

-- Enable compositing
awful.util.spawn_with_shell(compton)

-- Autorun applications (on the set display only)
xdisplay = os.getenv("DISPLAY")
runOnDisplay = ":0"
autorun = true

-- list of apps to autorun
autorunApps =
{
    terminal,
    ranger,
    newsbeuter,
    rtorrent,
    firefox,
}

-- Autorun apps only the fist time (after startx), but NOT when awesome restarts (mod+Ctrl+R)
-- Check the autorun file
function check_autorun()
 local autorun_file = io.open("/tmp/awm_autorun", "r")
     if autorun_file~=nil then
         local autorun_state = autorun_file:read()
         autorun_file:close()
         return autorun_state
    end
end

-- Autorun apps if...
if autorun and xdisplay == runOnDisplay and (check_autorun() ~= "false") then
    for app = 1, #autorunApps do
        awful.util.spawn(autorunApps[app])
    end
end

-- End of autorun, disable it by writing "false" to a temp file
-- This way we can avoid auto running apps when awesome restarts
file_autorun = io.open("/tmp/awm_autorun", "w")
file_autorun:write("false")
file_autorun:close()

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
-- {{{  Theme, Layout, Wallpaper, Tags, Menu, Launcher
------------------------------------------

-- Theme
beautiful.init("~/.config/awesome/themes/arch-spcmd/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{

    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
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
    ---- Each screen has its own tag table.
    --tags[s] = awful.tag({ "term", "web", "files", "mus", "torr", "misc", "mail", "news" }, s, layouts[1])
    tags[s] = awful.tag({ " term", " web", " files", " mus", " torr", " misc", " mail", " news" }, s, layouts[1])
    --tags[s] = awful.tag({ " term", "🌍 web", " files", "🎜 mus", " torr", " misc", " mail", " news" }, s, layouts[1])
    --tags[s] = awful.tag({ " 1: ", "2:🌍 ", "3: ", "4: ", "5: ", "6: ", "7: ", "8: " }, s, layouts[1])
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

-- Menubar configuration (http://awesome.naquadah.org/wiki/Menubar/3.5)
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
menubar.cache_entries = true
menubar.show_categories = false
menubar.geometry = { height=25 }
menubar.menu_gen.all_menu_dirs = {
  "/usr/share/applications",
  "/usr/local/share/applications",
  "/home/spcmd/Games"
}

-- }}}
--{{{   Wibox & Widgets
-------------------------------------------

----------------------------------------------------------------
-- global variables for widgets
----------------------------------------------------------------
color_widget_separator = beautiful.bg_focus
widget_separator = "<span color='"..color_widget_separator.."'>|</span>"

----------------------------------------------------------------
-- Vicious: Volume (unicode icons (ttf-symbola needed!): 🔊  ♫ )
----------------------------------------------------------------

icon_volume = widget_separator.." Vol:"
icon_muted = widget_separator.."<span color='#d80000'> Vol:</span>"

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
                    local label = { ["♫"] = icon_volume, ["♩"] = icon_muted}
                    return " " .. label[args[2]] .. " " .. args[1] .. ""
                 end, 300, "Master" -- 300 = 5 mins update time. We don't need fast widget refresh (low number/time) because the buttons will update the widget instantly.
                )

----------------------------------------------------------------
-- Vicious: Battery widget
----------------------------------------------------------------
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

----------------------------------------------------------------
-- Ethernet connection widget
-- symbols: 
----------------------------------------------------------------

eth_icon = widget_separator.." Eth: "

function check_eth()
 local eth_file = io.open("/sys/class/net/ens3/operstate", "r")
 local eth_state = eth_file:read()
 eth_file:close()
 return eth_state
end

eth_widget = wibox.widget.textbox()

function eth_status()
    if (check_eth() == "up") then
        eth_widget:set_markup(eth_icon.."on ")
    else
        eth_widget:set_markup(eth_icon.."off ")
    end
end
eth_status()

eth_timer = timer({timeout=60})
eth_timer:connect_signal("timeout",eth_status)
eth_timer:start()

----------------------------------------------------------------
-- Wifi connection widget
-- symbols (unicode and fontawesome ttf): 📶      📶
----------------------------------------------------------------

icon_wifi = widget_separator.." Wifi: "

function check_wls()
 local wls_file = io.open("/sys/class/net/wls2/operstate", "r")
 local wls_state = wls_file:read()
 wls_file:close()
 return wls_state
end

wls_widget = wibox.widget.textbox()

function wls_status()
    if (check_wls() == "up") then
        wls_widget:set_markup(icon_wifi.."on")
    else
        wls_widget:set_markup(icon_wifi.."off")
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
			wls_widget:set_text(icon_wifi.."on")
		else
			awful.util.spawn("nmcli r wifi off")
			wls_widget:set_text(icon_wifi.."off")
		end
	end)
))


----------------------------------------------------------------
-- Mail widget
-- symbols: 
----------------------------------------------------------------

icon_mail = "Mail: "

mail_widget = wibox.widget.textbox()

-- Mail checker (run mail checker script)
function check_mail()
    awful.util.spawn_with_shell("gmailcheck.sh")
end
check_mail_timer = timer({timeout=180})
check_mail_timer:connect_signal("timeout",check_mail)
check_mail_timer:start()

function newmail_count()
 local newmail_count_file = io.open("/home/spcmd/.mutt/newmail_count", "r")
 local newmail_count_content = newmail_count_file:read()
 newmail_count_file:close()
 return newmail_count_content
end

function mailchecker_set()
    local mailchecker_set_file = io.open("/home/spcmd/.config/awesome/mailchecker", "r")
    local mailchecker_set_content = mailchecker_set_file:read()
    mailchecker_set_file:close()
    return mailchecker_set_content
end

function mail_status()
    if mailchecker_set() == "off" then
        --mail_widget:set_markup(icon_mail.."<span background='#E9AD00' color='" ..beautiful.bg_normal .. "'>OFF</span> ")
        mail_widget:set_markup(icon_mail.."<span color='#fff300'>OFF</span> ")
    elseif (mailchecker_set() ~= "off" and tonumber(newmail_count()) >= 1) then
        mail_widget:set_markup(icon_mail.."<span background='" ..beautiful.bg_urgent .. "' color='" ..beautiful.fg_urgent .. "'> "..tonumber(newmail_count()).."new </span> ")
    else
        mail_widget:set_markup(icon_mail.."0")
    end
end
mail_status()

mail_widget_timer = timer({timeout=30})
mail_widget_timer:connect_signal("timeout",mail_status)
mail_widget_timer:start()

------ Mail widget mouse button action
mail_widget:buttons (awful.util.table.join (
    awful.button ({}, 1, function()
        awful.util.spawn(terminal .. " -name mutt -T mutt -e run_once.sh mutt -F ~/.mutt/account.1.muttrc")
        -- jump to mail tag
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[7]
        if tag then
           awful.tag.viewonly(tag)
        end
    end),
    awful.button ({}, 2, function()
        awful.util.spawn_with_shell("gmailcheck.sh")
        naughty.notify({ title = "awesome Mailchecker", text = "Check done!" })
    end),
    awful.button ({}, 3, function()
        awful.util.spawn(terminal .. " -name mutt -T mutt -e run_once.sh mutt -F ~/.mutt/account.2.muttrc")
        -- jump to mail tag
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[7]
        if tag then
           awful.tag.viewonly(tag)
        end
    end)
))

------ Mail list tooltip
function newmail_list()
    local newmail_list_file = io.open("/home/spcmd/.mutt/newmail_list")
    newmail_list_content = newmail_list_file:read("*all")
    newmail_list_file:close()
    return newmail_list_content
end

list_newmail_tooltip = awful.tooltip({ objects = { mail_widget }})

mail_widget:connect_signal("mouse::enter", function ()
    --list_newmail_tooltip:set_markup("<span color='#ff0000'>"..newmail_list().."</span> ")
    list_newmail_tooltip:set_text(newmail_list())
end)

----------------------------------------------------------------
--  Note/Reminder widget
----------------------------------------------------------------
--  Note:
--  widget format also set by awm-note() function in the .zshrc
----------------------------------------------------------------


note_widget = wibox.widget.textbox()

function read_notes()
 local note_file = io.open("/home/spcmd/Documents/awm-note.txt")
 if note_file~=nil then
     local note_contents = note_file:read("*all")
     note_file:close()
     return note_contents
 end
end

function note_status()
    if (read_notes() ~= nil) then
        note_widget:set_markup("<span font_weight='bold' color='#00fff0'> Notes</span> <span color='" ..color_widget_separator.. "'>|</span> ")

    end
end
note_status()

note_list = awful.tooltip({ objects = { note_widget }})

note_widget:connect_signal("mouse::enter", function ()
    note_list:set_text(read_notes())
end)

----------------------------------------------------------------
-- Textclock & Calendar widget
----------------------------------------------------------------
-- clock and calendar icons are set in calendar.lua!

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
    background_color = beautiful.fg_focus,
    text_color = beautiful.bg_focus,
})
calendar:set_weeks_number_widget_style({
    text_color = beautiful.bg_normal -- hide the week numbers
})

----------------------------------------------------------------
-- Create a wibox for each screen and add it
----------------------------------------------------------------
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
    mytasklist_margin = wibox.layout.margin(mytasklist[s],0,5,0,0)

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
    right_layout:add(note_widget)
    right_layout:add(mail_widget)
    --right_layout:add(eth_widget)
    --right_layout:add(wls_widget)
    right_layout:add(volumewidget)
    right_layout:add(battwidget)
    --right_layout:add(mytextclock)
    right_layout:add(calendar)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist_margin)
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

    -- Spotify
    awful.key({ modkey,           }, "s", function () awful.util.spawn("dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") end),
    awful.key({ modkey,           }, "Left", function () awful.util.spawn("dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous") end),
    awful.key({ modkey,           }, "Right", function () awful.util.spawn("dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next") end),


    -- spotymenu
    awful.key({ modkey,           }, "b", function () awful.util.spawn("spotymenu", false) end),

    -- mps-youtube
    awful.key({ modkey,     }, "y", function () awful.util.spawn("mpsyt-control play-pause") end),
    awful.key({ modkey, "y" }, "Left", function () awful.util.spawn("mpsyt-control previous") end),
    awful.key({ modkey, "y" }, "Right", function () awful.util.spawn("mpsyt-control next") end),

    -- Volume
    awful.key({ modkey,           }, "Up", function () awful.util.spawn("amixer sset Master 2%+") vicious.force ({ volumewidget }) end),
    awful.key({ modkey,           }, "Down", function () awful.util.spawn ("amixer sset Master 2%-") vicious.force ({ volumewidget }) end),

    -- Check mail
    awful.key({ modkey, "Control" }, "m", function ()
        awful.util.spawn_with_shell("gmailcheck.sh")
        naughty.notify({ title = "awesome Mailchecker", text = "Check done!" })
     end),

    -- Sleep
    awful.key({ modkey, "Control"    }, "z", function () awful.util.spawn("systemctl suspend") end),

    -- Run Applications
    awful.key({ modkey,           }, "a", function () awful.util.spawn(dmenu,false) end),
    awful.key({ modkey, "Mod1"    }, "f", function () awful.util.spawn(firefox) end),
    awful.key({ modkey, "Mod1"    }, "u", function () awful.util.spawn("uzbl-tabbed") end),
    awful.key({ modkey, "Mod1"    }, "c", function () awful.util.spawn("gcolor2") end),
    awful.key({ modkey, "Mod1"    }, "r", function () awful.util.spawn(ranger) end),
    awful.key({ modkey, "Mod1"    }, "t", function () awful.util.spawn(rtorrent) end),
    awful.key({ modkey, "Mod1"    }, "m", function () awful.util.spawn(mutt) end),
    awful.key({ modkey, "Mod1"    }, "n", function () awful.util.spawn(newsbeuter) end),
    --awful.key({ modkey, "Mod1"    }, "m", function () awful.util.spawn(moc) end),
    --awful.key({ modkey, "Mod1"    }, "s", function () awful.util.spawn("spotify") end),
    awful.key({ modkey, "Mod1"    }, "s",
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[4]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                        awful.util.spawn("spotify")
                  end),

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
              end)

    -- Launcher bar
    --awful.key({ modkey }, "a", function() menubar.show() end)
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
    { rule_any = { class = { "Gifview", "Wine" } },
        properties = { floating = true } },

    { rule = { class = "Gcolor2" }, properties = { floating = false } },

    -- Tag 2 rules
    { rule_any = { class = { "Firefox", "Iceweasel", "Chromium", "Chrome", "IceCat", "Icecat", "uzbl-tabbed", "qutebrowser" } },
        properties = { tag = tags[1][2] }},

    -- Tag 3 rules
    { rule_any = { class = { "Thunar" } , name = { "ranger" }  },
        properties = { tag = tags[1][3] } },

    -- Tag 4 rules
    { rule_any = { name = { "Spotify", "moc" }, class = { "Spotify", "spotify", "moc" }  },
        properties = { tag = tags[1][4] } },

    -- Tag 5 rules
    { rule_any = { name = { "rtorrent", "rTorrent" }  },
        properties = { tag = tags[1][5] } },

    -- Tag 6 rules
    { rule_any = { class = { "Gimp", "Inkscape", "libreoffice", "VirtualBox", "Gtkpod", "Szamlazo.exe" }, instance = { "Szamlazo.exe" } },
        properties = { tag = tags[1][6] } },

    -- Tag 7 rules
    { rule_any = { name = { "mutt" } },
        properties = { tag = tags[1][7] } },

     -- Tag 8 rules
    { rule_any = { class = { "dosbox" }, name = { "WineGame", "newsbeuter" } },
        properties = { tag = tags[1][8] } },

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
                              c.class == "Gcolor2" or
                              c.class == "Gifview" or
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

-- Focus highlight/border
-- Based on: http://blog.lazut.in/2012/11/awesome-wm-remove-border-from-maximized.html
client.connect_signal("focus",
        function(c)
                -- Disable focus highlight for Firefox
                --if c.class == "Firefox" then
                        --c.border_width = "0"
                        --c.border_color = beautiful.border_focus
                --else
                        c.border_width = beautiful.border_width
                        c.border_color = beautiful.border_focus
                --end
        end)

--client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
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
