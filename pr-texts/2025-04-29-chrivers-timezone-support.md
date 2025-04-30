### 2025-04-29: `chrivers/timezone-support`

Implement proper timezone support.

With these changes, the `bifrost.timezone` field in `config.yaml` is actually used to calculate the `.localtime` time field of the API config.

Multiple people have reported that this support (combined with *actually* setting the correct timezone), resolves their problems with connecting to Bifrost (see for example https://github.com/chrivers/bifrost/issues/88)
