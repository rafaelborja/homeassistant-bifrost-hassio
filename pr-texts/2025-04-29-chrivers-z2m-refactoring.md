### 2025-04-21: `chrivers/z2m-refactoring`

This change cleans up a bunch of internal code related to the z2m backend, and
makes two important user-facing improvement:

#### Status updates
Previously, as part of supporting hue effects (candle, fireplace, etc), we would
encode all light update requests to hue lights as the hue-specific
`HueZigbeeUpdate` data format.

This is the data format a Hue Bridge (mostly) uses to control lights, and is a
quick and effective way to update all light settings at once, even the
vendor-specific extensions.

However, Zigbee2MQTT does not know how to report state updates when this update
method is used. It just sees a "raw" message, and passes it along.

So until we land better support in Zigbee2MQTT for dealing with these kinds of
state updates, split light updates into two parts: one for regular light
properties (on/off, brightness, etc), and one optional part for hue-specific
effects.

The hue-specific update is then only sent if needed and supported.

This makes z2m able to report changes to common properties again, but has the
slight downside of sending two messages, if hue-specific extensions are used.

Hopefully over time this can be simplified, but for now this is an improvement
over the previous situation.

#### Z-Stack entertainment mode fix

Previously, "z-stack" based adaptors did not work with entertainment mode,
because of the way the highly specialized Zigbee frames are constructed.

This update changes how entertainment mode frames are constructed, allowing
adapters in the Z-Stack family to join the fun.
