### 2025-04-21: `chrivers/websocket-tls`

Implement support for using TLS with websockets ("wss://" urls)

A few users are reporting that they use TLS for their z2m websockets, and this
has previously not been supported.

With these changes, the z2m websocket urls can be specified as "wss://..."
instead of "ws://..." to enable TLS.

Additionally, a new (optional) z2m per-server config option,
`disable_tls_verify` has been added, to optionally turn TLS verification
off. This is useful for certain testing scenarios, where self-signed
certificates might be used.
