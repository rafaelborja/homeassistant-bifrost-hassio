### 2025-03-17: `chrivers/api-v1-hs-color-mode`

Implement support for converting Hue/Saturation ("HS") light updates to modern XY-based values.

This enables support for receiving Hue/Sat light updates over API V1, specifically for `ApiLightStateUpdate` (`PUT` requests for controlling lights).

When such a request is received, it is converted to XY mode, and handled from there.
