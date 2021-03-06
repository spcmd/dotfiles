-- Global variables for luakit
globals = {
    homepage            = "file://" .. luakit.data_dir .. "/newtab/newtab.html",
    max_cmd_history     = 100,
    max_srch_history    = 100,
    default_window_size = "800x600",
    show_scrollbars     = false,  -- defined in rc.lua
    show_tablist        = true,  -- defined in window.lua

--http_proxy          = "http://localhost:8118",
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
--globals.useragent = string.format("Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Firefox/38.0")

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
    aur     = "https://aur.archlinux.org/packages/?K=%s",
    aw      = "https://wiki.archlinux.org/index.php?search=%s",
    bh      = "http://bithumen.be/browse.php?search=%s",
    ddg     = "https://duckduckgo.com/?q=%s",
    g       = "https://google.com/search?q=%s",
    gh      = "https://github.com/search?q=%s",
    gr      = "https://www.goodreads.com/search?query=%s",
    imdb    = "http://www.imdb.com/find?s=all&q=%s",
    moly    = "https://moly.hu/kereses?q=%s",
    ph      = "http://logout.hu/temak/keres.php?type=-&stext=%s",
    rarbg   = "https://rarbg.to/torrents.php?search=%s",
    sztaki  = "http://szotar.sztaki.hu/search?fromlang=all&tolang=all&searchWord=%s",
    tpb     = "https://thepiratebay.se/search/%s",
    wiki    = "https://en.wikipedia.org/wiki/Special:Search?search=%s",
    wikihu  = "https://hu.wikipedia.org/wiki/Special:Search?search=%s",
    yt      = "https://www.youtube.com/results?search_query=%s",
}

-- Default search engine
search_engines.default = search_engines.ddg

-- Use this instead to disable auto-searching
--search_engines.default = "%s"

-- Per-domain webview properties
-- See http://webkitgtk.org/reference/webkitgtk/stable/WebKitWebSettings.html
domain_props = {

    ["all"] = {
        user_stylesheet_uri     = "",  -- reset stylesheet, deactivate userstyles left over from other domains.
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/global.css", -- input/textare fix for dark GTK themes
        monospace_font_family   = "Liberation Mono",
        sans_serif_font_family  = "Liberation Sans",
        serif_font_family       = "Liberation Serif",
        enable_spell_checking   = true,
        spell_checking_languages = "hu_HU",
        enable_html5_database = false,
        --enable_html5_local_storage = false,  -- breaks reddit!
        enable_hyperlink_auditing = false,
        enable_java_applet = false,
        enable_media_stream = false,
        enable_mediasource = false,
        enable_offline_web_application_cache = false,
        javascript_can_access_clipboard = false,
        javascript_can_open_windows_automatically = false,
        media_playback_requires_user_gesture = true,
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

    ["filmbuzi.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/filmbuzi_hu.css",
    },

    ["logout.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/logout_hu.css",
    },

["moly.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/moly_hu.css",
    },

    ["port.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/port_hu.css",
    },

    ["est.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/est_hu.css",
    },

    ["reddit.com"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/reddit.css",
    },

    ["sorozatjunkie.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/sorozatjunkie_hu.css",
    },

    --[[["translate.google.com"] = {]]
        --user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/google-translate.css",
    --[[},]]

    ["szotar.sztaki.hu"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/sztaki-szotar.css",
    },

    ["youtube.com"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/youtube.css",
    },

}

-- vim: et:sw=4:ts=8:sts=4:tw=80
