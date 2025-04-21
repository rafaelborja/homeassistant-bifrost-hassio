### 2025-03-16: `chrivers/svc-crate`

Implement a new crate ("svc") to manage rust-based micro-services.

Bifrost consists of a number of "things" running independently, while performing work either on request, on a timer, or some combination of the two.

Synchronizing, coordinating and sharing information between all these various parts of Bifrost, takes up a non-trivial amount of the codebase.

That's why we are introducing a dedicates library (a "crate", in rust terminology) for managing services that implement a standardized interface, specifically, the `Service` trait.

This makes it possible to share start/run/stop handling for all services, as well as more advanced features like policies ("if a service fails, what should happen?"), error handling, dependencies, and liveness checks.

This PR introduces and builds up the "svc" crate, but does not change Bifrost to use it, yet.
