#!/bin/sh
# This script configures Chrome and Firefox on Fedora for unattended use. Startup
# dialog windows are prevented from appearing and blank home pages are used.

# Chrome configuration

mkdir -p /etc/opt/chrome/policies/{managed,recommended}

# Due to the following issues a specific combination of settings below are
# required:
# https://code.google.com/p/chromium/issues/detail?id=138983#c6
# https://code.google.com/p/chromium/issues/detail?id=306104#c13

# A default global configuration file doesn't exist for Chrome so a new will be
# created.

cat <<-EOF > /etc/opt/chrome/policies/managed/defaults.json
{
  "RestoreOnStartup": 0,
  "HomepageIsNewTabPage": false,
  "HomepageLocation": "about:blank",
  "DefaultBrowserSettingEnabled": false,
  "MetricsReportingEnabled": false,
  "DefaultSearchProviderEnabled": false
}
EOF


# Firefox configuration

firefox_config_file=/usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js

# A global configuration file for Firefox exists so a few settings will need to
# be changed:
# browser.startup.homepage -> "about:blank"
# browser.newtabpage.pinned -> true

sed -i 's/\(pref("browser.startup.homepage",\).*/\1 "about:blank");/' $firefox_config_file
sed -i 's/\(pref("browser.newtabpage.pinned",\).*/\1 true);/' $firefox_config_file

# This setting is not in the default config so it's being appended.
# startup.homepage_welcome_url -> "about:blank"

echo 'pref("startup.homepage_welcome_url", "about:blank");' >> $firefox_config_file
echo 'pref("datareporting.healthreport.uploadEnabled", false);' >> $firefox_config_file
echo 'pref("datareporting.healthreport.service.enabled", false);' >> $firefox_config_file
echo 'pref("datareporting.healthreport.service.firstRun", false);' >> $firefox_config_file
