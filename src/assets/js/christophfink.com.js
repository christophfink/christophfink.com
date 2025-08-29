/* globals */
/* eslint-disable object-shorthand, object-curly-newline, no-multi-assign, consistent-this, radix, no-global-assign, no-native-reassign */
/* eslint no-console: "warn" */
/* eslint max-depth: ["warn", 6] */
/* eslint no-unused-vars: ["error", { "vars": "local" } ] */

(function () {
    "use strict"

    const f = function () {
        /*document.querySelectorAll("navigation .navbar a.nav-link").forEach(
            navlink => {
                navlink.addEventListener("click", () => {
                    console.log(navlink)
                })
            }
        )*/
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", f)
    } else {
        f()
    }

}())
