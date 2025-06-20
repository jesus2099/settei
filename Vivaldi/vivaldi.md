Vivaldi setup
=============


- Toggle Find in Page When Using Shortcut: Off


Mouse Gestures
--------------

- Duplicate Selected Tabs: DOWN UP (like in Opera 12)


Searches
--------

- GnuDb: gnudb `https://gnudb.org/search.php?cmd=search&words=%s&mode=`
- JASRAC title: jt `https://jesus2099.gitlab.io/forward-request.html?_action=https%3A%2F%2Fwww2.jasrac.or.jp%2FeJwid%2Fmain%3FtrxID%3DA00401-3%23result&_method=post&_accept-charset=Shift_JIS&IN_DEFAULT_WORKS_KOUHO_MAX=100&IN_DEFAULT_WORKS_KOUHO_SEQ=1&IN_WORKS_TITLE_NAME1=%s&IN_WORKS_TITLE_CONDITION=1&IN_DEFAULT_SEARCH_WORKS_NAIGAI=0&RESULT_CURRENT_PAGE=1`
- JIRA browse: j `https://xxxx.atlassian.net/browse/%s`
- JIRA project ID: jid `https://xxxx.atlassian.net/rest/api/latest/project/%s`
- Joshin web (catalogue): jc `https://joshinweb.jp/dps/srhzs.html?KEY=ZS_RECODE&KEY_M=ALL&KEYWORD=%s&REQUEST_CODE=1`
- mercari (analog / vinyl): mea `https://jp.mercari.com/search?keyword=%s&t1_category_id=5&category_id=1160`
- mercari (CD): mec `https://jp.mercari.com/search?keyword=%s&t1_category_id=5&category_id=75`
- mercari (culture): me `https://jp.mercari.com/search?keyword=%s&t1_category_id=5&category_id=5`
- mercari (video): mev `https://jp.mercari.com/search?keyword=%s&t1_category_id=5&category_id=74`
- minc (catalogue): mc `https://search.minc.or.jp/product/list/?dn=%s&type=search-form-diskno`
- minc (ISRC): mi `https://www.minc.gr.jp/db/GakInfo.aspx?ISRCCD=%s`
- MusicBrainz catno: mbc `https://musicbrainz.org/search?query=catno:%s&type=release&method=advanced`
- MusicBrainz URL search: mbu `http://mb.lmfao.org.uk/urlsearch/?url=%s&partial=on`
- Twitter Join Date (first post): t `http://www.twitterjoindate.com/search?utf8=%E2%9C%93&name=%s`
- ヤフオク (geoblocked, use yahuoku_REDIRECT-TO-BUYEE.user.js): yo `https://duckduckgo.com/?q=%s+site%3Aauctions.yahoo.co.jp%2Fjp%2Fauction%2F&kp=1&t=vivaldi&iax=images&ia=images`


Extensions
----------

- Duplicate Tabs Closer https://chrome.google.com/webstore/detail/duplicate-tabs-closer/gnmdbogfankgjepgglmmfmbnimcmcjle
- JSON Formatter https://chrome.google.com/webstore/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa
- Linkclump https://chrome.google.com/webstore/detail/linkclump/lfpjkncokllnfokkgpkobnkbkmelfefj
- Proxy SwitchyOmega https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif
- Stylus https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne
- uBlock Origin https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm
- Ultimate Enable Right Click ─ Allow Copy https://chrome.google.com/webstore/detail/ultimate-enable-right-cli/emfeppdfcjnldjgmofdkbggeacapegen
- Violentmonkey https://chrome.google.com/webstore/detail/violentmonkey/jinjaccalgkegednnccohejagnlnfdag


Tips
----

### Disable “Sign in to xxxx with Google.com” annoying popups ###

https://forum.vivaldi.net/topic/96927/how-to-disable-sign-in-to-xxx-with-google-com

Uncheck https://myaccount.google.com/connections/settings

1. Open **Vivaldi Settings** (Ctrl+F12)
2. Click **Privacy and Security** tab
3. Scroll down to **WEBSITE PERMISSIONS**
4. In **Global Permissions** locate **Third-Party Sign-in** and select **Block** instead of *Allow*
