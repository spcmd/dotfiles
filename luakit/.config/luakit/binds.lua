-----------------
-- Keybindings --
-----------------

-- Binding aliases
local key, buf, but = lousy.bind.key, lousy.bind.buf, lousy.bind.but
local cmd, any = lousy.bind.cmd, lousy.bind.any

-- Util aliases
local match, join = string.match, lousy.util.table.join
local strip, split = lousy.util.string.strip, lousy.util.string.split

-- Globals or defaults that are used in binds
local scroll_step = 75
local mouse_scroll_step = 75
local zoom_step = 0.1
local quick_scroll_step = 150
local huge_scroll_step = 350

-- Add binds to a mode
function add_binds(mode, binds, before)
    assert(binds and type(binds) == "table", "invalid binds table type: " .. type(binds))
    mode = type(mode) ~= "table" and {mode} or mode
    for _, m in ipairs(mode) do
        local mdata = get_mode(m)
        if mdata and before then
            mdata.binds = join(binds, mdata.binds or {})
            elseif mdata then
                mdata.binds = mdata.binds or {}
                for _, b in ipairs(binds) do table.insert(mdata.binds, b) end
            else
                new_mode(m, { binds = binds })
            end
        end
end

-- Add commands to command mode
function add_cmds(cmds, before)
    add_binds("command", cmds, before)
end

-- Adds the default menu widget bindings to a mode
menu_binds = {
    -- Navigate items
    key({},          "j",       function (w) w.menu:move_down() end),
    key({},          "k",       function (w) w.menu:move_up()   end),
    key({},          "Down",    function (w) w.menu:move_down() end),
    key({},          "Up",      function (w) w.menu:move_up()   end),
    key({},          "Tab",     function (w) w.menu:move_down() end),
    key({"Shift"},   "Tab",     function (w) w.menu:move_up()   end),
}

-------------------------------
--- All modes Keybindings ---
-------------------------------
add_binds("all", {
    key({}, "Escape", "Return to `normal` mode.",
    function (w) w:set_mode() end),

    -- Mouse bindings
    but({}, 8, "Go back.",
    function (w) w:back() end),

    but({}, 9, "Go forward.",
    function (w) w:forward() end),

    -- Open link in new tab or navigate to selection
    but({}, 2, [[Open link under mouse cursor in new tab or navigate to the
    contents of `luakit.selection.primary`.]],
    function (w, m)
        -- Ignore button 2 clicks in form fields
        if not m.context.editable then
            -- Open hovered uri in new tab
            local uri = w.view.hovered_uri
            if uri then
                w:new_tab(uri, false)
                --else -- Open selection in current tab
                --uri = luakit.selection.primary
                --if uri then w:navigate(w:search_open(uri)) end
            end
        end
    end),

    -- Open link in new tab when Ctrl-clicked.
    but({"Control"}, 1, "Open link under mouse cursor in new tab.",
    function (w, m)
        local uri = w.view.hovered_uri
        if uri then
            w:new_tab(uri, false)
        end
    end),

    -- Zoom binds
    but({"Control"}, 4, "Increase text zoom level.",
    function (w, m) w:zoom_in() end),

    but({"Control"}, 5, "Reduce text zoom level.",
    function (w, m) w:zoom_out() end),

    -- Mouse Scroll
    but({}, 4, "Scroll up.",
    function (w) w:scroll{ yrel = -mouse_scroll_step } end),

    but({}, 5, "scroll down.",
    function (w) w:scroll{ yrel = mouse_scroll_step } end),

    -- Mouse Quick Scroll
    but({"Shift"}, 4, "Quick Scroll up.",
    function (w) w:scroll{ yrel = -quick_scroll_step } end),

    but({"Shift"}, 5, "Quick scroll down.",
    function (w) w:scroll{ yrel = quick_scroll_step } end),

    -- Mouse Quick Scroll
    but({"Control", "Shift"}, 4, "Huge Scroll up.",
    function (w) w:scroll{ yrel = -huge_scroll_step } end),

    but({"Control", "Shift"}, 5, "Huge scroll down.",
    function (w) w:scroll{ yrel = huge_scroll_step } end),


})

-------------------------------
--- Normal mode Keybindings ---
-------------------------------

add_binds("normal", {
    -- Autoparse the `[count]` before a binding and re-call the hit function
    -- with the count removed and added to the opts table.
    any([[Meta-binding to detect the `^[count]` syntax. The `[count]` is parsed
    and stripped from the internal buffer string and the value assigned to
    `state.count`. Then `lousy.bind.hit()` is re-called with the modified
    buffer string & original modifier state.

    #### Example binding

    lousy.bind.key({}, "%", function (w, state)
        w:scroll{ ypct = state.count }
    end, { count = 0 })

    This binding demonstrates several concepts. Firstly that you are able to
    specify per-binding default values of `count`. In this case if the user
    types `"%"` the document will be scrolled vertically to `0%` (the top).

    If the user types `"100%"` then the document will be scrolled to `100%`
        (the bottom). All without the need to use `lousy.bind.buf` bindings
        everywhere and or using a `^(%d*)` pattern prefix on every binding which
        would like to make use of the `[count]` syntax.]],
        function (w, m)
            local count, buf
            if m.buffer then
                count = string.match(m.buffer, "^(%d+)")
            end
            if count then
                buf = string.sub(m.buffer, #count + 1, (m.updated_buf and -2) or -1)
                local opts = join(m, {count = tonumber(count)})
                opts.buffer = (#buf > 0 and buf) or nil
                if lousy.bind.hit(w, m.binds, m.mods, m.key, opts) then
                    return true
                end
            end
            return false
        end),

        key({}, "i", "Enter `insert` mode.",
        function (w) w:set_mode("insert")  end),

        key({}, ":", "Enter `command` mode.",
        function (w) w:set_mode("command") end),

        -- Scrolling
        key({}, "j", "Scroll document down.",
        function (w) w:scroll{ yrel =  scroll_step } end),

        key({}, "k", "Scroll document up.",
        function (w) w:scroll{ yrel = -scroll_step } end),

        key({}, "J", "Quick-Scroll document down.",
        function (w) w:scroll{ yrel = quick_scroll_step } end),

        key({}, "K", "Quick-Scroll document up.",
        function (w) w:scroll{ yrel = -quick_scroll_step } end),

        key({"Control", "Shift"}, "J", "Huge-Scroll document down.",
        function (w) w:scroll{ yrel = huge_scroll_step } end),

        key({"Control", "Shift"}, "K", "Huge-Scroll document up.",
        function (w) w:scroll{ yrel = -huge_scroll_step } end),

        key({}, "h", "Scroll document left.",
        function (w) w:scroll{ xrel = -scroll_step } end),

        key({}, "l", "Scroll document right.",
        function (w) w:scroll{ xrel =  scroll_step } end),

        key({}, "Down", "Scroll document down.",
        function (w) w:scroll{ yrel =  scroll_step } end),

        key({}, "Up",   "Scroll document up.",
        function (w) w:scroll{ yrel = -scroll_step } end),

        key({}, "Left", "Scroll document left.",
        function (w) w:scroll{ xrel = -scroll_step } end),

        key({}, "Right", "Scroll document right.",
        function (w) w:scroll{ xrel =  scroll_step } end),

        key({}, "^", "Scroll to the absolute left of the document.",
        function (w) w:scroll{ x =  0 } end),

        key({}, "$", "Scroll to the absolute right of the document.",
        function (w) w:scroll{ x = -1 } end),

        key({}, "0", "Scroll to the absolute left of the document.",
        function (w, m)
            if not m.count then w:scroll{ y = 0 } else return false end
        end),

        key({}, "Page_Down", "Scroll page down.",
        function (w) w:scroll{ ypagerel =  1.0 } end),

        key({}, "Page_Up", "Scroll page up.",
        function (w) w:scroll{ ypagerel = -1.0 } end),

        key({}, "Home", "Go to the end of the document.",
        function (w) w:scroll{ y =  0 } end),

        key({}, "End", "Go to the top of the document.",
        function (w) w:scroll{ y = -1 } end),

        -- Specific scroll
        buf("^gg$", "Go to the top of the document.",
        function (w, b, m) w:scroll{ ypct = m.count } end, {count=0}),

        buf("^G$", "Go to the bottom of the document.",
        function (w, b, m) w:scroll{ ypct = m.count } end, {count=100}),

        buf("^%%$", "Go to `[count]` percent of the document.",
        function (w, b, m) w:scroll{ ypct = m.count } end),

        -- Zooming
        key({}, "+", "Enlarge text zoom of the current page.",
        function (w, m) w:zoom_in(zoom_step * m.count) end, {count=1}),

        key({}, "-", "Reduce text zom of the current page.",
        function (w, m) w:zoom_out(zoom_step * m.count) end, {count=1}),

        key({}, "=", "Reset zoom level.",
        function (w, m) w:zoom_set() end),

        buf("^z[iI]$", [[Enlarge text zoom of current page with `zi` or `zI` to
        reduce full zoom.]],
        function (w, b, m)
            w:zoom_in(zoom_step  * m.count, b == "zI")
        end, {count=1}),

        buf("^z[oO]$", [[Reduce text zoom of current page with `zo` or `zO` to
        reduce full zoom.]],
        function (w, b, m)
            w:zoom_out(zoom_step * m.count, b == "zO")
        end, {count=1}),

        -- Zoom reset or specific zoom ([count]zZ for full content zoom)
        buf("^z[zZ]$", [[Set current page zoom to `[count]` percent with
        `[count]zz`, use `[count]zZ` to set full zoom percent.]],
        function (w, b, m)
            w:zoom_set(m.count/100, b == "zZ")
        end, {count=100}),

        -- Fullscreen
        key({}, "F11", "Toggle fullscreen mode.",
            function (w) w.win.fullscreen = not w.win.fullscreen end),

        -- Yanking
        key({}, "y", "Yank current URI to clipboard.",
            function (w)
                local uri = string.gsub(w.view.uri or "", " ", "%%20")
                luakit.selection.clipboard = uri
                w:notify("Yanked uri: " .. uri)
            end),

        -- Commands
        key({}, "o", "Open one or more URLs.",
            function (w) w:enter_cmd(":open ") end),

        key({}, "t", "Open one or more URLs in a new tab.",
            function (w) w:enter_cmd(":tabopen ") end),

        --key({}, "w", "Open one or more URLs in a new window.",
            --function (w) w:enter_cmd(":winopen ") end),

        key({}, "O", "Open one or more URLs based on current location.",
            function (w) w:enter_cmd(":open " .. (w.view.uri or "")) end),

        key({}, "T", "Open one or more URLs based on current location in a new tab.",
            function (w) w:enter_cmd(":tabopen " .. (w.view.uri or "")) end),

        --key({}, "W",
            --"Open one or more URLs based on current locaton in a new window.",
            --function (w) w:enter_cmd(":winopen " .. (w.view.uri or "")) end),

        key({}, "w", "Toogle Web Inspector",
            function (w) w:enter_cmd(":inspect!") w:activate() end),

        -- History
        key({}, "H", "Go back in the browser history `[count=1]` items.",
            function (w, m) w:back(m.count) end),

        key({}, "Backspace", "Go back in the browser history `[count=1]` items.",
            function (w, m) w:back(m.count) end),

        key({}, "L", "Go forward in the browser history `[count=1]` times.",
            function (w, m) w:forward(m.count) end),

        key({}, "XF86Back", "Go back in the browser history.",
            function (w, m) w:back(m.count) end),

        key({}, "XF86Forward", "Go forward in the browser history.",
            function (w, m) w:forward(m.count) end),

        -- Tab
        key({"Control"}, "Page_Up", "Go to previous tab.",
            function (w) w:prev_tab() end),

        key({"Control"}, "Page_Down", "Go to next tab.",
            function (w) w:next_tab() end),

        key({"Control"}, "Tab", "Go to next tab.",
            function (w) w:next_tab() end),

        key({"Shift","Control"}, "Tab", "Go to previous tab.",
            function (w) w:prev_tab() end),

        buf("^ő$", "Go to previous tab.",
            function (w) w:prev_tab() end),

        buf("^ú$", "Go to next tab (or `[count]` nth tab).",
            function (w, b, m)
                if not w:goto_tab(m.count) then w:next_tab() end
            end, {count=0}),

        buf("^g0$", "Go to first tab.",
            function (w) w:goto_tab(1) end),

        buf("^g$$", "Go to last tab.",
            function (w) w:goto_tab(-1) end),

        key({"Control"}, "t", "Open a new tab.",
            function (w) w:new_tab(globals.homepage) end),

        key({}, "d", "Close current tab (or `[count]` tabs).",
            function (w, m) for i=1,m.count do w:close_tab() end end, {count=1}),

        key({}, "é", "Reorder tab left `[count=1]` positions.",
            function (w, m)
                w.tabs:reorder(w.view, w.tabs:current() - m.count)
            end, {count=1}),

        key({}, "á", "Reorder tab right `[count=1]` positions.",
            function (w, m)
                w.tabs:reorder(w.view,
                    (w.tabs:current() + m.count) % w.tabs:count())
            end, {count=1}),

        buf("^gH$", "Open homepage in new tab.",
            function (w) w:new_tab(globals.homepage) end),

        buf("^gh$", "Open homepage.",
            function (w) w:navigate(globals.homepage) end),

        buf("^gy$", "Duplicate current tab.",
            function (w) w:new_tab(w.view.history or "") end),

        key({}, "r", "Reload current tab.",
            function (w) w:reload() end),

        key({}, "R", "Reload current tab (skipping cache).",
            function (w) w:reload(true) end),

        key({}, "s", "Stop loading the current tab.",
            function (w) w.view:stop() end),

        key({"Control", "Shift"}, "r", "Restart luakit (reloading configs).",
            function (w) w:restart() end),

        -- Copy (ctrl-c)
        key({"Control"}, "c", "Copy (as-in control-c control-v)",
            function (w) luakit.selection.clipboard = luakit.selection.primary end),

        -- Window
        buf("^ZZ$", "Quit and save the session.",
            function (w) w:save_session() w:close_win() end),

        buf("^ZQ$", "Quit and don't save the session.",
            function (w) w:close_win() end),

        -- enter passthrough mode
        key({"Control"}, "z", "Enter `passthrough` mode, ignores all luakit keybindings.",
            function (w) w:set_mode("passthrough") end),

        ------- added key bindings --------

        buf("^D$",  "Show downloads page",
            function (w) w:new_tab("luakit://downloads") end),

        buf("^B$",  "Show bookmarks page",
            function (w) w:new_tab("luakit://bookmarks") end),

        buf("^gl$", "Go to logout.hu forum.",
            function (w) w:navigate("http://logout.hu/forum/index.html") end),

        buf("^gL$", "Go to logout.hu forum in a new tab.",
            function (w) w:new_tab("http://logout.hu/forum/index.html") end),

        buf("^gd$", "Go to my dotfiles repo",
            function (w) w:navigate("https://github.com/spcmd/dotfiles") end),

        buf("^gD$", "Go to my dotfiles repo in a new tab.",
            function (w) w:new_tab("https://github.com/spcmd/dotfiles") end),

        buf("^gs$", "Go to my scripts repo",
            function (w) w:navigate("https://github.com/spcmd/scripts") end),

        buf("^gS$", "Go to my scripts repo in a new tab.",
            function (w) w:new_tab("https://github.com/spcmd/scripts") end),

        buf("^,t$", "Translate selected text (quick, first result)",
            function (w)
                w:enter_cmd(":translate-selected-quick")
                w:activate()
            end),

        buf("^,T$", "Translate selected text (full, all results in terminal)",
            function (w)
                w:enter_cmd(":translate-selected-full")
                w:activate()
            end),

        buf("Y", "PH!: Copy the current url and make a forum link tag from it",
            function (w)
                w:enter_cmd(":phlinkformat")
                w:activate()
            end),

        buf("^,ua$", "Toggle useragent string",
            function (w)
                local ua = globals.useragent
                if not ua:match("Firefox") then
                    w:enter_cmd(":ua firefox")
                    w:activate()
                else
                    w:enter_cmd(":ua default")
                    w:activate()
                end
            end),


})


-------------------------------
--- Insert mode Keybindings ---
-------------------------------

add_binds("insert", {
    key({"Control"}, "z", "Enter `passthrough` mode, ignores all luakit keybindings.",
        function (w) w:set_mode("passthrough") end),

})

------------------------------------
--- Added Keybindings for Follow ---
------------------------------------

-- Hint mode for playing videos with a mediaplayer (mpv)
-- Source: https://bbs.archlinux.org/viewtopic.php?id=197393
-- if you want to use the ';' prefix key before the 'm' key
-- like with the other follow modes, then use 'ex-follow'
-- instead of 'normal" after the 'add_binds'

add_binds("normal", {

    key({}, "m", [[Hint all links (as defined by the `follow.selectors.uri`
        selector) and set the primary selection to the matched elements URI,
        so that an external app can open it]],
        function (w)
            w:set_mode("follow", {
                prompt = "video", selector = "uri", evaluator = "uri",
                func = function (uri)
                    assert(type(uri) == "string")
                    uri = string.gsub(uri, " ", "%%20")
                    luakit.selection.primary = uri
                    if string.match(uri, "youtube") or string.match(uri, "youtu.be") then
                        luakit.spawn(string.format("url2mpv.sh %s", uri))
                        --w:notify("Playing with mpv: " .. uri)
                    elseif string.match(uri, "vimeo") then
                        luakit.spawn(string.format("url2mpv.sh %s", uri))
                        --w:notify("Playing with mpv: " .. uri)
                    else
                        w:notify("Can't play this url with mpv.")
                    end
                end
            })
        end),


})


-------------------------------
--- Readline Keybindings ---
-------------------------------

readline_bindings = {
    key({"Shift"}, "Insert", "Insert contents of primary selection at cursor position.",
        function (w) w:insert_cmd(luakit.selection.primary) end),

    key({"Control"}, "d", "Delete previous word.",
        function (w) w:del_word() end),

    key({"Control"}, "l", "Delete until beginning of current line.",
        function (w) w:del_line() end),

    key({"Control"}, "i", "Move cursor to beginning of current line.",
        function (w) w:beg_line() end),

    key({"Control"}, "a", "Move cursor to end of current line.",
        function (w) w:end_line() end),

    key({"Control"}, "w", "Move cursor forward one word.",
        function (w) w:forward_word() end),

    key({"Control"}, "b", "Move cursor backward one word.",
        function (w) w:backward_word() end),
}

add_binds({"command", "search"}, readline_bindings)

-- Switching tabs with Mod1+{1,2,3,...}
mod1binds = {}
for i=1,10 do
    table.insert(mod1binds,
        key({"Mod1"}, tostring(i % 10), "Jump to tab at index "..i..".",
            function (w) w.tabs:switch(i) end))
end
add_binds("normal", mod1binds)

-------------------------------
--- Commands ---
-------------------------------

-- Command bindings which are matched in the "command" mode from text
-- entered into the input bar.
add_cmds({
    buf("^%S+!",
        [[Detect bang syntax in `:command!` and recursively calls
        `lousy.bind.match_cmd(..)` removing the bang from the command string
        and setting `bang = true` in the bind opts table.]],
        function (w, cmd, opts)
            local cmd, args = string.match(cmd, "^(%S+)!+(.*)")
            if cmd then
                opts = join(opts, { bang = true })
                return lousy.bind.match_cmd(w, opts.binds, cmd .. args, opts)
            end
        end),

    cmd("c[lose]", "Close current tab.",
        function (w) w:close_tab() end),

    cmd("print", "Print current page.",
        function (w) w.view:eval_js("print()") end),

    cmd("stop", "Stop loading.",
        function (w) w.view:stop() end),

    cmd("reload", "Reload page",
        function (w) w:reload() end),

    cmd("restart", "Restart browser (reload config files).",
        function (w) w:restart() end),

    cmd("write", "Save current session.",
        function (w) w:save_session() end),

    cmd("noh[lsearch]", "Clear search highlighting.",
        function (w) w:clear_search() end),

    cmd("back", "Go back in the browser history `[count=1]` items.",
        function (w, a) w:back(tonumber(a) or 1) end),

    cmd("f[orward]", "Go forward in the browser history `[count=1]` items.",
        function (w, a) w:forward(tonumber(a) or 1) end),

    cmd("inc[rease]", "Increment last number in URL.",
        function (w, a) w:navigate(w:inc_uri(tonumber(a) or 1)) end),

    cmd("o[pen]", "Open one or more URLs.",
        function (w, a) w:navigate(w:search_open(a)) end),

    cmd("t[abopen]", "Open one or more URLs in a new tab.",
        function (w, a) w:new_tab(w:search_open(a)) end),

    cmd("w[inopen]", "Open one or more URLs in a new window.",
        function (w, a) window.new{w:search_open(a)} end),

    cmd({"javascript", "js"}, "Evaluate JavaScript snippet.",
        function (w, a) w.view:eval_js(a) end),

    -- Tab manipulation commands
    cmd("tab", "Execute command and open result in new tab.",
        function (w, a) w:new_tab() w:run_cmd(":" .. a) end),

    cmd("tabd[o]", "Execute command in each tab.",
        function (w, a) w:each_tab(function (v) w:run_cmd(":" .. a) end) end),

    cmd("tabdu[plicate]", "Duplicate current tab.",
        function (w) w:new_tab(w.view.history) end),

    cmd("tabfir[st]", "Switch to first tab.",
        function (w) w:goto_tab(1) end),

    cmd("tabl[ast]", "Switch to last tab.",
        function (w) w:goto_tab(-1) end),

    cmd("tabn[ext]", "Switch to the next tab.",
        function (w) w:next_tab() end),

    cmd("tabp[revious]", "Switch to the previous tab.",
        function (w) w:prev_tab() end),

    cmd("q[uit]", "Close the current window.",
        function (w, a, o) w:close_win(o.bang) end),

    cmd({"viewsource", "vs"}, "View the source code of the current document.",
        function (w, a, o) w:toggle_source(not o.bang and true or nil) end),

    cmd({"wqall", "wq", "x"}, "Save the session and quit.",
        function (w, a, o) w:save_session() w:close_win(o.bang) end),

    cmd("lua", "Evaluate Lua snippet.", function (w, a)
        if a then
            local ret = assert(
                loadstring("return function(w) return "..a.." end"))()(w)
            if ret then print(ret) end
        else
            w:set_mode("lua")
        end
    end),

    cmd("dump", "Dump current tabs html to file.",
        function (w, a)
            local fname = string.gsub(w.win.title, '[^%w%.%-]', '_')..'.html' -- sanitize filename
            local file = a or luakit.save_file("Save file", w.win, xdg.download_dir or '.', fname)
            if file then
                local fd = assert(io.open(file, "w"), "failed to open: " .. file)
                local html = assert(w.view:eval_js("document.documentElement.outerHTML"), "Unable to get HTML")
                assert(fd:write(html), "unable to save html")
                io.close(fd)
                w:notify("Dumped HTML to: " .. file)
            end
        end),

    -- ADDED:
    cmd({"RR"}, "Restart luakit / Reload config",
        function (w) w:restart() end),

    cmd({"cookie-blacklist"}, "Edit the cookie.blacklist",
        function () luakit.spawn("urxvtc -e vim ".. cookies.blacklist_path) end),

    cmd({"cookie-whitelist"}, "Edit the cookie.whitelist",
        function () luakit.spawn("urxvtc -e vim ".. cookies.whitelist_path) end),

    cmd({"cookie-keeper"}, "Edit the cookie_keeper.list",
        function () luakit.spawn("urxvtc -e vim ".. luakit.config_dir.."/cookie_keeper.list") end),

    cmd({"cookie-clean"}, "Clean up the cookie database (keep only from cookie_keeper.list)",
        function (w)
            luakit.spawn("luakitwrapper -cc")  -- uses my luakitwrapper script
            w:notify("Cookies have been cleaned")
        end),

    cmd({"noscript-list"}, "List domain from the noscript database",
        function (w)
            local _, list = luakit.spawn_sync("luakitwrapper -ln") -- uses my luakitwrapper script
            w:notify(list)
        end),

    cmd({"noscript-toogle-scripts"}, "Toggle javascript permission for this domain",
        function (w) w:toggle_scripts() end),

    cmd({"noscript-toogle-plugins"}, "Toggle plugins permission for this domain",
        function (w) w:toggle_plugins() end),

    cmd({"noscript-remove-rules"}, "Remove noscript rules for this domain",
        function (w) w:toggle_remove() end),

    cmd({"scrollbars-hide"}, "Hide scrollbars (for this tab)",
        function (w) w.view.show_scrollbars = false end),

    cmd({"scrollbars-show"}, "Show scrollbars (for this tab)",
        function (w) w.view.show_scrollbars = true end),

    cmd({"history-clear"}, "Clear History entries older than x days",
        function (w, days)
            if days then
                local _, ch = luakit.spawn_sync("luakitwrapper -ch "..days) -- uses my luakitwrapper script
                w:notify(ch)
            else
                local _, ch = luakit.spawn_sync("luakitwrapper -ch") -- uses my luakitwrapper script
                w:notify(ch)
            end
        end),

    cmd({"userstyle-off"}, "Switch OFF userstyle (temporary for the current page)", -- works until page reload
        function (w)
            if w.view.user_stylesheet_uri ~= "" then
                w.view.user_stylesheet_uri = ""
            end
        end),

    cmd({"mailthis"}, "Create a mailthis command from the url and the title",
        function (w)
            local uri = w.view.uri
            local title = w.win.title:gsub("-.*", ""):gsub("^%s*(.-)%s*$", "%1") -- remove page name/uri and whitespaces from the title
            luakit.selection.clipboard = "mailthis '"..uri.."' '"..title.."'"
            w:notify("mailthis command copied to the clipboard.")
        end),

    cmd({"markdownlinkformat"}, "Create a markdown link format from the current uri and title",
        function (w)
            local uri = w.view.uri
            local title = w.win.title:gsub("-.*", ""):gsub("^%s*(.-)%s*$", "%1") -- remove page name/uri and whitespaces from the title
            local linktag = "["..title.."]("..uri..")"
            luakit.selection.clipboard = linktag
            w:notify("markdown link format copied to the clipboard.")
        end),

    -- Privoxy
    cmd({"privoxy-config"}, "Open Privoxy config", -- works until page reload
        function (w)
            w:new_tab("http://config.privoxy.org/show-status")
        end),

    -- Translate Shell (https://github.com/soimort/translate-shell)
    cmd({"translate-selected-quick"}, "Translate selected text (quick, first result)",
        function (w)
                local selected = luakit.selection.primary
                if not selected then
                    w:notify("Error: you didn't select any text.")
                else
                    local _, trans = luakit.spawn_sync("trans -b :hu "..selected)
                    w:notify(trans)
                end
        end),

    cmd({"translate-selected-full"}, "Translate selected text (full, all results in terminal)",
        function (w)
                local selected = luakit.selection.primary
                if not selected then
                    w:notify("Error: you didn't select any text.")
                else
                    local _, trans = luakit.spawn("urxvtc -hold -e trans :hu "..selected)
                end
        end),

    -- PH! Forum
    cmd({"ph"}, "PH!: search in the current topic",
        function (w, q)
            if q then
                local uri = w.view.uri
                local keyword = q
                local search_sub = "keres%.php%?type=-&stext="..keyword
                local search_uri = uri:gsub("hsz_.*%.html", search_sub):gsub("friss%.html", search_sub)
                w:navigate(search_uri)
            else
                w:notify("Error: keyword wasn't given.")
            end
        end),

    cmd({"phusercomment"}, "PH!: search user's comment [username] [keyword]",
        function (w, q)
            if q then
                query = {}
                for querystring in q:gmatch("%w+") do table.insert(query, querystring) end
                local username = query[1]
                local keyword = query[2]
                local uri = w.view.uri
                local search_sub = "keres%.php%?type=-&stext="..keyword.."&suser="..username
                local search_uri = uri:gsub("hsz_.*%.html", search_sub):gsub("friss%.html", search_sub)
                w:navigate(search_uri)
            else
                w:notify("Error: not enough parameters. 'keyword' and 'username' are needed!")
            end
        end),

    cmd({"phmy"}, "PH!: search in my comments",
        function (w, q)
         if q then
            local uri = w.view.uri
            local keyword = q
            local search_sub = "keres%.php%?type=-&stext="..keyword.."&suser=spammer"
            local search_uri = uri:gsub("hsz_.*%.html", search_sub):gsub("friss%.html", search_sub)
            w:navigate(search_uri)
        else
            w:notify("Error: keyword wasn't given.")
        end
    end),

    cmd({"phlinkformat"}, "PH!: Copy the current url and make a forum link tag from it",
        function (w)
            local uri = w.view.uri
            local title = w.win.title:gsub("-.*", ""):gsub("^%s*(.-)%s*$", "%1") -- remove page name/uri and whitespaces from the title
            local linktag = "[L:"..uri.."]"..title.."[/L]"
            luakit.selection.clipboard = linktag
            w:notify("PH forum link tag copied to the clipboard.")
        end),



})

-- vim: et:sw=4:ts=8:sts=4:tw=80
