-- Personal DankLinux (DMS) overrides for Hyprland.
--
-- Load this FIRST from hyprland.lua, right after DMS's own
-- colors/outputs/layout/cursor/binds/binds-user/windowrules requires, and
-- BEFORE hypr_overrides.lua, e.g.:
--   require("dms.windowrules")
--   require("dank_overrides")
--   require("hypr_overrides")
--
-- Load order matters here: Hyprland fires every bind registered for a given
-- key combo, it doesn't replace an existing one the way niri's KDL binds do
-- (see niri_overrides.kdl's header). So a DMS default has to be
-- hl.unbind()'d before hypr_overrides.lua registers its own replacement on
-- the same key, or both would fire. This file's unbinds run first; the
-- actual replacement actions -- plain hyprctl/wpctl/script calls that don't
-- depend on DMS at all -- live in hypr_overrides.lua instead.
--
-- What's left here besides unbinds: keybinds that are DMS UI features with
-- no generic equivalent (keybind menu), and the lock keybind -- its command
-- is generic (`loginctl lock-session`), but it still reclaims a DMS-default
-- key so it's grouped with the rest of the DMS-default reclaiming for now.

------------------------------------------------------------------
-- Keybinds
------------------------------------------------------------------

-- Keybind menu
-- DMS already binds SUPER + SHIFT + Slash to this same command; kept here
-- too as a second, Omarchy-muscle-memory way to open it.
hl.bind(
	"SUPER + CTRL + K",
	hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"),
	{ description = "Show key bindings" }
)

-- Screen lock
-- SUPER + ALT + L below reclaims DMS's default lock shortcut for monitor
-- movement, so re-home the lock command on SUPER + CTRL + L instead.
--
-- `loginctl lock-session` instead of `dms ipc call lock lock`: this is the
-- standard systemd-logind lock call, not a DMS-specific one. DMS's
-- "loginctlLockIntegration" setting (Lock Screen settings tab, on by
-- default -- see /usr/share/quickshell/dms/Modules/Lock/Lock.qml) already
-- subscribes to logind's own session-lock dbus signal and shows DMS's
-- native lock screen in response, so this has the same effect as the direct
-- IPC call.
hl.bind("SUPER + CTRL + L", hl.dsp.exec_cmd("loginctl lock-session"), { description = "Lock screen" })

-- Volume keys
-- DMS's default binds (dms/binds.lua) route these through
-- `dms ipc call audio increment/decrement/mute`, which goes through
-- Quickshell's native PwNode.audio write path. On the Logi Z207 Bluetooth
-- speaker that write silently no-ops -- the OSD slider updates locally but
-- the change never reaches the real PipeWire sink. Unbind here so
-- hypr_overrides.lua's wpctl-based bind is the only one that fires -- see
-- that file for the actual replacement.
hl.unbind("XF86AudioRaiseVolume")
hl.unbind("XF86AudioLowerVolume")
hl.unbind("XF86AudioMute")

-- Move workspace to another monitor.
-- DMS doesn't bind ALT + H/J/K, but SUPER + ALT + L is DMS's screen-lock
-- shortcut (dms/binds.lua) -- unbind it here so hypr_overrides.lua is free
-- to rebind the whole row to workspace-move, same as this override did
-- under Omarchy.
hl.unbind("SUPER + ALT + H")
hl.unbind("SUPER + ALT + J")
hl.unbind("SUPER + ALT + K")
hl.unbind("SUPER + ALT + L")

-- Swap active window with the one next to it.
-- DMS binds plain SUPER + SHIFT + H/J/K/L to window MOVE (dms/binds.lua);
-- unbind here so hypr_overrides.lua can rebind them to SWAP instead.
hl.unbind("SUPER + SHIFT + H")
hl.unbind("SUPER + SHIFT + J")
hl.unbind("SUPER + SHIFT + K")
hl.unbind("SUPER + SHIFT + L")
