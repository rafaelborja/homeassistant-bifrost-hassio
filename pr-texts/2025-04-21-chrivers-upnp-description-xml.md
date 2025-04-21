### 2025-04-21: `chrivers/upnp-description-xml`

Implement support for UPNP and SSDP in Bifrost!

These four-letter scrabble winners are discovery protocols, meant to improve auto-detection by clients.

Previously, Bifrost only supported mDNS - yet another such protocol - which is what most (but not all) clients use.

Specifically, Hue Essentials requires SSDP. Not only that, but Hue Essentials sends broken discovery requests, so special workarounds have had to be implemented to support it.

We still know of at least 1 device that is not yet able to find a Bifrost bridge, even with these improvements.

If you have a similar problem, please let us know.

In any case, this should be a clear improvement in how easy it is to connect to Bifrost.
