### 2025-04-29: `chrivers/better-eventstream`

When hue objects are updated, the even stream offers live updates of changed properties, to allow clients (e.g. the Hue App) to track the changes over time.

So far, our mode of these eventstream blocks have been the same as for PUT updates.

It turns out this is *almost* correct, but subtle wrong.

Instead, the event streams are based on diffing json values, and including new and changed sub-values.

Also, certain properties should *always* be included, if present. Most notably, the `.owner` field (see #76, which might be fixed by this.)

Other clients might also be affected (improved) by this (see #122)
