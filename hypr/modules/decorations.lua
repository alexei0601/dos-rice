-----------------------
---- LOOK AND FEEL ----
-----------------------
-- DOSrice: flat, angular, no blur, no soft shadows — CRT-era aesthetic.
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 4,

        border_size = 2,

        col = {
            -- Solid colors instead of gradients: DOS didn't do gradients.
            -- White/bright border for active windows, dim gray for inactive.
            active_border   = "rgba(ffffffee)",
            inactive_border = "rgba(555555aa)",
        },

        resize_on_border = false,
        allow_tearing = false,
    },

    decoration = {
        -- Flat and square, no rounded corners.
        rounding       = 0,
        rounding_power = 2,

        -- No transparency: solid windows only.
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = false,
        },
    },

    animations = {
        -- Keep enabled but snappy/linear — sharp cuts instead of soft easing.
        enabled = true,
    },
})

-- Alternative: flat/linear animations for a snappier, more DOS-authentic feel.
-- Tried it, but it felt too abrupt for daily use — keeping the original
-- spring/easing animations below instead. Left here for reference in case
-- I want to revisit this later.

-- Simple linear curve for a snappier, less "modern" feel
--hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })

--hl.animation({ leaf = "global",     enabled = true, speed = 6,   bezier = "linear" })
--hl.animation({ leaf = "border",     enabled = true, speed = 4,   bezier = "linear" })
--hl.animation({ leaf = "windows",    enabled = true, speed = 3,   bezier = "linear" })
--hl.animation({ leaf = "windowsIn",  enabled = true, speed = 3,   bezier = "linear" })
--hl.animation({ leaf = "windowsOut", enabled = true, speed = 3,   bezier = "linear" })
--hl.animation({ leaf = "fadeIn",     enabled = true, speed = 2,   bezier = "linear" })
--hl.animation({ leaf = "fadeOut",    enabled = true, speed = 2,   bezier = "linear" })
--hl.animation({ leaf = "fade",       enabled = true, speed = 2,   bezier = "linear" })
--hl.animation({ leaf = "layers",     enabled = true, speed = 3,   bezier = "linear" })
--hl.animation({ leaf = "workspaces", enabled = true, speed = 2,   bezier = "linear" })

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })
