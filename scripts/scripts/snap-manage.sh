#!/usr/bin/env bash
#
# snap-manage.sh — manage Btrfs/snapper rollbacks on this Fedora system.
#
# Assumes the subvolume layout from the kickstart this was written for:
# top-level subvolumes named "root" (mounted at /) and "home" (mounted at
# /home), each with its own snapper config of the same name.
#
# Root is bootable, so "committing" a snapshot means staging a rollback
# with snapper and rebooting into it.
#
# /home is NOT bootable — it's just a normal mount — so restoring it uses
# `snapper undochange`, which reverts the live filesystem to match a past
# snapshot in place. No reboot or unmounting needed, but anything changed
# or created in /home since that snapshot gets reverted or removed, so
# close open files / log out other sessions first if you can.

set -euo pipefail

ROOT_CONFIG="root"
HOME_CONFIG="home"
ASSUME_YES=0

usage() {
    cat <<'EOF'
snap-manage.sh — manage Btrfs/snapper rollbacks

  snap-manage.sh                Check if booted into a root snapshot and
                                 offer to make it permanent
  snap-manage.sh --home         List /home snapshots, prompt to pick one
  snap-manage.sh --home <N>     Restore /home to snapshot N directly
  snap-manage.sh --home --list  List /home snapshots only, no restore
  snap-manage.sh -y ...         Skip confirmation prompts
  snap-manage.sh -h, --help     Show this help
EOF
}

require_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "Run this as root (sudo $0 ...)." >&2
        exit 1
    fi
}

confirm() {
    [[ $ASSUME_YES -eq 1 ]] && return 0
    local reply
    read -r -p "$1 [y/N] " reply
    [[ "$reply" =~ ^[Yy]$ ]]
}

check_root_snapshot() {
    local fsroot num
    fsroot=$(findmnt -no fsroot /)

    if [[ "$fsroot" =~ ^/root/\.snapshots/([0-9]+)/snapshot$ ]]; then
        num="${BASH_REMATCH[1]}"
        echo "You are currently booted into root snapshot #$num (read-only)."
        echo
        snapper -c "$ROOT_CONFIG" list
        echo
        if confirm "Make snapshot #$num the new permanent root?"; then
            if ! snapper -c "$ROOT_CONFIG" rollback; then
                echo "Plain rollback failed, retrying with --ambit classic..."
                snapper --ambit classic -c "$ROOT_CONFIG" rollback
            fi
            echo "Rollback staged — it takes effect on the next normal boot."
            if confirm "Reboot now?"; then
                systemctl reboot
            else
                echo "Reboot later with: systemctl reboot"
            fi
        else
            echo "Left as-is. You're still running the read-only snapshot this session."
        fi
    else
        echo "Not currently booted into a snapshot."
        echo "(current root subvolume: $fsroot)"
    fi
}

list_home_snapshots() {
    snapper -c "$HOME_CONFIG" list
}

rollback_home() {
    local num="$1"

    echo "This restores /home to the state in snapshot #$num."
    echo "Files changed or created since then will be reverted or removed."
    echo "Close open files / log out other sessions using /home first if possible."
    if confirm "Continue?"; then
        echo "Running: snapper -c $HOME_CONFIG undochange ${num}..0"
        if snapper -c "$HOME_CONFIG" undochange "${num}..0"; then
            echo "Done."
        else
            echo "undochange failed — check that #$num is a valid snapshot number:" >&2
            list_home_snapshots
            exit 1
        fi
    else
        echo "Cancelled."
    fi
}

home_flow() {
    if [[ $# -gt 0 && "$1" == "--list" ]]; then
        list_home_snapshots
        return
    fi

    if [[ $# -gt 0 && "$1" =~ ^[0-9]+$ ]]; then
        rollback_home "$1"
        return
    fi

    echo "Available /home snapshots:"
    echo
    list_home_snapshots
    echo
    local num
    read -r -p "Snapshot number to restore (blank to cancel): " num
    if [[ -n "$num" && "$num" =~ ^[0-9]+$ ]]; then
        rollback_home "$num"
    else
        echo "Cancelled."
    fi
}

main() {
    require_root

    if [[ $# -eq 0 ]]; then
        check_root_snapshot
        return
    fi

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -y|--yes)
                ASSUME_YES=1
                shift
                ;;
            -h|--help)
                usage
                return
                ;;
            --home)
                shift
                home_flow "$@"
                return
                ;;
            *)
                echo "Unknown argument: $1" >&2
                usage
                exit 1
                ;;
        esac
    done

    # only -y was given, no subcommand
    check_root_snapshot
}

main "$@"
