### 2025-04-25: `chrivers/hue-route-refactoring`

Refactor all route handling for Hue api v2 ("clip").

Previously, each sub-scope (`/light`, `/scene`, etc) implementer their own routing for that particular set of routes.

This works, but is highly repetitive, and was difficult to manage.

Now, there is only a single router component for the clip api, which dispatches to the relevant handlers for the parts that are implemented in Bifrost.

The biggest change (apart from being much easier to maintain) is that *all* routes are now very cleanly marked as one of

  1) Supported
  2) "Missing" (allowed by protocol, but not supported by Bifrost)
  3) "Denied" (not allowed by protocol, and correctly rejected by Bifrost)

Not only does this prevent duplicated bits of code and boilerplate, it also reduces risk of accidental divergence between various parts of the route handling.
