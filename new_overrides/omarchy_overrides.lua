------------------------------------------------------------------
-- Keybinds
------------------------------------------------------------------

-- Screenshots
-- Native wlroots-ecosystem tools (grim/slurp/wl-copy/swappy) instead of
-- Omarchy's omarchy-capture-screenshot wrapper script.
-- hl.bind("SUPER + CTRL + 3", hl.dsp.exec_cmd("grim - | wl-copy"), { description = "Screenshot fullscreen to clipboard" })
-- hl.bind("SUPER + CTRL + 4", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'), { description = "Screenshot area with editing" })
-- hl.bind("SUPER + CTRL + 5", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png"), { description = "Screenshot fullscreen to file" })

-- Keybind menu
-- Not handled here -- left to the shell (quickshell/DMS), same as
-- dank_overrides.lua's `dms ipc call keybinds toggle hyprland` bind.

-- Vim-style window focus (h/j/k/l).
-- SUPER + J and SUPER + L are claimed by Omarchy defaults as of this
-- writing (toggle window split / toggle workspace layout) -- unbind those
-- to reclaim them. Plain SUPER + H and SUPER + K don't appear to be bound
-- by default, but confirm with `hyprctl binds` after reload in case that
-- changes in a future Omarchy update.
-- hl.unbind("SUPER + H")
-- hl.unbind("SUPER + J")
-- hl.unbind("SUPER + K")
-- hl.unbind("SUPER + L")
-- hl.unbind("SUPER + ALT + H")
-- hl.unbind("SUPER + ALT + J")
-- hl.unbind("SUPER + ALT + K")
-- hl.unbind("SUPER + ALT + L")

-- hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }), { description = "Move window focus left" })
-- hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }), { description = "Move window focus down" })
-- hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }), { description = "Move window focus up" })
-- hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }), { description = "Move window focus right" })

-- Move workspace to another monitor
-- hl.bind("SUPER + ALT + H", hl.dsp.workspace.move({ monitor = "l" }), { description = "Move workspace to left monitor" })
-- hl.bind("SUPER + ALT + J", hl.dsp.workspace.move({ monitor = "d" }), { description = "Move workspace to down monitor" })
-- hl.bind("SUPER + ALT + K", hl.dsp.workspace.move({ monitor = "u" }), { description = "Move workspace to up monitor" })
-- hl.bind("SUPER + ALT + L", hl.dsp.workspace.move({ monitor = "r" }), { description = "Move workspace to right monitor" })

-- Swap active window with the one next to it
-- hl.bind("SUPER + SHIFT + H", hl.dsp.window.swap({ direction = "l" }), { description = "Swap window to the left" })
-- hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "d" }), { description = "Swap window down" })
-- hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "u" }), { description = "Swap window up" })
-- hl.bind("SUPER + SHIFT + L", hl.dsp.window.swap({ direction = "r" }), { description = "Swap window to the right" })

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
