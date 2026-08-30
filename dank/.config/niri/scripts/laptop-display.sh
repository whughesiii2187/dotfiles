#!/usr/bin/env bash
# Toggle/reconcile the eDP-1 laptop panel under DankLinux (DMS + niri).
#
# Port of ../../hypr/scripts/laptop-display.sh (Hyprland's `hl` Lua API) to
# niri's `niri msg` IPC. Same on/off/toggle/lid/reconcile behavior, driven by
# `niri msg output eDP-1 on|off` and `niri msg -j outputs` instead of
# `hyprctl`. See that file for the full history/rationale of this logic.
set -euo pipefail

STATE_DIR="$HOME/.local/state/dank"
DISABLED_FLAG="$STATE_DIR/laptop-display-disabled"

notify() {
  dms ipc call toast info "$1" >/dev/null 2>&1 || notify-send "Laptop display" "$1"
}

internal_disabled() {
  [[ $(niri msg -j outputs | jq -r '.["eDP-1"].logical == null') == "true" ]]
}

other_monitor_active() {
  niri msg -j outputs | jq -e '[to_entries[] | select(.key != "eDP-1" and .value.logical != null)] | length > 0' >/dev/null
}

lid_closed() {
  [[ $(busctl get-property org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager LidClosed 2>/dev/null) == "b true" ]]
}

enable() {
  niri msg output eDP-1 on >/dev/null
  rm -f "$DISABLED_FLAG"
  notify "Laptop display enabled"
}

disable() {
  if ! other_monitor_active; then
    notify "Can't disable the only active display"
    exit 1
  fi
  niri msg output eDP-1 off >/dev/null
  mkdir -p "$STATE_DIR"
  touch "$DISABLED_FLAG"
  notify "Laptop display disabled"
}

toggle() {
  if internal_disabled; then
    enable
  else
    disable
  fi
}

# Lid closed: only go into clamshell (panel off) when docked to an external
# monitor. Note niri already auto-toggles eDP-1's power on lid events on its
# own (see the `switch-events` doc), but that built-in behavior is purely
# lid-state-driven -- it doesn't know about docked-vs-undocked, so a bare lid
# close with no external display would leave zero displays. This override
# leaves that case alone (a normal suspend, handled by systemd-logind) and
# only acts when there's actually something else to look at.
lid_close() {
  other_monitor_active && disable || true
}

# Lid opened: recover the panel, unless the user manually turned it off via
# the SUPER+CTRL+Delete toggle -- that choice should stick across a lid cycle.
lid_open() {
  [[ -f $DISABLED_FLAG ]] || enable
}

# Safety net for basecamp/omarchy#5342/#5346: if the panel is off (whether
# from the manual toggle or a lid-close) and the external monitor that
# justified that goes away, there is nothing left to look at.
#
# Unlike Hyprland's Lua engine, niri's event-stream IPC (`niri msg
# event-stream`) does not emit an output-added/output-removed event -- outputs
# aren't part of its push-based state. `watch` below polls instead.
reconcile() {
  if internal_disabled && ! other_monitor_active; then
    enable
  elif ! internal_disabled && lid_closed && other_monitor_active; then
    disable
  fi
}

# Poll loop standing in for the monitor.added/monitor.removed hooks the
# Hyprland version gets natively. Runs via spawn-sh-at-startup. `niri msg` is
# a cheap local socket round-trip and reconcile() is idempotent, so a short
# interval is fine.
watch() {
  while true; do
    reconcile
    sleep 5
  done
}

case "${1:-}" in
  on) enable ;;
  off) disable ;;
  toggle) toggle ;;
  lid-close) lid_close ;;
  lid-open) lid_open ;;
  reconcile) reconcile ;;
  watch) watch ;;
  *)
    echo "Usage: $(basename "$0") {on|off|toggle|lid-close|lid-open|reconcile|watch}" >&2
    exit 1
    ;;
esac
