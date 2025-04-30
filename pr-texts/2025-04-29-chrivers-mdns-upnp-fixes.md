### 2025-04-29: `chrivers/mdns-upnp-fixes`

- Entirely rework support for mDNS and SSDP/UPnP
 - Fixed a bug where mDNS reported an invalid hostname for Bifrost
 - Reworked my fork of tokio-ssdp crate, to make it respond properly
 - Add support for "upgrading" firmware through Hue App!

You read the last one right - if there's a new mandatory version upgrade before the automatic version check picks it up (it checks once per day), the Hue app will offer to upgrade the bridge firmware.

Simply say yes to this exciting prospect! Code has been added to Bifrost that recognizes this update pattern, and re-checks the version number.

The end result is that the Hue app *thinks* it has updated the bridge, which is all we need.
