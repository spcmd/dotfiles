//***********************************************************************************************
//                                          FIREFOX TWEAKS
//***********************************************************************************************
//
//  Sources:
//  http://www.ghacks.net/2016/01/04/the-firefox-privacy-and-security-list-has-been-updated/
//  https://github.com/pyllyukko/user.js/blob/master/user.js
//  http://legroom.net/howto/firefox
//
//***********************************************************************************************


/****************************************************************************/
/*** STARTUP ***                                                            */
/****************************************************************************/

// 0101: disable "slow startup" options
   // warnings, disk history, welcomes, intros, EULA, default browser check
user_pref("browser.slowStartup.notificationDisabled", true);                            //no slow notice
user_pref("browser.slowStartup.maxSamples", 0);
user_pref("browser.slowStartup.samples", 0);
user_pref("browser.rights.3.shown", true);                                              //don't show EULA
user_pref("browser.startup.homepage_override.mstone", "ignore");                        //no upg. pages
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_override_url", "");
user_pref("browser.feeds.showFirstRunUI", false);
user_pref("browser.shell.checkDefaultBrowser", false);



/****************************************************************************/
/*** SECURITY / PRIVACY ***                                                 */
/****************************************************************************/

// 0201: disable location-aware browsing
user_pref("geo.enabled", false);
user_pref("geo.wifi.uri", "http://127.0.0.1");
user_pref("geo.wifi.logging.enabled", false);
user_pref("browser.search.geoip.url", "");

// Featured extensions for displaying in Get Add-ons panel
user_pref("extensions.webservice.discoverURL", "http://127.0.0.1");

// Telemetry
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
// 0330b: set unifiedIsOptIn to make sure telemetry respects OptIn choice and that telemetry
// is enabled ONLY for people that opted into it, even if unified Telemetry is enabled
user_pref("toolkit.telemetry.unifiedIsOptIn", true);
user_pref("toolkit.telemetry.cachedClientID", "");

// Health report
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.healthreport.documentServerURI", "");
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled.v2", false);

// 0340: disable experiments
    // https://wiki.mozilla.org/Telemetry/Experiments
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("experiments.activeExperiment", false);
// 0341: disable mozilla permission to silently opt you into tests
user_pref("network.allow-experiments", false);

// 0350: disable crash reports
user_pref("breakpad.reportURL", "");

// 0370: disable "Snippets" (Mozilla content shown on about:home screen)
    // https://wiki.mozilla.org/Firefox/Projects/Firefox_Start/Snippet_Service
    // MUST use HTTPS - arbitrary content injected into this page via http opens up MiTM attacks
user_pref("browser.aboutHomeSnippets.updateUrl", "https://127.0.0.1");

// 0371: disable "Heartbeat" (Mozilla user rating telemetry)
user_pref("browser.selfsupport.url", "");

// 0372: disable "Hello" (TokBox/Telefonica WebRTC voice & video call PUP) WebRTC (IP leak)
   // https://www.mozilla.org/en-US/privacy/firefox-hello/
   // https://security.stackexchange.com/questions/94284/how-secure-is-firefox-hello
user_pref("loop.enabled", false);
user_pref("loop.server", "");

// 0373: disable "Pocket" (third party "save for later" service) & remove urls for good measure
   // NOTE: Important: Remove the pocket icon from your toolbar first
   // https://www.gnu.gl/blog/Posts/multiple-vulnerabilities-in-pocket/
user_pref("browser.pocket.enabled", false);
user_pref("browser.pocket.api", "");
user_pref("browser.pocket.site", "");
user_pref("browser.pocket.oAuthConsumerKey", "");
user_pref("browser.toolbarbuttons.introduced.pocket-button", false);

// 0373a: disable "Reader View"
user_pref("reader.parse-on-load.enabled", false);

// 0374: disable "social" integration
   // https://developer.mozilla.org/en-US/docs/Mozilla/Projects/Social_API
user_pref("social.whitelist", "");
user_pref("social.toast-notifications.enabled", false);
user_pref("social.shareDirectory", "");
user_pref("social.remote-install.enabled", false);
user_pref("social.directories", "");
user_pref("social.share.activationPanelEnabled", false);

// 0402: disable "Block reported web forgeries" - PRIVACY
   // If true this compares visited URLs against a blacklist or submits URLs to a third party
   // to determine whether a site is legitimate. This setting is under Options>Security
user_pref("browser.safebrowsing.enabled", false);

// 0410: disable "Block reported attack sites" - PRIVACY
   // Safebrowsing uses locally stored data, but if the item is not found, then
   // google is contacted. This setting is under Options>Security
user_pref("browser.safebrowsing.malware.enabled", false);

// 0411: disable safebrowsing urls & download
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.reportPhishMistakeURL", "");
user_pref("browser.safebrowsing.reportPhishURL", "");
// 0411b: disable FF43+ safebrowsing urls
user_pref("browser.safebrowsing.provider.google.appRepURL", "");
user_pref("browser.safebrowsing.provider.google.gethashURL", "");
user_pref("browser.safebrowsing.provider.google.reportURL", "");
user_pref("browser.safebrowsing.provider.google.updateURL", "");
user_pref("browser.safebrowsing.provider.mozilla.gethashURL", "");
user_pref("browser.safebrowsing.provider.mozilla.updateURL", "");

// 0420: disable tracking protection
   // https://support.mozilla.org/en-US/kb/tracking-protection-firefox
   // I believe there are no privacy concerns here, but you are better off using an
   // extension such as uBlock Origin which is not decided by a third party (disconnect)
   // and which is far more effective (when used correctly)
user_pref("privacy.trackingprotection.enabled", false);
user_pref("browser.trackingprotection.gethashURL", "");
user_pref("browser.trackingprotection.getupdateURL", "");
user_pref("privacy.trackingprotection.pbmode.enabled", false);

// 1602: DNT HTTP header - essentially useless
   // http://kb.mozillazine.org/Privacy.donottrackheader.value (pref required since FF21+)
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.donottrackheader.value", 1);

// 0421: disable SSL Error Reporting - PRIVACY
   // https://gecko.readthedocs.org/en/latest/browser/base/sslerrorreport/preferences.html
user_pref("security.ssl.errorReporting.automatic", false);
user_pref("security.ssl.errorReporting.enabled", false);
user_pref("security.ssl.errorReporting.url", "");

// 2601: disable sending additional analytics to web servers
   // https://developer.mozilla.org/en-US/docs/Web/API/navigator.sendBeacon
user_pref("beacon.enabled", false);

// 2605: don't integrate activity into windows recent documents
user_pref("browser.download.manager.addToRecentDocs", false);

// disable cookies on all sites
   // you can set exceptions under site permissions or an extension (eg Cookie Controller)
   // 0=allow all 1=allow same host 2=disallow all 3=allow 3rd party if it already set a cookie
user_pref("network.cookie.cookieBehavior", 2);
user_pref("services.sync.prefs.sync.network.cookie.cookieBehavior", false);

// Feedback and report urls
user_pref("app.feedback.baseURL", "http://127.0.0.1");
user_pref("app.support.baseURL", "http://127.0.0.1");
user_pref("browser.safebrowsing.reportErrorURL", "http://127.0.0.1");
user_pref("browser.safebrowsing.reportGenericURL", "http://127.0.0.1");
user_pref("browser.safebrowsing.reportMalwareErrorURL", "http://127.0.0.1");
user_pref("browser.safebrowsing.reportMalwareURL", "http://127.0.0.1");
user_pref("datareporting.healthreport.about.reportUrl", "http://127.0.0.1");
user_pref("datareporting.healthreport.infoURL", "http://127.0.0.1");
user_pref("loop.feedback.baseUrl", "http://127.0.0.1");



/****************************************************************************/
/*** NETWORK ***                                                            */
/****************************************************************************/

// 0601: disable link prefetching
   // https://developer.mozilla.org/en-US/docs/Web/HTTP/Link_prefetching_FAQ
user_pref("network.prefetch-next", false);

// 0602: disable dns prefetching
   // http://www.ghacks.net/2013/04/27/firefox-prefetching-what-you-need-to-know/
   // https://developer.mozilla.org/en-US/docs/Web/HTTP/Controlling_DNS_prefetching
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);

// 0602: disable dns prefetching
   // http://www.ghacks.net/2013/04/27/firefox-prefetching-what-you-need-to-know/
   // https://developer.mozilla.org/en-US/docs/Web/HTTP/Controlling_DNS_prefetching
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);

// 0603: disable Seer/Necko
user_pref("network.predictor.enabled", false);

// 0604: disable search suggestions
user_pref("browser.search.suggest.enabled", false);
// 0605: disable link-mouseover opening connection to linked server
   // http://news.slashdot.org/story/15/08/14/2321202/how-to-quash-firefoxs-silent-requests
   // http://www.ghacks.net/2015/08/16/block-firefox-from-connecting-to-sites-when-you-hover-over-links
user_pref("network.http.speculative-parallel-limit", 0);

// 0606: disable pings (but enforce same host in case)
   // http://kb.mozillazine.org/Browser.send_pings
   // http://kb.mozillazine.org/Browser.send_pings.require_same_host
user_pref("browser.send_pings", false);
user_pref("browser.send_pings.require_same_host", true);

// 1601: disable referer from an SSL Website
user_pref("network.http.sendSecureXSiteReferrer", false);

// 2614: disable SPDY as it can contain identifiers
   // SPDY will be deprecated in 2016
   // https://www.torproject.org/projects/torbrowser/design/#identifier-linkability (no. 10)
user_pref("network.http.spdy.enabled", false);
user_pref("network.http.spdy.enabled.v3-1", false);

// 2615: disable http2 for now as well
user_pref("network.http.spdy.enabled.http2", false);

// 2618: when using SOCKS have the proxy server do the DNS lookup - dns leak issue
   // http://kb.mozillazine.org/Network.proxy.socks_remote_dns
   // https://trac.torproject.org/projects/tor/wiki/doc/TorifyHOWTO/WebBrowsers
   // eg in TOR, this stops your local DNS server from knowing your Tor destination
   // as a remote Tor node will handle the DNS request
user_pref("network.proxy.socks_remote_dns", true);

// Tweaks
user_pref("network.http.max-persistent-connections-per-server", 10);
user_pref("network.http.pipelining", true);
user_pref("network.http.proxy.pipelining", true);
user_pref("network.predictor.cleaned-up", true);



/****************************************************************************/
/*** 0800: LOCATION BAR / SEARCH / AUTO SUGGESTIONS / HISTORY / FORMS etc ***/
/****************************************************************************/

// 0801: disable location bar using search - PRIVACY
   // don't leak typos to a search engine, give an error message instead
user_pref("keyword.enabled", false);

// 0802: disable location bar domain guessing - PRIVACY/SECURITY
   // domain guessing intercepts DNS "hostname not found errors" and resends a
   // request (eg by adding www or .com). This is inconsistent use (eg FQDNs), does not work
   // via Proxy Servers (different error), is a flawed use of DNS (TLDs: why treat .com
   // as the 411 for DNS errors?), privacy issues (why connect to sites you didn't
   // intend to), can leak sensitive data (eg query strings: eg Princeton attack),
   // and is a security risk (eg common typos & malicious sites set up to exploit this)
user_pref("browser.fixup.alternate.enabled", false);

// 0804: display all parts of the url
   // why rely on just a visual clue - helps SECURITY
user_pref("browser.urlbar.trimURLs", false);

// 0809: limit history leaks via enumeration (PER TAB: back/forward) - PRIVACY
   // This is a PER TAB session history. You still have a full history stored under all history
   // default=50, minimum=1=currentpage, 2 is the recommended minimum as some pages
   // use it as a means of referral (eg hotlinking), 4 or 6 may be more practical
user_pref("browser.sessionhistory.max_entries", 4);

// 0810: disable css querying page history - css history leak - PRIVACY
    // false = won't use different coloring for visited links
//user_pref("layout.css.visited_links_enabled", false);

// 0811: disable displaying Javascript in history URLs - SECURITY
user_pref("browser.urlbar.filter.javascript", true);

// 0814: disable auto-filling username & password form fields - SECURITY
   // can leak in cross-site forms AND be spoofed
   // http://kb.mozillazine.org/Signon.autofillForms
   // password will still be auto-filled after a user name is manually entered
//user_pref("signon.autofillForms", false);



/****************************************************************************/
/*** PLUGINS / ADDONS ***                                                   */
/****************************************************************************/

// 1801: set default plugin state (i.e new plugins on discovery) to never activate
   // 0=disabled, 1=ask to activate, 2=active - you can override individual plugins
user_pref("plugin.default.state", 1);
user_pref("plugin.defaultXpi.state", 2);

// make sure a plugin is in a certain state: 0=deactivated 1=ask 2=enabled
   // you can just set all these plugin.state's via Add-ons>Plugins
   // NOTE: you can still over-ride individual sites eg Youtube via site permissions
user_pref("plugin.state.flash", 1);
user_pref("plugin.state.java", 1);

// 1804: disable plugins using external/untrusted scripts with XPCOM or XPConnect
user_pref("security.xpconnect.plugin.unrestricted", false);

// 1808: disable the bundled OpenH264 codec
user_pref("media.gmp-provider.enabled", false);



/****************************************************************************/
/*** MEDIA / CAMERA / MIC ***                                               */
/****************************************************************************/

// 1807: disable auto-play of HTML5 media (including webms)
user_pref("media.autoplay.enabled", false);

// 2001: disable WebRTC
   // https://www.privacytools.io/#webrtc
user_pref("media.peerconnection.enabled", false);
user_pref("media.peerconnection.use_document_iceservers", false);
user_pref("media.peerconnection.video.enabled", false);
user_pref("media.peerconnection.identity.timeout", 1);
user_pref("media.peerconnection.turn.disable", true);

// 2002: disable WebRTC - firefox making automatic connections#w_media-capabilities
user_pref("media.gmp-gmpopenh264.enabled", false);
user_pref("media.gmp-manager.url", "");

// 2003: disable EME (Adobe "Primetime Content Decryption Module" DRM)
   // https://trac.torproject.org/projects/tor/ticket/16285
user_pref("browser.eme.ui.enabled", false);
user_pref("media.gmp-eme-adobe.enabled", false);
user_pref("media.eme.enabled", false);
user_pref("media.eme.apiVisible", false);

// 2004: disable getUserMedia
   // https://wiki.mozilla.org/Media/getUserMedia
user_pref("media.navigator.enabled", false);

// 2010: disable WebGL, force bare minimum feature set if used & disable WebGL extensions
   // http://www.contextis.com/resources/blog/webgl-new-dimension-browser-exploitation/
   // https://security.stackexchange.com/questions/13799/is-webgl-a-security-concern
user_pref("webgl.disabled", true);
user_pref("pdfjs.enableWebGL", false);
user_pref("webgl.min_capability_mode", true);
user_pref("webgl.disable-extensions", true);

// 2020: disable video statistics fingerprinting vector - JS performance fingerprinting
user_pref("media.video_stats.enabled", false);

// 2021: disable speech recognition
user_pref("media.webspeech.recognition.enable", false);

// 2022: disable screensharing
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.getusermedia.screensharing.allowed_domains", "");

// 2023: disable camera stuff
user_pref("camera.control.autofocus_moving_callback.enabled", false);
user_pref("camera.control.face_detection.enabled", false);



/****************************************************************************/
/*** DOM / JS ***                                                           */
/****************************************************************************/

// 2201: disable website control over right click context menu
user_pref("dom.event.contextmenu.enabled", false);

// 2202: UI SPOOFING: disable scripts hiding or disabling the following on new windows
user_pref("dom.disable_window_open_feature.location", true);
user_pref("dom.disable_window_open_feature.menubar", true);
user_pref("dom.disable_window_open_feature.resizable", true);
user_pref("dom.disable_window_open_feature.scrollbars", true);
user_pref("dom.disable_window_open_feature.status", true);
user_pref("dom.disable_window_open_feature.toolbar", true);

// 2203: POPUP windows - prevent or allow javascript UI meddling
user_pref("dom.disable_window_flip", true); // window z-order
user_pref("dom.disable_window_move_resize", true);
user_pref("dom.disable_window_open_feature.close", true);
user_pref("dom.disable_window_open_feature.minimizable", true);
user_pref("dom.disable_window_open_feature.personalbar", true); //bookmarks toolbar
user_pref("dom.disable_window_open_feature.titlebar", true);
user_pref("dom.disable_window_status_change", true);
user_pref("dom.allow_scripts_to_close_windows", false);

// 2204: disable links opening in a new window
   // https://trac.torproject.org/projects/tor/ticket/9881
   // test url: https://people.torproject.org/~gk/misc/entire_desktop.html
   // You can still right click a link and select open in a new window
   // This is to stop malicious window sizes and screen res leaks etc in conjunction
   // with 2203 dom.disable_window_move_resize=true | 2418 full-screen-api.enabled=false
user_pref("browser.link.open_newwindow.restriction", 0);

// 2402: disable website access to clipboard events/content
   // WARNING: This will break some sites functionality such as pasting into Facebook
   // this applies to onCut, onCopy, onPaste events - i.e is you have to interact with
   // the website for it to look at the clipboard
    // need to be 'true' if you are using Stylish and you want to copy&paste
user_pref("dom.event.clipboardevents.enabled", true);

// 2405: https://wiki.mozilla.org/WebAPI/Security/WebTelephony
user_pref("dom.telephony.enabled", false);

// 2406: disable gamepad API - fingerprinting - USB device ID enumeration
user_pref("dom.gamepad.enabled", false);

// 2407: disable battery API - fingerprinting vector
user_pref("dom.battery.enabled", false);

// 2408: disable network API - fingerprinting vector
user_pref("dom.network.enabled", false);

// 2409: disable giving away network info
   // https://developer.mozilla.org/en-US/docs/Web/API/Network_Information_API
user_pref("dom.netinfo.enabled", false);

// 2410: disable User Timing API
   // https://trac.torproject.org/projects/tor/ticket/16336
user_pref("dom.enable_user_timing", false);
// 2411: disable resource/navigation timing
user_pref("dom.enable_resource_timing", false);
// 2412: disable timing attacks - javascript performance fingerprinting
   // https://wiki.mozilla.org/Security/Reviews/Firefox/NavigationTimingAPI
user_pref("dom.enable_performance", false);

// 2413: disable virtual reality devices - fingerprinting vector
user_pref("dom.vr.enabled", false);
user_pref("dom.vr.oculus.enabled", false);
user_pref("dom.vr.oculus050.enabled", false);

// 2414: disable shaking the screen
user_pref("dom.vibrator.enabled", false);

// 2415: max popups from a single non-click event - default is 20!
user_pref("dom.popup_maximum", 3);

// 2416: disable idle observation
user_pref("dom.idle-observers-api.enabled", false);

// 2417: disable SharedWorkers for now
   // https://www.torproject.org/projects/torbrowser/design/#identifier-linkability (no. 8)
   // https://bugs.torproject.org/15562 - SharedWorker violates first party isolation
user_pref("dom.workers.sharedWorkers.enabled", false);

// 2419: disable touch events
   // https://developer.mozilla.org/en-US/docs/Web/API/Touch_events
   // https://trac.torproject.org/projects/tor/ticket/10286
   // fingerprinting attack vector - leaks screen res & actual screen coordinates
   // WARNING: If you use touch eg Win8/10 Metro reset this to default
user_pref("dom.w3c_touch_events.enabled", 0);

// 2420: disable support for asm.js (http://asmjs.org/)
   // https://www.mozilla.org/en-US/security/advisories/mfsa2015-29/
   // https://www.mozilla.org/en-US/security/advisories/mfsa2015-50/
   // https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-2712
user_pref("javascript.options.asmjs", false);

// 2430: disable web/push notifications
   // https://developer.mozilla.org/en-US/docs/Web/API/notification
   // NOTE: you can still override individual domains under site permissions (FF44+)
user_pref("dom.webnotifications.enabled", false);
user_pref("dom.webnotifications.serviceworker.enabled", false);

// 2431: disable push notifications (FF44+?) - needs more research
   // web apps can receive messages pushed to them from a server, whether or
   // not the web app is in the foreground, or even currently loaded
   // https://developer.mozilla.org/en/docs/Web/API/Push_API
user_pref("dom.push.enabled", false);
user_pref("dom.push.connection.enabled", false);
user_pref("dom.push.serverURL", "");
user_pref("dom.push.udp.wakeupEnabled", false);
user_pref("dom.push.userAgentID", "");

// 2607: disable page thumbnails - privacy
user_pref("browser.pagethumbnails.capturing_disabled", true);
user_pref("pageThumbs.enabled", false);
user_pref("browser.pagethumbnails.storage_version", 3); // not sure



/****************************************************************************/
/*** MISC / OTHER ***                                                       */
/****************************************************************************/

// 0303: disable search update
user_pref("browser.search.update", false);

// 2606: disable hiding mime types (Options>Applications) not associated with a plugin
user_pref("browser.download.hide_plugins_without_extensions", false);

// 2608: disable JAR from opening Unsafe File Types
user_pref("network.jar.open-unsafe-types", false);

// 2609: disable insecure active content on https pages - mixed content
user_pref("security.mixed_content.block_active_content", true);

// 2611: disable WebIDE to prevent remote debugging and addon downloads
   // https://trac.torproject.org/projects/tor/ticket/16222
user_pref("devtools.webide.autoinstallADBHelper", false);
user_pref("devtools.webide.autoinstallFxdtAdapters", false);
user_pref("devtools.debugger.remote-enabled", false);
user_pref("devtools.webide.enabled", false);

// 2612: disable SimpleServiceDiscovery - which can bypass proxy settings - eg Roku
   // https://trac.torproject.org/projects/tor/ticket/16222
user_pref("browser.casting.enabled", false);
user_pref("gfx.layerscope.enabled", false);

// 2613: disable device sensor API - fingerprinting vector
user_pref("device.sensors.enabled", false);

// 2617: disable pdf.js as an option to preview PDFs within Firefox
   // see mime-types under Options>Applications) - EXPLOIT risk
   // Enabling this (set to true) will change your option most likely to "Ask" or "Open with
   // some external pdf reader". This does NOT necessarily prevent pdf.js being used via
   // other means, it only removes the option. I think this should be left at default (false).
   // 1. It won't stop JS bypassing it. 2. Depending on external pdf viewers there is just as
   // much risk or more (acrobat). 3. mozilla are very quick to patch these sorts of exploits,
   // they treat them as severe/critical and 4. for convenience
user_pref("pdfjs.disabled", false);

// 2622: ensure you have a security delay when installing add-ons (milliseconds)
   // default=1000, This also covers the delay in "Save" on downloading files.
   // http://kb.mozillazine.org/Disable_extension_install_delay_-_Firefox
   // http://www.squarefree.com/2004/07/01/race-conditions-in-security-dialogs/
user_pref("security.dialog_enable_delay", 1000);



/****************************************************************************/
/*** PERSONAL PREFERENCES ***                                               */
/****************************************************************************/

// Show tabs from last time (restore tabs)
user_pref("browser.startup.page", 3);

// Blank homepage
user_pref("browser.startup.homepage", "about:blank");

// 0360: disable new tab tile ads & preload & marketing junk
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.directory.ping", "");
user_pref("browser.newtabpage.directory.source", "");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.introShown", true);

// 3001: disable annoying warnings
user_pref("general.warnOnAboutConfig", false);
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.warnOnCloseOtherTabs", false);
user_pref("browser.tabs.warnOnOpen", false);

// 3002: disable closing browser with last tab
user_pref("browser.tabs.closeWindowWithLastTab", false);

// URL bar
user_pref("browser.urlbar.formatting.enabled", false);
user_pref("browser.urlbar.mouseOnBottomLinkifies", true);
user_pref("browser.urlbar.mouseOnTopLinkifies", true);
user_pref("browser.urlbar.suggest.openpage", false);

// Enable Backspace
user_pref("browser.backspace_action", 0);

// 3001a disable warning when a domain requests full screen
   // https://developer.mozilla.org/en-US/docs/Web/Guide/API/DOM/Using_full_screen_mode
user_pref("full-screen-api.warning.delay", 0);
user_pref("full-screen-api.warning.timeout", 0);

// 3005: disable autocopy default (use extensions autocopy 2 & copy plain text 2)
user_pref("clipboard.autocopy", false);

// 3007: open new windows in a new tab instead
   // This setting is under Options>General>Tabs
   // 1=current window, 2=new window, 3=most recent window
user_pref("browser.link.open_newwindow", 3);

// 3009: turn on APZ (Async Pan/Zoom) - requires e10s
   // http://www.ghacks.net/2015/07/28/scrolling-in-firefox-to-get-a-lot-better-thanks-to-apz/
// user_pref("layers.async-pan-zoom.enabled", true);

// Accessibility
user_pref("accessibility.typeaheadfind.autostart", false);
user_pref("accessibility.typeaheadfind.flashBar", 0);

// Tabs and Animations
user_pref("browser.tabs.animate", false);
user_pref("browser.download.animateNotifications", false);
user_pref("browser.panorama.animate_zoom", false);
user_pref("browser.fullscreen.animateUp", 0);
user_pref("browser.tabs.autoHide", false);

// Toolbar tooltips
user_pref("browser.chrome.toolbar_tips", false);

//Text based zoom
user_pref("browser.zoom.full", false);

// History size
user_pref("places.history.expiration.transient_current_max_pages", 5000);

// Session store
user_pref("browser.sessionstore.interval", 300000);
// Maxinum undo tabs (reopen closed)
user_pref("browser.sessionstore.max_tabs_undo", 3);

// Cache memory: half of the memory
// see: about:cache?device=memory
// http://www.tweakguides.com/Firefox_10.html
user_pref("browser.cache.memory.capacity", 11776);
user_pref("browser.cache.offline.enable", false);
