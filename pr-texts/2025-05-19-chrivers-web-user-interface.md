### 2025-05-19: `chrivers/web-user-interface`

This is a preview of the upcoming Bifrost web interface!

Eventually, this will be more fleshed out, but already it allows controlling
lights and rooms, and experimental (and work-in-progress) support for
dynamically connecting to new Z2m servers.

> [!IMPORTANT]
> To use this early preview of the web interface with the Bifrost Home Assistant
> add-on, please add the following setting to your `config.yaml`:

```yaml
bifrost:
  frontend_dir: /app/frontend
```

After this change (and a restart of Bifrost), you should be able to visit the
web interface in your browser. It is available on the ip specified under
`bridge` in `config.yaml`.
