-- Global variables for luakit
globals = {
    homepage            = "file://" .. luakit.data_dir .. "/newtab/newtab.html",
    max_cmd_history     = 100,
    max_srch_history    = 100,
    default_window_size = "800x600",
    show_scrollbars     = true,  -- defined in rc.lua
    show_tablist        = true,  -- defined in window.lua

 -- http_proxy          = "http://example.com:3128",
 -- Disables loading of hostnames from /etc/hosts (for large host files)
 -- load_etc_hosts      = false,
 -- Disables checking if a filepath exists in search_open function
 -- check_filepath      = false,
}

-- Make useragent
local _, arch = luakit.spawn_sync("uname -sm")
-- Only use the luakit version if in date format (reduces identifiability)
local lkv = string.match(luakit.version, "^(%d+.%d+.%d+)")
globals.useragent = string.format("Mozilla/5.0 (%s) AppleWebKit/%s+ (KHTML, like Gecko) WebKitGTK+/%s luakit%s",
    string.sub(arch, 1, -2), luakit.webkit_user_agent_version,
    luakit.webkit_version, (lkv and ("/" .. lkv)) or "")

-- Search common locations for a ca file which is used for ssl connection validation.
local ca_files = {
    -- $XDG_DATA_HOME/luakit/ca-certificates.crt
    luakit.data_dir .. "/ca-certificates.crt",
    "/etc/certs/ca-certificates.crt",
    "/etc/ssl/certs/ca-certificates.crt",
}
-- Use the first ca-file found
for _, ca_file in ipairs(ca_files) do
    if os.exists(ca_file) then
        soup.ssl_ca_file = ca_file
        break
    end
end

-- Change to stop navigation sites with invalid or expired ssl certificates
soup.ssl_strict = false

-- Set cookie acceptance policy
cookie_policy = { always = 0, never = 1, no_third_party = 2 }
soup.accept_policy = cookie_policy.always

-- List of search engines. Each item must contain a single %s which is
-- replaced by URI encoded search terms. All other occurances of the percent
-- character (%) may need to be escaped by placing another % before or after
-- it to avoid collisions with lua's string.format characters.
-- See: http://www.lua.org/manual/5.1/manual.html#pdf-string.format
search_engines = {
    apkg    = "https://www.archlinux.org/packages/?q=%s",
    aur     = "https://aur.archlinux.org/packages/?O=0&K=%s",
    aw      = "https://wiki.archlinux.org/index.php?search=%s&go=Go",
    ddg     = "https://duckduckgo.com/?q=%s",
    g       = "https://google.com/search?q=%s",
    gh      = "https://github.com/search?q=%s",
    yt      = "https://www.youtube.com/results?search_query=%s",
    imdb    = "http://www.imdb.com/find?s=all&q=%s",
    kat     = "https://kat.cr/usearch/?q=%s",
    rarbg   = "https://rarbg.to/torrents.php?search=%s",
    wiki    = "https://en.wikipedia.org/wiki/Special:Search?search=%s",
}

-- Default search engine
search_engines.default = search_engines.ddg

-- Use this instead to disable auto-searching
--search_engines.default = "%s"

-- Per-domain webview properties
-- See http://webkitgtk.org/reference/webkitgtk/stable/WebKitWebSettings.html
domain_props = {

    ["all"] = {
        enable_spell_checking   = true,
        spell_checking_languages = "hu_HU",
        enable_html5_database = false,
        enable_html5_local_storage = false,
        enable_hyperlink_auditing = false,
        enable_java_applet = false,
        enable_media_stream = false,
        enable_mediasource = false,
        enable_offline_web_application_cache = false,
        javascript_can_access_clipboard = false,
        javascript_can_open_windows_automatically = false,
    },

    ["body.builder.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/body_builder_hu.css",
    },

    ["imdb.com"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/imdb.css",
    },

    ["imgur.com"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/imgur.css",
    },

    ["logout.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/logout_hu.css",
    },

    ["port.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/port_hu.css",
    },

    ["youtube.com"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/youtube.css",
    },

    ["m.youtube.com"] = {
        user_agent = "Mozilla/5.0 (iPad; CPU OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3",
    },


}

-- vim: et:sw=4:ts=8:sts=4:tw=80
