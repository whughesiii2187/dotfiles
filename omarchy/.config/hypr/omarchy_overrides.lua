------------------------------------------------------------------
-- Keybinds
------------------------------------------------------------------

-- Screenshots
o.bind("SUPER + CTRL + 3", "Screenshot fullscreen to clipboard", "omarchy-capture-screenshot smart clipboard")
o.bind("SUPER + CTRL + 4", "Screenshot area with editing", "omarchy-capture-screenshot")
o.bind("SUPER + CTRL + 5", "Screenshot fullscreen to file", "omarchy-capture-screenshot smart")

-- Keybind menu
o.bind("SUPER + CTRL + K", "Show key bindings", "omarchy-menu-keybindings")

-- Vim-style window focus (h/j/k/l).
-- SUPER + J and SUPER + L are claimed by Omarchy defaults as of this
-- writing (toggle window split / toggle workspace layout) -- unbind those
-- to reclaim them. Plain SUPER + H and SUPER + K don't appear to be bound
-- by default, but confirm with `hyprctl binds` after reload in case that
-- changes in a future Omarchy update.
hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + ALT + H")
hl.unbind("SUPER + ALT + J")
hl.unbind("SUPER + ALT + K")
hl.unbind("SUPER + ALT + L")

o.bind("SUPER + H", "Move window focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Move window focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Move window focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Move window focus right", hl.dsp.focus({ direction = "r" }))

-- Move workspace to another monitor
o.bind("SUPER + ALT + H", "Move workspace to left monitor", hl.dsp.workspace.move({ monitor = "l" }))
o.bind("SUPER + ALT + J", "Move workspace to down monitor", hl.dsp.workspace.move({ monitor = "d" }))
o.bind("SUPER + ALT + K", "Move workspace to up monitor", hl.dsp.workspace.move({ monitor = "u" }))
o.bind("SUPER + ALT + L", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))

-- Swap active window with the one next to it
o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))

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
})

------------------------------------------------------------------
-- Monitors
------------------------------------------------------------------
hl.monitor({ output = "desc:AU Optronics 0xFA9B", mode = "1920x1200@60.03", position = "2151x1440", scale = 1.0 })
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
-- requested. Undocked mode needs no rule of its own: when both externals
-- disconnect, Hyprland natively reflows all ten workspaces onto whatever
-- monitor remains (the laptop panel), and moves them back the moment
-- their bound monitor reconnects -- that's core Hyprland behavior, not
-- something this config has to implement.
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
