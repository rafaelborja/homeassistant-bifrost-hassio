### 2025-03-16: `chrivers/api-v1-improvements`

This PR combines a number of minor improvements to the Hue V1 api implementation.

 - The virtual "daylight sensor" present in the v1 api is now partially implemented. It is now present in the api output, which is an improvement for programs that expected it to be present, but it does not yet do anything.
 - The virtual "group 0", representing all lights on a bridge, is now implemented for the v1 api.
 - Usernames for api v1 can now be any string, instead of only valid uuids.
 - The "create user" endpoint can now reply with the "client key" needed for Entertainment Mode / Sync streams.
 - The reported capabilities have been increased to report lots of space for activities.
