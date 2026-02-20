#!/bin/bash

# Launch the Omarchy Menu or takes a parameter to jump straight to a submenu.

export PATH="$HOME/.config/hypr/scripts:$PATH"

# Set to true when going directly to a submenu, so we can exit directly
BACK_TO_EXIT=false

back_to() {
  local parent_menu="$1"

  if [[ "$BACK_TO_EXIT" == "true" ]]; then
    exit 0
  elif [[ -n "$parent_menu" ]]; then
    "$parent_menu"
  else
    show_main_menu
  fi
}

menu() {
  local prompt="$1"
  local options="$2"
  local extra="$3"
  local preselect="$4"

  read -r -a args <<<"$extra"

  if [[ -n "$preselect" ]]; then
    local index
    index=$(echo -e "$options" | grep -nxF "$preselect" | cut -d: -f1)
    if [[ -n "$index" ]]; then
      args+=("-c" "$index")
    fi
  fi

  echo -e "$options" | launcher.sh --dmenu --width 295 --minheight 1 --maxheight 630 -p "$prompt…" "${args[@]}" 2>/dev/null
}

show_setup_power_menu() {
  profile=$(menu "Power Profile" "$(powerprofiles.sh)" "" "$(tlpctl get)")

  if [[ "$profile" == "CNCLD" || -z "$profile" ]]; then
    back_to show_setup_menu
  else
    tlpctl set "$profile"
  fi
}

show_system_menu() {
  local options="  Lock\n󱄄  Screensaver (na)"
  options="$options\n󰜉  Restart\n󰐥  Shutdown"

  case $(menu "System" "$options") in
  *Lock*) lockscreen.sh ;;
  *Screensaver*) ;; #omarchy-launch-screensaver force ;;
  *Restart*) rebootsys.sh ;;
  *Shutdown*) shutdownsys.sh ;;
  *) exit 0 ;;
  esac
}

show_main_menu() {
  go_to_menu "$(menu "Go" "󱓞  Power\n  System")"
}

go_to_menu() {
  case "${1,,}" in
  *power*) show_setup_power_menu ;;
  *system*) show_system_menu ;;
  esac
}

if [[ -n "$1" ]]; then
  BACK_TO_EXIT=true
  go_to_menu "$1"
else
  show_main_menu
fi
