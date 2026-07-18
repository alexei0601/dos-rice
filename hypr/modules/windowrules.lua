--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Ignore maximize requests from all applications.
-- This helps prevent applications from unexpectedly changing
-- the layout managed by Hyprland.
local suppressMaximizeRule = hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*",
    },

    suppress_event = "maximize",
})

-- Uncomment this to disable the rule:
-- suppressMaximizeRule:set_enabled(false)


-- Fix some dragging issues with XWayland windows.
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})


-- Move the Hyprland command runner to the bottom-right corner.
hl.window_rule({
    name = "move-hyprland-run",
    match = {
        class = "hyprland-run",
    },

    move  = "20 monitor_h-120",
    float = true,
})


-- Pavucontrol floating window.
-- org.pulseaudio.pavucontrol
hl.window_rule({
    name = "float-pavucontrol",
    match = {
        class = "org.pulseaudio.pavucontrol",
    },

    float = true,
    center = true,
})


-- Network management terminal floating window.
-- The terminal must be started with the custom class:
--
-- alacritty --class nmtui-scratchpad -e nmtui
--
-- This allows Hyprland to identify this specific terminal
-- independently from other Alacritty windows.
hl.window_rule({
    name = "float-nmtui",
    match = {
        class = "^nmtui-scratchpad$",
    },

    float = true,
    center = true,
})