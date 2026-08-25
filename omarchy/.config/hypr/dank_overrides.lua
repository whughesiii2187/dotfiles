-- Personal DankLinux (DMS) overrides.
--
-- Load this LAST from hyprland.lua, after DMS's own
-- colors/outputs/layout/cursor/binds/binds-user/windowrules requires, e.g.:
--   require("dms.windowrules")
--   require("dank_overrides")

------------------------------------------------------------------
-- Keybinds
------------------------------------------------------------------

-- Screenshots
-- Omarchy's omarchy-capture-screenshot isn't installed under DankLinux;
-- repointed at DMS's own `dms screenshot` (see `dms screenshot --help`).
hl.bind(
	"SUPER + CTRL + 3",
	hl.dsp.exec_cmd("dms screenshot full --no-file"),
	{ description = "Screenshot fullscreen to clipboard" }
)
hl.bind(
	"SUPER + CTRL + 4",
	hl.dsp.exec_cmd("dms screenshot region"),
	{ description = "Screenshot area (select region)" }
)
hl.bind(
	"SUPER + CTRL + 5",
	hl.dsp.exec_cmd("dms screenshot full --no-clipboard"),
	{ description = "Screenshot fullscreen to file" }
)
-- Note: unlike omarchy-capture-screenshot, DMS has no built-in post-capture
-- editor. If you want that back, install swappy/satty and pipe via
-- `dms screenshot region --stdout | swappy -f -`.

-- Keybind menu
-- DMS already binds SUPER + SHIFT + Slash to this same command; kept here
-- too as a second, Omarchy-muscle-memory way to open it.
hl.bind(
	"SUPER + CTRL + K",
	hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"),
	{ description = "Show key bindings" }
)

-- Toggle Window Opacity
hl.bind("SUPER + BACKSPACE", hl.dsp.window.set_prop({ window = "activewindow", prop = "opaque", value = "toggle" }))

-- Screen lock
-- SUPER + ALT + L below reclaims DMS's default lock shortcut for monitor
-- movement, so re-home the lock command on SUPER + CTRL + L instead.
hl.bind("SUPER + CTRL + L", hl.dsp.exec_cmd("dms ipc call lock lock"), { description = "Lock screen" })

-- Volume keys
-- DMS's default binds (dms/binds.lua) route these through
-- `dms ipc call audio increment/decrement/mute`, which goes through
-- Quickshell's native PwNode.audio write path. On the Logi Z207 Bluetooth
-- speaker that write silently no-ops -- the OSD slider updates locally but
-- the change never reaches the real PipeWire sink. wpctl writes straight
-- to the live default sink instead, which is confirmed to actually work.
hl.unbind("XF86AudioRaiseVolume")
hl.unbind("XF86AudioLowerVolume")
hl.unbind("XF86AudioMute")
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0"),
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
-- to an external monitor, and recover it on lid-open. Omarchy's own
-- omarchy-hyprland-monitor-internal/-clamshell rely on omarchy-hw-*/
-- omarchy-hyprland-* helper binaries and a toggles.lua flag-file mechanism
-- this DMS config doesn't have, so this is a self-contained reimplementation
-- -- see scripts/laptop-display.sh.
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
-- DMS doesn't bind ALT + H/J/K, but SUPER + ALT + L is DMS's screen-lock
-- shortcut (dms/binds.lua) -- unbinding it here reclaims it for monitor
-- movement, same as this override did under Omarchy.
hl.unbind("SUPER + ALT + H")
hl.unbind("SUPER + ALT + J")
hl.unbind("SUPER + ALT + K")
hl.unbind("SUPER + ALT + L")

hl.bind("SUPER + ALT + H", hl.dsp.workspace.move({ monitor = "l" }), { description = "Move workspace to left monitor" })
hl.bind("SUPER + ALT + J", hl.dsp.workspace.move({ monitor = "d" }), { description = "Move workspace to down monitor" })
hl.bind("SUPER + ALT + K", hl.dsp.workspace.move({ monitor = "u" }), { description = "Move workspace to up monitor" })
hl.bind(
	"SUPER + ALT + L",
	hl.dsp.workspace.move({ monitor = "r" }),
	{ description = "Move workspace to right monitor" }
)

-- Swap active window with the one next to it.
-- DMS binds plain SUPER + SHIFT + H/J/K/L to window MOVE
-- (dms/binds.lua); this overrides them to SWAP instead.
hl.unbind("SUPER + SHIFT + H")
hl.unbind("SUPER + SHIFT + J")
hl.unbind("SUPER + SHIFT + K")
hl.unbind("SUPER + SHIFT + L")

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
		active_opacity = 0.8,
		inactive_opacity = 0.8,
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

------------------------------------------------------------------
-- Monitors
------------------------------------------------------------------
-- Re-declares the two external Dells by desc: (EDID model/serial) rather
-- than DMS's own generated dms/outputs.lua, which uses port names (DP-8,
-- DP-2) -- those can silently swap which physical monitor lands at which
-- position if a cable moves to a different port. eDP-1 (the laptop panel,
-- AU Optronics 0xFA9B) is deliberately left out: DMS's outputs.lua already
-- disables it by default, and laptop-display.sh (bound above) enables it
-- live on lid-open/manual toggle. Declaring it here too used to fight both
-- of those, force-enabling the panel on every DMS/Hyprland restart even
-- while docked with the lid closed.
hl.monitor({
	output = "desc:Dell Inc. DELL U2717D 67YGV66OAUFL",
	mode = "2560x1440@59.95",
	position = "2560x0",
	scale = 1.0,
})
hl.monitor({
	output = "desc:Dell Inc. DELL U2717D 67YGV773AMMS",
	mode = "2560x1440@59.95",
	position = "0x0",
	scale = 1.0,
})

------------------------------------------------------------------
-- Workspaces
------------------------------------------------------------------
-- 5 workspaces per external monitor: odd (1/3/5/7/9) live on the left
-- Dell, even (2/4/6/8/10) on the right Dell -- matched by the same desc:
-- (EDID) identifiers as the monitor rules above, so a workspace's home
-- monitor doesn't shift if a cable moves to a different port.
--
-- `persistent = true` keeps each workspace alive (and on its monitor)
-- even with no windows open, instead of being reshuffled/GC'd. `default`
-- marks the one Hyprland shows on that monitor when nothing else is
-- requested. Neither eDP-1 nor undocked mode needs its own rules here:
-- when both externals disconnect, Hyprland natively reflows all ten
-- workspaces onto whatever monitor remains (the laptop panel), and moves
-- them back the moment their bound monitor reconnects -- that's core
-- Hyprland behavior, not something this config has to implement.
local LEFT_MONITOR = "desc:Dell Inc. DELL U2717D 67YGV773AMMS"
local RIGHT_MONITOR = "desc:Dell Inc. DELL U2717D 67YGV66OAUFL"

for i = 1, 9, 2 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = LEFT_MONITOR,
		default = (i == 1),
		persistent = true,
	})
end
for i = 2, 10, 2 do
	hl.workspace_rule({
		workspace = tostring(i),
		monitor = RIGHT_MONITOR,
		default = (i == 2),
		persistent = true,
	})
end
