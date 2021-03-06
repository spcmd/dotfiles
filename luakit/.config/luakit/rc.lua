-----------------------------------------------------------------------
-- luakit configuration file, more information at http://luakit.org/ --
-----------------------------------------------------------------------

require "lfs"

if unique then
    unique.new("org.luakit")
    -- Check for a running luakit instance
    if unique.is_running() then
        if uris[1] then
            for _, uri in ipairs(uris) do
                if lfs.attributes(uri) then uri = os.abspath(uri) end
                unique.send_message("tabopen " .. uri)
            end
        else
            unique.send_message("winopen")
        end
        luakit.quit()
    end
end

-- Load library of useful functions for luakit
require "lousy"

-- Small util functions to print output (info prints only when luakit.verbose is true)
function warn(...) io.stderr:write(string.format(...) .. "\n") end
function info(...) if luakit.verbose then io.stdout:write(string.format(...) .. "\n") end end

-- Load users global config
-- ("$XDG_CONFIG_HOME/luakit/globals.lua" or "/etc/xdg/luakit/globals.lua")
require "globals"

-- Load users theme
-- ("$XDG_CONFIG_HOME/luakit/theme.lua" or "/etc/xdg/luakit/theme.lua")
lousy.theme.init(lousy.util.find_config("theme.lua"))
theme = assert(lousy.theme.get(), "failed to load theme")

-- Load users window class
-- ("$XDG_CONFIG_HOME/luakit/window.lua" or "/etc/xdg/luakit/window.lua")
require "window"

-- Load users webview class
-- ("$XDG_CONFIG_HOME/luakit/webview.lua" or "/etc/xdg/luakit/webview.lua")
require "webview"

-- Load users mode configuration
-- ("$XDG_CONFIG_HOME/luakit/modes.lua" or "/etc/xdg/luakit/modes.lua")
require "modes"

-- Load users keybindings
-- ("$XDG_CONFIG_HOME/luakit/binds.lua" or "/etc/xdg/luakit/binds.lua")
require "binds"

----------------------------------
-- Optional user script loading --
----------------------------------

-- Web Inspector tool
require "webinspector"

-- Add sqlite3 cookiejar
require "cookies"

-- Cookie blocking by domain (extends cookies module)
-- Add domains to the whitelist at "$XDG_CONFIG_HOME/luakit/cookie.whitelist"
-- and blacklist at "$XDG_CONFIG_HOME/luakit/cookie.blacklist".
-- Each domain must be on it's own line and you may use "*" as a
-- wildcard character (I.e. "*google.com")
require "cookie_blocking"

-- Block all cookies by default (unless whitelisted)
cookies.default_allow = false

-- Store cookies on disk (save cookies)
cookies.force_session_timeout = false
cookies.store_session_cookies = true

-- Cookie expiration
cookies.session_timeout = 3600 * 24 * 7 * 4

-- Add uzbl-like form filling
--require "formfiller"

-- Add proxy support & manager
require "proxy"

-- Add quickmarks support & manager
--require "quickmarks"

-- Add session saving/loading support
require "session"

-- Add command to list closed tabs & bind to open closed tabs
require "undoclose"

-- Add command to list tab history items
require "tabhistory"

-- Add greasemonkey-like javascript userscript support
require "userscripts"

-- Add bookmarks support
require "bookmarks"
require "bookmarks_chrome"

-- Add download support
require "downloads"
require "downloads_chrome"

downloads.default_dir = os.getenv("HOME") .. "/Downloads"

-- Download to the default directory, do not ask where to save
downloads.add_signal("download-location", function (uri, file)
    if not file or file == "" then
        file = (string.match(uri, "/([^/]+)$")
        or string.match(uri, "^%w+://(.+)")
        or string.gsub(uri, "/", "_")
        or "untitled")
    -- ADDED: privoxy fix for youtube, google, facebook and other sites:
    -- prevent opening a save file dialog when privoxy blocks some tracking stuff
    elseif file:match("^ads$") or
           file:match("tile=1") or
           file:match("usermatch") or
           file:match("like") or
           file:match("ping") or
           file:match("iframe") or
           file:match(".js") or
           file:match(".php") or
           file:match("ns.html") or
           file:match("tags") or
           file:match("aff_ad") or
           file:match("iu3") or
           file:match("pd") or
           file:match("xd_arbiter")
    then
        return false
    end
    return downloads.default_dir .. "/" .. file
end)

-- Add ablock support
--require "adblock"
--require "adblock_chrome"

-- Example using xdg-open for opening downloads / showing download folders
--downloads.add_signal("open-file", function (file, mime)
--    luakit.spawn(string.format("xdg-open %q", file))
--    return true
--end)

-- Add vimperator-like link hinting & following
require "follow"

-- Use a custom charater set for hint labels
local s = follow.label_styles
follow.label_maker = s.sort(s.reverse(s.charset("hjklasdfgrtzu")))

-- Match only hint labels
--follow.pattern_maker = follow.pattern_styles.match_label

-- Add command history
require "cmdhist"

-- Add search mode & binds
require "search"

-- Add ordering of new tabs
require "taborder"

-- Save web history
require "history"
require "history_chrome"

-- Help page
--require "introspector"

-- Add command completion
require "completion"

-- NoScript plugin, toggle scripts and or plugins on a per-domain basis.
-- `,ts` to toggle scripts, `,tp` to toggle plugins, `,tr` to reset.
-- Remove all "enable_scripts" & "enable_plugins" lines from your
-- domain_props table (in config/globals.lua) as this module will conflict.
require "noscript"
noscript.enable_scripts = false
noscript.enable_plugins = false

-- Follow selected text
require "follow_selected"

-- Go to the first input field (with 'gi' by default)
require "go_input"

-- Find prev/next links in pages and click them (quick navigation)
require "go_next_prev"

-- Go up in domain levels (quick navigation)
--require "go_up"

-- User-Agent Switcher
--require "uaswitch"

-----------------------------
-- ADDED Customizations --
-----------------------------

-- Scrollbar
if globals.show_scrollbars == true then
    webview.init_funcs.show_scrollbars = function(view)
        view.show_scrollbars = true
    end
end

-- Redirect youtube.com to m.youtube.com
--[[
webview.init_funcs.youtube_redirect = function (view, w)
    view:add_signal("navigation-request", function (v, uri)
        if string.match(uri, "^https://www%.youtube%.com/-$") then
            v.uri = "https://m.youtube.com/?app=m"
            return false
        end
        if string.match(uri, "www%.youtube%.com/watch%?v=") then
            v.uri = uri:gsub("www","m"):gsub("&app=desktop","&app=m")
            return false
        end
    end)
end
--]]

-- Play youtube video links with mpv
--[[
webview.init_funcs.youtube_to_mpv = function (view, w)
    view:add_signal("navigation-request", function (v, uri)
        --if string.match(uri, "www%.youtube%.com/watch%?v=") then
        if string.match(uri, "/watch%?v=") then
            luakit.spawn(string.format("%s %q", "url2mpv.sh", uri))
            --if not string.match(v.uri, "^https://www%.youtube%.com/") then
                --w:close_tab()
            --end
            return false
        end
    end)
end
--]]

-- Viewtube (http://isebaro.com/viewtube/)
--webview.init_funcs.viewtube_hook = function (view, w)
    --view:add_signal("navigation-request", function (v, uri)
        --if string.match(string.lower(uri), "^viewtube:") then
            --luakit.spawn(string.format("%s %q", "viewtube.sh", uri))
            --return false
        --end
    --end)
--end


-- Download mp3 rather than playing with the internal (embedded) player
webview.init_funcs.download_mp3 = function (view, w)
    view:add_signal("navigation-request", function (v, uri)
        if string.match(uri, "^.*%.mp3$") then
            w:enter_cmd(":download " .. uri) -- enter the download command
            w:activate() -- hit 'Enter' on the command
            w:close_tab() -- prevent playing with the internal player
            return false
        end
    end)
end

-- IT Cafe forum redirect to logout domain
webview.init_funcs.itcafe_to_logout = function (view, w)
    view:add_signal("navigation-request", function (v, uri)
        if string.match(uri, "https://itcafe.hu/tema/") then
            v.uri = uri:gsub("itcafe","logout")
            return false
        end
    end)
end

-- Open magnet links with rtorrent (pyrocore/mktor)
webview.init_funcs.magnet_hook = function (view, w)
    view:add_signal("navigation-request", function (v, uri)
        if string.match(string.lower(uri), "^magnet:") then
            luakit.spawn(string.format("%s %q", "mktor", uri))
            w:notify("magnet link sent to rTorrent by mktor")
            return false
        end
    end)
end

-----------------------------
-- End user script loading --
-----------------------------

-- Restore last saved session
local w = (session and session.restore())
if w then
    for i, uri in ipairs(uris) do
        w:new_tab(uri, i == 1)
    end
else
    -- Or open new window
    window.new(uris)
end

-------------------------------------------
-- Open URIs from other luakit instances --
-------------------------------------------

if unique then
    unique.add_signal("message", function (msg, screen)
        local cmd, arg = string.match(msg, "^(%S+)%s*(.*)")
        local w = lousy.util.table.values(window.bywidget)[1]
        if cmd == "tabopen" then
            w:new_tab(arg)
        elseif cmd == "winopen" then
            w = window.new((arg ~= "") and { arg } or {})
        end
        w.win.screen = screen
        w.win.urgency_hint = true
    end)
end

-- vim: et:sw=4:ts=8:sts=4:tw=80
