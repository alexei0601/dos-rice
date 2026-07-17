    ---------------------
    ---- MY PROGRAMS ----
    ---------------------

    -- Set programs that you use
    local terminal    = "alacritty"
    local fileManager = "thunar"
    local menu        = "wofi --show drun"
    local reboot      = "hyprctl reload"
    ---------------------
    ---- KEYBINDINGS ----
    ---------------------

    local mainMod = "SUPER" -- Sets "Windows" key as main modifier
    
    -- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
    hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
    local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
    -- closeWindowBind:set_enabled(false)
    hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
    hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
    hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
    hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
    hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
    hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(reboot))
    hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("zen-browser"))

    -- Move focus with mainMod + arrow keys
    hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
    hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
    hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

    -- Switch workspaces with mainMod + [0-9]
    -- Move active window to a workspace with mainMod + SHIFT + [0-9]
    for i = 1, 10 do
        local key = i % 10 -- 10 maps to key 0
        hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
        hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    end

    -- Example special workspace (scratchpad)
    hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
    hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
    hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.move({ workspace = "r+0" })) -- Sacar del scratchpad al workspace actual
    -- Scroll through existing workspaces with mainMod + scroll
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

    -- Move/resize windows with mainMod + LMB/RMB and dragging
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Laptop multimedia keys for volume and LCD brightness
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
    hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

    -- Requires playerctl
    hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

    -- Salida de emergencia: funciona en cualquier submap
    hl.bind("SUPER + SHIFT + ESCAPE", hl.dsp.submap("reset"), { submap_universal = true })

    -- Resize
    hl.bind("ALT + R", hl.dsp.submap("resize"))

    hl.define_submap("resize", function()
        hl.bind("right", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
        hl.bind("left",  hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
        hl.bind("up",    hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
        hl.bind("down",  hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })
        hl.bind("escape", hl.dsp.submap("reset"))
    end)

    -----------------------------
    ---- CLIPBOARD HISTORY ------
    -----------------------------
    -- Requiere: cliphist, wl-clipboard, wofi
    -- SUPER + SHIFT + V abre el historial del portapapeles (texto e imágenes)
    hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(
        "cliphist list | wofi --dmenu --prompt 'Portapapeles' | cliphist decode | wl-copy"
    ))

    --------------------------
    ---- SCREENSHOTS ----------
    --------------------------
    -- Requiere: hyprshot (AUR), grim, slurp, wl-clipboard, libnotify

    -- Guardan en $HYPRSHOT_DIR (definido en env.lua) Y copian al portapapeles:
    -- PRINT                  -> selecciona una region con el mouse
    hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
    -- SUPER + PRINT          -> captura la ventana activa
    hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
    -- SUPER + SHIFT + PRINT  -> captura el monitor completo
    hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))

    -- Solo copian al portapapeles, NO guardan ningun archivo:
    -- ALT + PRINT                 -> region, solo portapapeles
    hl.bind("ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
    -- SUPER + ALT + PRINT         -> ventana activa, solo portapapeles
    hl.bind(mainMod .. " + ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))
    -- SUPER + ALT + SHIFT + PRINT -> monitor completo, solo portapapeles
    hl.bind(mainMod .. " + ALT + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))