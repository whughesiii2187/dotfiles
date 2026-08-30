#!/usr/bin/env bash
# Toggle/reconcile the eDP-1 laptop panel under DankLinux (DMS + Hyprland's
# own `hl` Lua API).
#
# Self-contained port of Omarchy's omarchy-hyprland-monitor-internal /
# omarchy-hyprland-monitor-clamshell (SUPER+CTRL+Delete and the lid-switch
# clamshell handling in default/hypr/bindings/utilities.lua). Those rely on
# omarchy-hw-*/omarchy-hyprland-* helper binaries and a toggles.lua
# require-all flag-file mechanism that DMS's hyprland.lua doesn't wire in --
# so this reimplements just the on/off/toggle/lid behavior directly against
# `hyprctl`, with a plain marker file standing in for the Lua toggle flag.
set -euo pipefail

INTERNAL_DESC="AU Optronics 0xFA9B"
INTERNAL="desc:$INTERNAL_DESC"
STATE_DIR="$HOME/.local/state/dank"
DISABLED_FLAG="$STATE_DIR/laptop-display-disabled"

notify() {
  dms ipc call toast info "$1" >/dev/null 2>&1 || notify-send "Laptop display" "$1"
}

internal_disabled() {
  [[ $(hyprctl monitors all -j | jq -r --arg d "$INTERNAL_DESC" '.[] | select(.description == $d) | .disabled') == "true" ]]
}

other_monitor_active() {
  hyprctl monitors -j | jq -e --arg d "$INTERNAL_DESC" '[.[] | select(.description != $d)] | length > 0' >/dev/null
}

lid_closed() {
  [[ $(busctl get-property org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager LidClosed 2>/dev/null) == "b true" ]]
}

enable() {
  hyprctl eval "hl.monitor({ output = \"$INTERNAL\", disabled = false })" >/dev/null
  hyprctl dispatch "hl.dsp.dpms({ action = \"enable\" })" >/dev/null 2>&1 || true
  rm -f "$DISABLED_FLAG"
  notify "Laptop display enabled"
}

disable() {
  if ! other_monitor_active; then
    notify "Can't disable the only active display"
    exit 1
  fi
  hyprctl eval "hl.monitor({ output = \"$INTERNAL\", disabled = true })" >/dev/null
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
# monitor. A bare lid close with no external display is a normal
# suspend -- leave the panel alone and let systemd-logind handle sleep.
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
# justified that goes away, there is nothing left to look at. Called by
# monitor-watch.py on every Hyprland monitoradded/monitorremoved event, so
# this must override the manual-disable flag -- zero displays beats
# respecting a preference nobody can see to reverse.
#
# Second branch covers the reverse ordering: docking while the lid is
# *already* closed. lid_close() only fires on the switch:on transition, so
# if the lid closed first with no external monitor yet (a bare lid close --
# left alone, see lid_close() above), plugging in a dock afterwards never
# re-checked anything and the panel stayed on. Found 2026-08-20: docked
# while lid-closed, panel stayed lit for ~2 minutes until manually toggled.
reconcile() {
  if internal_disabled && ! other_monitor_active; then
    enable
  elif ! internal_disabled && lid_closed && other_monitor_active; then
    disable
  fi
}

case "${1:-}" in
  on) enable ;;
  off) disable ;;
  toggle) toggle ;;
  lid-close) lid_close ;;
  lid-open) lid_open ;;
  reconcile) reconcile ;;
  *)
    echo "Usage: $(basename "$0") {on|off|toggle|lid-close|lid-open|reconcile}" >&2
    exit 1
    ;;
esac
