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
