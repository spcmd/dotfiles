--------------------------
-- WebKit WebView class --
--------------------------

-- Webview class table
webview = {}

-- Table of functions which are called on new webview widgets.
webview.init_funcs = {
    -- Set useragent
    set_useragent = function (view, w)
        view.user_agent = globals.useragent
    end,

    -- Check if checking ssl certificates
    checking_ssl = function (view, w)
        local ca_file = soup.ssl_ca_file
        if ca_file and os.exists(ca_file) then
            w.checking_ssl = true
        end
    end,

    -- Update window and tab titles
    title_update = function (view, w)
        view:add_signal("property::title", function (v)
            w:update_tablist()
            if w.view == v then
                w:update_win_title()
            end
        end)
    end,

    -- Update uri label in statusbar
    uri_update = function (view, w)
        view:add_signal("property::uri", function (v)
            w:update_tablist()
            if w.view == v then
                w:update_uri()
            end
        end)
    end,

    -- Update history indicator
    hist_update = function (view, w)
        view:add_signal("load-status", function (v, status)
            if w.view == v then
                w:update_hist()
            end
        end)
    end,

    -- Update tab titles
    tablist_update = function (view, w)
        view:add_signal("load-status", function (v, status)
            if status == "provisional" or status == "finished" or status == "failed" then
                w:update_tablist()
            end
        end)
    end,

    -- Update scroll widget
    scroll_update = function (view, w)
        view:add_signal("expose", function (v)
            if w.view == v then
                w:update_scroll()
            end
        end)
    end,

    -- Update progress widget
    progress_update = function (view, w)
        for _, sig in ipairs({"load-status", "property::progress"}) do
            view:add_signal(sig, function (v)
                if w.view == v then
                    w:update_progress()
                    w:update_ssl()
                end
            end)
        end
    end,

    -- Display hovered link in statusbar
    link_hover_display = function (view, w)
        view:add_signal("link-hover", function (v, link)
            if w.view == v and link then
                w:update_uri(link)
            end
        end)
        view:add_signal("link-unhover", function (v)
            if w.view == v then
                w:update_uri()
            end
        end)
    end,

    -- Clicking a form field automatically enters insert mode.
    form_insert_mode = function (view, w)
        view:add_signal("button-press", function (v, mods, button, context)
            -- Clear start search marker
            (w.search_state or {}).marker = nil

            if button == 1 and context.editable then
                view:emit_signal("form-active")
            end
        end)
        -- Emit root-active event in button release to prevent "missing"
        -- buttons or links when the input bar hides.
        view:add_signal("button-release", function (v, mods, button, context)
            if button == 1 and not context.editable then
                view:emit_signal("root-active")
            end
        end)
        view:add_signal("form-active", function ()
            if not w.mode.passthrough then
                w:set_mode("insert")
            end
        end)
        view:add_signal("root-active", function ()
            if w.mode.reset_on_focus ~= false then
                w:set_mode()
            end
        end)
    end,

    -- Catch keys in non-passthrough modes
    mode_key_filter = function (view, w)
        view:add_signal("key-press", function ()
            if not w.mode.passthrough then
                return true
            end
        end)
    end,

    -- Try to match a button event to a users button binding else let the
    -- press hit the webview.
    button_bind_match = function (view, w)
        view:add_signal("button-release", function (v, mods, button, context)
            (w.search_state or {}).marker = nil
            if w:hit(mods, button, { context = context }) then
                return true
            end
        end)
    end,

    -- Reset the mode on navigation
    mode_reset_on_nav = function (view, w)
        view:add_signal("load-status", function (v, status)
            if status == "provisional" and w.view == v then
                if w.mode.reset_on_navigation ~= false then
                    w:set_mode()
                end
            end
        end)
    end,

    -- Domain properties
    domain_properties = function (view, w)
        view:add_signal("load-status", function (v, status)
            if status ~= "committed" or v.uri == "about:blank" then return end
            -- Get domain
            local domain = lousy.uri.parse(v.uri).host
            -- Strip leading www.
            domain = string.match(domain or "", "^www%.(.+)") or domain or "all"
            -- Build list of domain props tables to join & load.
            -- I.e. for luakit.org load .luakit.org, luakit.org, .org
            local props = {domain_props.all or {}, domain_props[domain] or {}}
            repeat
                table.insert(props, 2, domain_props["."..domain] or {})
                domain = string.match(domain, "%.(.+)")
            until not domain
            -- Join all property tables
            for k, v in pairs(lousy.util.table.join(unpack(props))) do
                info("Domain prop: %s = %s (%s)", k, tostring(v), domain)
                view[k] = v
            end
        end)
    end,

    -- Action to take on mime type decision request.
    mime_decision = function (view, w)
        -- Return true to accept or false to reject from this signal.
        view:add_signal("mime-type-decision", function (v, uri, mime)
            info("Requested link: %s (%s)", uri, mime)
            -- i.e. block binary files like *.exe
            --if mime == "application/octet-stream" then
            --    return false
            --end
        end)
    end,

    -- Action to take on window open request.
    --window_decision = function (view, w)
    --    view:add_signal("new-window-decision", function (v, uri, reason)
    --        if reason == "link-clicked" then
    --            window.new({uri})
    --        else
    --            w:new_tab(uri)
    --        end
    --        return true
    --    end)
    --end,

    create_webview = function (view, w)
        -- Return a newly created webview in a new tab
        view:add_signal("create-web-view", function (v)
            return w:new_tab()
        end)
    end,

    -- Creates context menu popup from table (and nested tables).
    -- Use `true` for menu separators.
    populate_popup = function (view, w)
        view:add_signal("populate-popup", function (v)
            -- ADDED: show selected text in the menu options
            if not luakit.selection.primary then
                highlighted = ""
            else
                highlighted = luakit.selection.primary
            end
            -- draw menu
            return {
                true,
                { "🗔 Open this page in Chromium", function () w:open_in_alt_browser() end },
                { "🖹 View Sour_ce", function () w:toggle_source() end },
                true,
                { "⊘ _Noscript", {
                    { "Toggle _Scripts",    function () w:toggle_scripts()  end },
                    { "Toggle _Plugins",   function () w:toggle_plugins() end },
                    true,
                    { "_Remove this domain", function () w:toggle_remove() end }, }, },
                true,
                { "🕮 Translate (quick): "..highlighted, function () w:enter_cmd(":translate-selected-quick") w:activate() end },
                { "🕮 Translate (full): "..highlighted, function () w:enter_cmd(":translate-selected-full") w:activate() end },
                true,
                { "🌊 Ma_gnet > _rTorrent", function () w:magnet_load() end },
                { "▶ Play with _mpv", function () w:mediaplayer() end },
                true,
                { "+ _Tabopen: "..highlighted, function () w:open_text_uri() end },
                { "🔍 _Search for: "..highlighted, function () w:lookup_selection() end },
            }
        end)
    end,

    -- Action to take on resource request.
    resource_request_decision = function (view, w)
        view:add_signal("resource-request-starting", function(v, uri)
            info("Requesting: %s", uri)
            -- Return false to cancel the request.
        end)
    end,
}

-- These methods are present when you index a window instance and no window
-- method is found in `window.methods`. The window then checks if there is an
-- active webview and calls the following methods with the given view instance
-- as the first argument. All methods must take `view` & `w` as the first two
-- arguments.
webview.methods = {
    -- Reload with or without ignoring cache
    reload = function (view, w, bypass_cache)
        if bypass_cache then
            view:reload_bypass_cache()
        else
            view:reload()
        end
    end,

    -- Toggle source view
    toggle_source = function (view, w, show)
        if show == nil then
            view.view_source = not view.view_source
        else
            view.view_source = show
        end
        view:reload()
    end,

    -- Zoom functions
    zoom_in = function (view, w, step, full_zoom)
        view.full_content_zoom = not not full_zoom
        step = step or globals.zoom_step or 0.1
        view.zoom_level = view.zoom_level + step
    end,

    zoom_out = function (view, w, step, full_zoom)
        view.full_content_zoom = not not full_zoom
        step = step or globals.zoom_step or 0.1
        view.zoom_level = math.max(0.01, view.zoom_level) - step
    end,

    zoom_set = function (view, w, level, full_zoom)
        view.full_content_zoom = not not full_zoom
        view.zoom_level = level or 1.0
    end,

    -- History traversing functions
    back = function (view, w, n)
        view:go_back(n or 1)
    end,

    forward = function (view, w, n)
        view:go_forward(n or 1)
    end,

    -- ADDED: Play link with mpv
    mediaplayer = function (view, w)
        local uri = w.view.hovered_uri or w.view.uri
        if string.match(uri, "youtube") or string.match(uri, "youtu.be") then
            luakit.spawn(string.format("url2mpv.sh %s", uri))
            --w:notify("Playing with mpv: " .. uri)
        elseif string.match(uri, "vimeo") then
            luakit.spawn(string.format("url2mpv.sh %s", uri))
            --w:notify("Playing with mpv: " .. uri)
        else
            w:notify("Can't play this url with mpv.")
        end
    end,

    -- ADDED: Lookup selected text with a search engine
    lookup_selection = function (view, w)
        -- replace spaces with '+' signs for the search string
        local stext = string.gsub(luakit.selection.primary, " ", "+")
        -- use the default search engine if it's set
        if search_engines.default then
            -- remove the '%s' from the end, because we use the selected text
            search_engine = string.gsub(search_engines.default, "%%s", "")
        else
            search_engine = "https://duckduckgo.com/?q="
        end
        w:new_tab(search_engine..stext)
    end,

    -- ADDED: Load megnet links to rtorrent
    magnet_load = function (wiew, w)
        local uri = w.view.hovered_uri
        if string.match(uri, "^magnet:") then
            -- magnet2rtorrent is my shell script
            luakit.spawn(string.format("magnet2rtorrent %s", uri))
        else
            w:notify("Error: this is not a magnet link.")
        end
    end,

    --ADDED: open selected (highlighted) text uri (which are not links)
    open_text_uri = function (view, w)
        local uri = luakit.selection.primary
        if string.match(uri, "^https*://.+%..+$") then
            w:new_tab(uri)
        else
            w:notify("Error: Can't open, it's not a valid uri.")
        end
    end,

    --ADDED: open this page in an alternative browser
    open_in_alt_browser = function (view, w)
        local uri = w.view.uri
        luakit.spawn(string.format("chromium --incognito %s", uri))
    end,


}

function webview.methods.scroll(view, w, new)
    local s = view.scroll
    for _, axis in ipairs{ "x", "y" } do
        -- Relative px movement
        if rawget(new, axis.."rel") then
            s[axis] = s[axis] + new[axis.."rel"]

        -- Relative page movement
        elseif rawget(new, axis .. "pagerel") then
            s[axis] = s[axis] + math.ceil(s[axis.."page_size"] * new[axis.."pagerel"])

        -- Absolute px movement
        elseif rawget(new, axis) then
            local n = new[axis]
            if n == -1 then
                s[axis] = s[axis.."max"]
            else
                s[axis] = n
            end

        -- Absolute page movement
        elseif rawget(new, axis.."page") then
            s[axis] = math.ceil(s[axis.."page_size"] * new[axis.."page"])

        -- Absolute percent movement
        elseif rawget(new, axis .. "pct") then
            s[axis] = math.ceil(s[axis.."max"] * (new[axis.."pct"]/100))
        end
    end
end

function webview.new(w)
    local view = widget{type = "webview"}

    view.show_scrollbars = false
    view.enforce_96_dpi = false

    -- Call webview init functions
    for k, func in pairs(webview.init_funcs) do
        func(view, w)
    end
    return view
end

-- Insert webview method lookup on window structure
table.insert(window.indexes, 1, function (w, k)
    if k == "view" then
        local view = w.tabs[w.tabs:current()]
        if view and type(view) == "widget" and view.type == "webview" then
            w.view = view
            return view
        end
    end
    -- Lookup webview method
    local func = webview.methods[k]
    if not func then return end
    local view = w.view
    if view then
        return function (_, ...) return func(view, w, ...) end
    end
end)

-- vim: et:sw=4:ts=8:sts=4:tw=80
