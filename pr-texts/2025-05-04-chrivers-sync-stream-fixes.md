### 2025-05-04: `chrivers/sync-stream-fixes`

Major rework of entertainment streaming ("sync mode") for Bifrost!

- Now supports both XY and RGB mode
- Fix stream closing on DTLS timeout/disconnect (no longer left lingering in "active" state).
- Improves compatibility with Hue Sync Box
- Add support for configurable streaming fps limit for each z2m backend
- Increase timeout to match Hue Bridge
- Adjust the smoothing factor (fade speed) to match the frame rate!
- ..this smoothing factor adjustment is not even supported by a Hue Bridge! Only Bifrost :-)
