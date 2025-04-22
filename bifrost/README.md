![Logo](https://raw.githubusercontent.com/chrivers/bifrost/master/doc/logo-title-640x160.png)

# Bifrost Bridge

Bifrost enables you to emulate a Philips Hue Bridge to control lights, groups
and scenes from [Zigbee2Mqtt](https://www.zigbee2mqtt.io/).

## Installation guide

  1. Install Bifrost Add-on
  2. Configure Bifrost (see next sections)
  3. Start Bifrost Add-on

## Configuring Bifrost

> [!IMPORTANT]
> You **must configure** bifrost before you can run it.

Bifrost requires a configuration file, `config.yaml`.

This file contains the essential settings needed to run the server. For example,
the IP and MAC address used by the server, and a list of the Zigbee2Mqtt servers
to connect to.

When using the Home Assistant Add-on, the file must be available inside the
docker container as `/config/bifrost/config.yaml`, which means you have to put
it here:

    /usr/share/hassio/homeassistant/bifrost

### If you have the popular "File Editor" add-on installed, do this:

  1. Open "File Editor"
  2. Go to the top level
  3. Create directory `bifrost` (*lowercase*)
  4. Inside that directory, create `config.yaml`

## Configuration example

Here's an example, for a server listening on `10.12.0.20/24`, with a Zigbee2Mqtt
server running on `10.0.0.100`:

```yaml
bridge:
  name: Bifrost
  mac: 00:11:22:33:44:55
  ipaddress: 10.12.0.20
  netmask: 255.255.255.0
  gateway: 10.12.0.1
  timezone: Europe/Copenhagen

z2m:
  server1:
    url: ws://10.0.0.100:8080
```

Please adjust this as needed.

> [!IMPORTANT]
> **Make sure** the "mac:" field matches the mac address on the network interface you want to serve requests from.

For details, see the [configuration reference](https://github.com/chrivers/bifrost/blob/master/doc/config-reference.md).

This mac address if used to generate a self-signed certificate, so the Hue App
will recognize this as a "real" Hue Bridge. If the mac address is incorrect,
this will not work. [How to find your mac address](https://github.com/chrivers/bifrost/blob/master/doc/how-to-find-mac-linux.md).

# Supported features

In the following, "z2m" is a shorthand for "Zigbee2Mqtt".

## Lights

| Action                         | . . . | in z2m                                                  | . . . | in Bifrost          |
|:-------------------------------|-------|:--------------------------------------------------------|-------|:--------------------|
| Add a light                    |       | Add the light in z2m, it should appear in bifrost       |       | *Not supported yet* |
| Remove a light                 |       | Remove the light in z2m, it should disappear in bifrost |       | *Not supported yet* |
| Rename a light                 |       | Rename the light in z2m, bifrost should reflect this    |       | *Not supported yet* |
| Toggle light (on/off)          |       | Supported, state will be updated in bifrost             |       | Supported           |
| Change color/color temperature |       | Supported, state will be updated in bifrost             |       | Supported           |
| Set startup parameters         |       | Supported, state will be updated in bifrost             |       | *Not supported yet* |

## Groups (rooms)

| Action         | . . . | in z2m                                                   | . . . | in Bifrost                                     |
|:---------------|-------|:---------------------------------------------------------|-------|:-----------------------------------------------|
| Add a group    |       | Add the group in z2m, it should appear as a room bifrost |       | *Not supported yet**                           |
| Remove a group |       | Remove the group in z2m, it should disappear in bifrost  |       | *Not supported yet**                           |
| Rename a light |       | Rename the group in z2m, bifrost should reflect this     |       | Room names can be specified in the config file |
| Control lights |       | Supported by z2m, although not in the web ui             |       | Supported                                      |

## Scenes

| Action           | . . . | in z2m                                                  | . . . | in Bifrost                                                             |
|:-----------------|-------|:--------------------------------------------------------|-------|:-----------------------------------------------------------------------|
| Add a scene      |       | Add the scene in z2m, it should appear in bifrost       |       | Fully supported. Adding a scene in Bifrost creates the scene in z2m!   |
| Remove a group   |       | Remove the scene in z2m, it should disappear in bifrost |       | Fully supported. Removing a scene in Bifrost removes the scene in z2m! |
| Rename a light   |       | Rename the group in z2m, bifrost should reflect this    |       | Supported                                                              |
| Activate a scene |       | Supported by z2m, bifrost should reflect this           |       | Supported                                                              |

# F.A.Q

## Will Bifrost work without Zigbee2Mqtt?

Not in the near future. Bifrost is closely integrated with Zigbee2Mqtt, to provide good, reliable performance.

Development is underway to be able to support multiple types of backends at some future
point, but only the z2m backend is being developed.

## Will Bifrost be able to use my switches / motion sensors?

Currently, no. However, Zigbee2Mqtt is able to use these, and it's
absolutely possible to use such devices via e.g. Home Assistant, even while
using Bifrost at the same time to control your lights.

We hope to support switches and motion sensors in a future Bifrost release.

## Will Bifrost ever support the Hue (HDMI) Sync Box, or true Entertainment Mode?

Yes! Work is well underway.

The Bifrost project has acheived several breakthroughs in reverse-engineering
the proprietary Hue Entertainment Mode protocols. This work has been made
possible by your donations, which have been invested in necessary equipment.

The newest `bifrost-dev` add-on is the first version of any Open Source
software, to ever support Entertainment Mode. Please help us test it, and let us
know what you think!

# Donors

I would like to personally thank the people who have helped this project financially.

Your support has resulted in major breakthroughs, and we all get to enjoy the results.

The following people have donated a total of 25€ or more:
  - Alexa & Peter Miller
  - Modem-Tones
  - Rohan Kapoor
  - thk

In particular, I would like to thank Rohan Kapoor for his very generous donation, which
covered the cost of a Hue Sync Box!


# Changelog (11 most recent changes)

### 2025-04-22: `chrivers/fix-error-handling`

Fix error handling: We accidentally double-encoded the error as json, leading to, ironically, error errors.

This should improve api responses when an error is returned. This is mostly a technical fix, with little user-facing impact.

****************************************

### 2025-04-21: `chrivers/websocket-tls`

Implement support for using TLS with websockets ("wss://" urls)

A few users are reporting that they use TLS for their z2m websockets, and this
has previously not been supported.

With these changes, the z2m websocket urls can be specified as "wss://..."
instead of "ws://..." to enable TLS.

Additionally, a new (optional) z2m per-server config option,
`disable_tls_verify` has been added, to optionally turn TLS verification
off. This is useful for certain testing scenarios, where self-signed
certificates might be used.

****************************************

### 2025-04-21: `chrivers/upnp-description-xml`

Implement support for UPNP and SSDP in Bifrost!

These four-letter scrabble winners are discovery protocols, meant to improve auto-detection by clients.

Previously, Bifrost only supported mDNS - yet another such protocol - which is what most (but not all) clients use.

Specifically, Hue Essentials requires SSDP. Not only that, but Hue Essentials sends broken discovery requests, so special workarounds have had to be implemented to support it.

We still know of at least 1 device that is not yet able to find a Bifrost bridge, even with these improvements.

If you have a similar problem, please let us know.

In any case, this should be a clear improvement in how easy it is to connect to Bifrost.

****************************************

### 2025-03-17: `chrivers/api-v1-hs-color-mode`

Implement support for converting Hue/Saturation ("HS") light updates to modern XY-based values.

This enables support for receiving Hue/Sat light updates over API V1, specifically for `ApiLightStateUpdate` (`PUT` requests for controlling lights).

When such a request is received, it is converted to XY mode, and handled from there.

****************************************

### 2025-03-12: `chrivers/entertainment-reversing`

> [!IMPORTANT]
> ***This is the big one people have been waiting for!*** :-)

After spending countless hours reverse-engineering the proprietary Zigbee data
format used by Philips Hue lights for "Entertainment Mode", *even countlesser*
hours have gone into implementing support in Bifrost.

Today, I am proud to announce that Bifrost is the **first program in the world**
to have an entirely Open Source (Free Software) implementation of Hue
Entertainment mode!

This has been a monumental effort. Before starting this work, the Bifrost code
base was about 7200 lines of code. Now, it is over 15000 lines!. In other
words, implementing entertainment mode more than doubled the code base!

I think it's fair to say, that this was more complicated than anticipated.

To make this work at all, the Zigbee2Mqtt project was updated with patches from
myself (@chrivers), @danielhitch, and the author of Zigbee2Mqtt, @koenkk.

Special thanks to @koenkk for taking time out of his busy schedule, to help us
get the necessary bits in place. The new code was first released in version 2.1.1.

> [!WARNING]
> Zigbee2Mqtt MUST BE AT LEAST version 2.1.1 for Entertainment Mode to work.

> [!IMPORTANT]
> Even though version 2.1.1 is the minimum version, version 2.1.3 or greater is
> highly recommended, since some important bugs were fixed after version 2.1.1.

This is the very first of Bifrost that supports Entertainment Mode at all, so
please bear with us while we iron out any bugs or rough edges.

Should work:
 - Creating Entertainment Areas from the Hue App.
 - Updating Entertainment Area settings.
 - Adding lights or 7-segment strips to entertainment areas.
 - Streaming to Entertainment Areas from "Hue Sync for PC" (tested).
 - Streaming to Entertainment Areas from Play HDMI sync box 8K (tested).
 - Streaming to one or more lights.
 - Streaming to a combination of lamps and light strips.

Perhaps working: (please let us know what your experience is!)
 - Adding 3-segment strips to entertainment areas.
 - Adding non-color lights to entertainment areas.
 - Streaming to Entertainment Areas from Play HDMI sync box (older, non-8K version).

Not yet working:
 - Adjusting "stream mode" ("From Device" vs "From Bridge")
 - Adjusting "relative brightness" for lights
 - Streaming in XY color mode (most things seem to use RGB mode)

****************************************

### 2025-03-17: `chrivers/hue-crate-entertainment-mode`

This pull request implements the necessary code in the hue crate, to support decoding and encoding of Hue Entertainment Mode (also known as "Sync mode").

There are two major new areas of support:
 - Encoding and decoding the DTLS stream going to the bridge (from a sync client)
 - Encoding and decoding the specialized Zigbee frames going from the bridge, to the lights.

Especially the latter part builds on the previous work done by the Bifrost project, to reverse engineer the Hue Entertainment zigbee format.

This pull request does not in itself add entertainment mode support to the Bifrost bridge. It only adds required library code needed to implement that support in an upcoming pull request.

****************************************

### 2025-03-16: `chrivers/svc-crate`

Implement a new crate ("svc") to manage rust-based micro-services.

Bifrost consists of a number of "things" running independently, while performing work either on request, on a timer, or some combination of the two.

Synchronizing, coordinating and sharing information between all these various parts of Bifrost, takes up a non-trivial amount of the codebase.

That's why we are introducing a dedicates library (a "crate", in rust terminology) for managing services that implement a standardized interface, specifically, the `Service` trait.

This makes it possible to share start/run/stop handling for all services, as well as more advanced features like policies ("if a service fails, what should happen?"), error handling, dependencies, and liveness checks.

This PR introduces and builds up the "svc" crate, but does not change Bifrost to use it, yet.

****************************************

### 2025-03-16: `chrivers/api-v1-improvements`

This PR combines a number of minor improvements to the Hue V1 api implementation.

 - The virtual "daylight sensor" present in the v1 api is now partially implemented. It is now present in the api output, which is an improvement for programs that expected it to be present, but it does not yet do anything.
 - The virtual "group 0", representing all lights on a bridge, is now implemented for the v1 api.
 - Usernames for api v1 can now be any string, instead of only valid uuids.
 - The "create user" endpoint can now reply with the "client key" needed for Entertainment Mode / Sync streams.
 - The reported capabilities have been increased to report lots of space for activities.

****************************************

### 2025-03-15: `chrivers/hue-and-zcl-crates`

This is one of those pull requests that are almost invisible for end users, but important for the developers of Bifrost.

With this change, several pieces of Bifrost are split out into independent packages ("crates" in rust parlance).

This includes:

 - `crates/zcl`: Zigbee Cluster Library crate. This contains code needed to encode/decode Philips Hue zigbee messages.
 - `crates/hue`: Contains data models and functions needed to work with Philips Hue lights, including color space handling, gradient encodings, and more.

Improving the code this much was a lot of work: 56 commits, adding 1630 lines and removing 265.

New features: None :-P

****************************************

### 2025-03-13: `chrivers/docker-ca-certificates` + `chrivers/dockerfile-update`

This fixes the docker build process for Bifrost, which was accidentally broken
during the rush of recent, big merges coming in.

 - Add missing `libssl-dev` package for compile step
 - Add missing `libssl3` package for runtime container
 - Add missing bind mounts for building bifrost
 - Upgrade rust version for build container
 - Add missing `ca-certificates` package, to make hue api version checking
   function correctly again.

With all these checks, the docker release of Bifrost should be back in a good
state.

****************************************

### 2025-03-12: `chrivers/light-status-and-effects`

After having reverse engineered and documented the proprietary [Hue Zigbee message formats](https://github.com/chrivers/bifrost/pull/93), we can start using this knowledge in Bifrost.

This change updates the z2m backend, to enable support for all "Hue Effects" as seen in the Hue app.

In other words, effects like "Candle", "Fireplace", "Opal", etc, are now fully supported on Hue lights connected over z2m. Ordinary light updates (for brightness, color, color temperature, etc) are now also controlled over this format, allowing for a faster, more efficient way to control Philips Hue lights.

Since only Philips Hue lights support these vendor-specific Zigbee messages, all other lights will use the traditional code path from previous versions of Bifrost.

## Full changelog

For the full changelog, please click on the "Changelog" link in the upper left corner.

# Now on Ko-fi! Donations welcome :-)

Developing software for the hue ecosystem is a fun, but pretty expensive hobby.

If you would like to toss a few dollaridoos in the hat, I've set up a Ko-fi accont:

[![Link to Ko-Fi donation page](https://raw.githubusercontent.com/chrivers/bifrost-hassio/refs/heads/master/kofi.png)](https://ko-fi.com/L4L819GOTY)

All donations will go towards new equipment for testing and development.

# Questions?

Questions, feedback, comments? Join us on discord

[![Join Valhalla on Discord](https://discordapp.com/api/guilds/1276604041727578144/widget.png?style=banner2)](https://discord.gg/YvBKjHBJpA)
