### 2025-03-17: `chrivers/hue-crate-entertainment-mode`

This pull request implements the necessary code in the hue crate, to support decoding and encoding of Hue Entertainment Mode (also known as "Sync mode").

There are two major new areas of support:
 - Encoding and decoding the DTLS stream going to the bridge (from a sync client)
 - Encoding and decoding the specialized Zigbee frames going from the bridge, to the lights.

Especially the latter part builds on the previous work done by the Bifrost project, to reverse engineer the Hue Entertainment zigbee format.

This pull request does not in itself add entertainment mode support to the Bifrost bridge. It only adds required library code needed to implement that support in an upcoming pull request.
