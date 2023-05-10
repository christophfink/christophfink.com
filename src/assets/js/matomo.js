/* globals */
/* eslint-disable object-shorthand, object-curly-newline, no-multi-assign, consistent-this, radix, no-global-assign, no-native-reassign */
/* eslint no-console: "warn" */
/* eslint max-depth: ["warn", 6] */
/* eslint no-unused-vars: ["error", { "vars": "local" } ] */

const MATOMO_BASE_URL = "/lib/piwik"

let _paq = window._paq = window._paq || []
_paq.push(["trackPageView"])
_paq.push(["enableLinkTracking"])
_paq.push(["setTrackerUrl", `${MATOMO_BASE_URL}/matomo.php`])
_paq.push(["setSiteId", "2"])

import(`${MATOMO_BASE_URL}/matomo.js`)
