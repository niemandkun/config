import XMonad
import XMonad.Util.Run
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Config.Desktop
import XMonad.Util.CustomKeys
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import Graphics.X11.ExtraTypes.XF86

baseConfig = desktopConfig

deleteKeys conf@(XConfig {modMask = modm}) =
    [ (modm .|. shiftMask, xK_Return)
    , (modm, xK_space)
    , (modm, xK_p)
    , (modm .|. shiftMask, xK_space)
    ] ++
    [ (modm .|. m, k) | (m, k) <- xineramaKeys ]
    where xineramaKeys = zip [0, shiftMask] [xK_w, xK_e, xK_r]

insertKeys conf@(XConfig {modMask = modm}) =
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm, xK_e), sendMessage NextLayout)
    , ((modm, xK_r), spawn "rofi -show run")
    , ((modm .|. shiftMask, xK_e), setLayout $ layoutHook conf)
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 2-")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 2+")
    , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight + 10")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight - 10")
    , ((controlMask, xK_Print), spawn "scrot -s")
    , ((0, xK_Print), spawn "scrot")
    ]

myLogHook pipe = dynamicLogWithPP $ defaultPP
    { ppSep = " "
    , ppCurrent = const "⬤"
    , ppVisible = const "◯"
    , ppHidden = const "◯"
    , ppHiddenNoWindows = (\x -> if (read x) < 5 then "◯" else "")
    , ppTitle = const ""
    , ppLayout = const ""
    , ppOutput = hPutStrLn pipe }

myLayout = tiled ||| Mirror tiled ||| Full
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/2
        delta = 3/100

myLayoutHook = avoidStruts
    $ gaps [(U, 8), (D, 10), (R, 20), (L, 20)]
    $ spacing 8
    $ myLayout

myConfig pipe = baseConfig
    -- Common config
    { terminal = "urxvt"
    , modMask = mod4Mask
    , focusFollowsMouse = True
    , borderWidth = 0
    , workspaces = map show [1 .. 4 :: Int]
    , normalBorderColor = "black"
    , focusedBorderColor = "green"

    -- Hooks
    , startupHook = setWMName "LG3D"
    , logHook = myLogHook pipe
    , manageHook = manageDocks <+> manageHook baseConfig
    , layoutHook = myLayoutHook

    -- Keybindings
    , keys = customKeys deleteKeys insertKeys
    , mouseBindings = mouseBindings baseConfig }

main = do
    spawnPipe "xmobar" >>= xmonad . myConfig
