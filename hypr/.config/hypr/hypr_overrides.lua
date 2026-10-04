-- Personal Hyprland overrides (compositor-generic; no DMS/shell dependency).
--
-- DMS/DankLinux-specific unbinds (and a couple of DMS-only keybinds) live in
-- dank_overrides.lua instead, and it MUST load before this file -- see that
-- file's header for why (Hyprland fires every bind on a key combo, it
-- doesn't replace one the way niri does). Load this LAST from hyprland.lua,
-- e.g.:
--   require("dms.windowrules")
--   require("dank_overrides")
--   require("hypr_overrides")

------------------------------------------------------------------
-- Keybinds
------------------------------------------------------------------

-- Toggle Window Opacity
hl.bind("SUPER + BACKSPACE", hl.dsp.window.set_prop({ window = "activewindow", prop = "opaque", value = "toggle" }))

-- Screenshots
-- grim/slurp/wl-copy/swappy -- the standard wlroots-ecosystem tools, not
-- tied to any particular shell. (niri gets this for free from its own
-- built-in screenshot UI instead -- see niri_overrides.kdl.)
hl.bind(
	"SUPER + CTRL + 3",
	hl.dsp.exec_cmd("grim - | wl-copy"),
	{ description = "Screenshot fullscreen to clipboard" }
)
hl.bind(
	"SUPER + CTRL + 4",
	hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'),
	{ description = "Screenshot area with editing" }
)
hl.bind(
	"SUPER + CTRL + 5",
	hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png"),
	{ description = "Screenshot fullscreen to file" }
)

-- Volume keys
-- wpctl writes straight to the live default sink -- works regardless of
-- which shell (if any) is running, unlike DMS's Quickshell PwNode.audio
-- path. dank_overrides.lua unbinds any shell default on these keys first.
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.5"),
	{ locked = true, repeating = true, description = "Raise volume" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true, description = "Lower volume" }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, description = "Toggle mute" }
)

-- Toggle laptop display (mimics Omarchy's SUPER + CTRL + Delete), plus
-- lid-switch clamshell handling: disable the panel on lid-close when docked
-- to an external monitor, and recover it on lid-open. Just hyprctl, the
-- local script, and Hyprland's own lid-switch/monitor events -- no shell
-- dependency. See scripts/laptop-display.sh.
local laptop_display_script = os.getenv("HOME") .. "/.config/hypr/scripts/laptop-display.sh"
hl.bind(
	"SUPER + CTRL + Delete",
	hl.dsp.exec_cmd(laptop_display_script .. " toggle"),
	{ description = "Toggle laptop display" }
)
hl.bind(
	"switch:on:Lid Switch",
	hl.dsp.exec_cmd(laptop_display_script .. " lid-close"),
	{ description = "Laptop lid closed", locked = true }
)
hl.bind(
	"switch:off:Lid Switch",
	hl.dsp.exec_cmd(laptop_display_script .. " lid-open"),
	{ description = "Laptop lid opened", locked = true }
)

-- Recover the panel if the external monitor that justified disabling it
-- disappears mid-session (basecamp/omarchy#5342/#5346), or re-disable it if
-- an external reappears while the lid is closed.
--
-- Previously this was an external Python daemon polling Hyprland's IPC
-- socket (scripts/monitor-watch.py), kept alive across reloads by a
-- pgrep/setsid guard. Hyprland's Lua engine fires monitor.added/
-- monitor.removed live during the running session on its own (see
-- HL.EventName in /usr/share/hypr/stubs/hl.meta.lua), so that whole
-- external-process dance is unnecessary -- these two handlers replace it.
hl.on("monitor.added", function()
	hl.exec_cmd(laptop_display_script .. " reconcile")
end)
hl.on("monitor.removed", function()
	hl.exec_cmd(laptop_display_script .. " reconcile")
end)

-- Also reconcile once at startup itself: booting (or logging in) already
-- docked with the lid closed needs to be checked immediately, before any
-- monitor.added/monitor.removed event has a reason to fire. See
-- laptop-display.sh's reconcile() for the actual logic.
hl.on("hyprland.start", function()
	hl.exec_cmd(laptop_display_script .. " reconcile")
end)

-- Move workspace to another monitor.
-- dank_overrides.lua unbinds SUPER+ALT+H/J/K/L (freeing SUPER+ALT+L from
-- DMS's default lock shortcut) before this runs.
hl.bind("SUPER + ALT + H", hl.dsp.workspace.move({ monitor = "l" }), { description = "Move workspace to left monitor" })
hl.bind("SUPER + ALT + J", hl.dsp.workspace.move({ monitor = "d" }), { description = "Move workspace to down monitor" })
hl.bind("SUPER + ALT + K", hl.dsp.workspace.move({ monitor = "u" }), { description = "Move workspace to up monitor" })
hl.bind(
	"SUPER + ALT + L",
	hl.dsp.workspace.move({ monitor = "r" }),
	{ description = "Move workspace to right monitor" }
)

-- Swap active window with the one next to it.
-- dank_overrides.lua unbinds SUPER+SHIFT+H/J/K/L (DMS's default window
-- move) before this runs.
hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ direction = "l" }), { description = "Swap window to the left" })
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "d" }), { description = "Swap window down" })
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "u" }), { description = "Swap window up" })
hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap({ direction = "r" }), { description = "Swap window to the right" })

-- Special workspace (scratchpad), matching Omarchy's stock SUPER+S / SUPER+ALT+S.
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special(), { description = "Toggle special workspace" })
hl.bind(
	"SUPER + ALT + S",
	hl.dsp.window.move({ workspace = "special" }),
	{ description = "Move window to special workspace" }
)

------------------------------------------------------------------
-- Input and look-and-feel
------------------------------------------------------------------

hl.config({
	input = {
		kb_layout = "us",
		kb_options = "compose:caps", -- ,grp:alts_toggle

		repeat_rate = 40,
		repeat_delay = 600,

		numlock_by_default = true,

		sensitivity = 0.35,

		follow_mouse = 0,

		natural_scroll = true,

		touchpad = {
			natural_scroll = true,
			clickfinger_behavior = true,
			scroll_factor = 0.4,
		},
	},

	decoration = {
		active_opacity = 0.9,
		inactive_opacity = 0.9,
		dim_inactive = false,
	},

	-- With follow_mouse = 0 above, keyboard focus only moves on click.
	-- mouse_move_focuses_monitor defaults true, which still flags a monitor
	-- "active" just from hovering -- desyncing it from the click-based
	-- keyboard-focus monitor. That makes SUPER + <workspace> a no-op the
	-- first press when the target workspace is already visible on another
	-- monitor (Hyprland thinks you're "already there"), requiring a
	-- SUPER + <current workspace> press first to resync. Disabling this
	-- keeps monitor focus explicit-action-only too, matching follow_mouse.
	misc = {
		mouse_move_focuses_monitor = false,
	},
})
