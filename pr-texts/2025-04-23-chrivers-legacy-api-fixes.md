### 2025-04-22: `chrivers/legacy-api-fixes`

This update fixes bugs and adds workarounds for the legacy api.

In particular, this greatly improves compatibility with Hue Essentials, which
now works quite a bit better:

 - Fix brightness scaling: Legacy api uses 0..254, while the new api uses 0..100
 - Fix "group 0" handling: The bridge has a virtual "group 0", which represents all groups on the bridge
 - Add workaround for scenes without `.speed` field (Hue Essentials does this), so we don't get an error
