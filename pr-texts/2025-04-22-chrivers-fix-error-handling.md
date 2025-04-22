### 2025-04-22: `chrivers/fix-error-handling`

Fix error handling: We accidentally double-encoded the error as json, leading to, ironically, error errors.

This should improve api responses when an error is returned. This is mostly a technical fix, with little user-facing impact.
