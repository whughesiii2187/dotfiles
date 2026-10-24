# Packages needed for the compositor-generic overrides

Tracking what needs to be installed for the shell-agnostic keybinds in
`hypr_overrides.lua` / `niri_overrides.kdl` (and the cleaned-up
`omarchy_overrides.lua` reference copy) to actually work without DMS or
Omarchy installed.

## Screenshots (Hyprland only)

Used in `hypr_overrides.lua` and `omarchy_overrides.lua` in place of
`dms screenshot` / `omarchy-capture-screenshot`. niri doesn't need any of
this -- it has a native screenshot UI (`screenshot`/`screenshot-screen`/
`screenshot-window` actions in `niri_overrides.kdl`), no external tool
required.

- `grim` -- screenshot capture (wlroots)
- `slurp` -- region/window selector for area screenshots
- `wl-clipboard` -- provides `wl-copy`, used to pipe screenshots to clipboard
- `swappy` -- post-capture annotation/editing before save

## Keybind menu

Not a native-compositor concern -- running with quickshell/DMS for now, so
this stays a shell-level (`dms ipc call keybinds toggle hyprland` /
`dms ipc call lock lock`-style IPC) feature in `dank_overrides.lua`/`.kdl`
rather than something needing a standalone package.

## Already generic, no package gap

- Screen lock (`loginctl lock-session`) -- part of systemd, already
  installed on any systemd system. DMS's "loginctlLockIntegration" setting
  (on by default) makes this show DMS's own lock screen, same as
  `dms ipc call lock lock` used to.
- Volume keys (`wpctl set-volume`/`set-mute`) -- part of `wireplumber`,
  already tracked as its own package in this repo.
- Laptop display toggle / lid-switch handling -- just `hyprctl`/`niri msg`
  and the local `scripts/laptop-display-*.sh`, no extra package.
