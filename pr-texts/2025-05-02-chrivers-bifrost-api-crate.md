### 2025-05-02: `chrivers/bifrost-api-crate`

This is a major internal refactoring, moving common code needed for
communication with Bifrost into a separate library ("crate").

Existing crates are reworked to have "features" (compile flags), that allow
partial functionality to be selected at compile time.

In the future, this will allow code to be shared between the backend, and an
upcoming web frontend.

This change also adds support for adding/removing lights from a room, directly from the hue app!
