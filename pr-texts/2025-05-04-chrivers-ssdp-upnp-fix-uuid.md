### 2025-05-04: `chrivers/ssdp-upnp-fix-uuid`

This change fixes ssdp/upnp discovery of Bifrost bridges.

Incorporating fixes from our forked version of tokio-ssdp makes Bifrost respond properly to M-SEARCH requests.

This makes several types of devices that were previously unable to find Bifrost, able to do so. One example is Philips Ambilight TVs.

Note: Because of a buggy implementation of the Hue protocol in those Ambilight TVs, they are still unable to use Bifrost as a streaming target. But at least they are now able to find Bifrost.
