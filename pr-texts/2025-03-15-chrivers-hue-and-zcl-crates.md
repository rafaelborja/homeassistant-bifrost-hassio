### 2025-03-15: `chrivers/hue-and-zcl-crates`

This is one of those pull requests that are almost invisible for end users, but important for the developers of Bifrost.

With this change, several pieces of Bifrost are split out into independent packages ("crates" in rust parlance).

This includes:

 - `crates/zcl`: Zigbee Cluster Library crate. This contains code needed to encode/decode Philips Hue zigbee messages.
 - `crates/hue`: Contains data models and functions needed to work with Philips Hue lights, including color space handling, gradient encodings, and more.

Improving the code this much was a lot of work: 56 commits, adding 1630 lines and removing 265.

New features: None :-P
