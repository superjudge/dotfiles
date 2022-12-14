-- -*- mode: haskell; coding: utf-8 -*-

import Data.Ratio
import System.Exit
import XMonad
import XMonad.Actions.Warp
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Layout
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)
import qualified Data.Map        as M
import qualified XMonad.StackSet as W

myKeys = [ ("M-p", spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
         , ("M-S-p", shellPrompt defaultXPConfig { position = Top })

         -- Restart xmonad
         , ("M-S-q", spawn "gnome-session-save --gui --logout-dialog")

         -- SSH Prompt
         , ("M-C-s", sshPrompt defaultXPConfig)

         -- Start terminals
         , ("M-a", spawn "urxvt -fn 'xft:DejaVu Sans Mono:pixelsize=12' -bg '#101010'")
         , ("M-z", spawn "urxvtcd -e screen -x")
         , ("M-S-z", spawn "urxvtcd -fn 'xft:DejaVu Sans Mono:pixelsize=12' -bg '#101010' -e screen -x")

         -- Banish mouse pointer
         , ("M-S-b", banish LowerRight)

         -- Lock Screen
         , ("M-S-l",    spawn "gnome-screensaver-command -l")
         , ("M5-l",     spawn "gnome-screensaver-command -l")
         -- Logout
         , ("M1-M-S-l", spawn "gnome-session-save --gui --kill")
         -- Sleep
         , ("M1-S-'",   spawn "gnome-power-cmd.sh suspend")
         -- Reboot
         , ("M1-S-,",   spawn "gnome-power-cmd.sh reboot")
         -- Deep Sleep
         , ("M1-S-.",   spawn "gnome-power-cmd.sh hibernate")
         -- Death
         , ("M1-S-p",   spawn "gnome-power-cmd.sh shutdown")

         , ("M-i", spawn "setxkbmap -layout us")
         , ("M-o", spawn "setxkbmap -layout se")
         ]

myLayout = desktopLayoutModifiers (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Percent of screen to increment by when resizing panes
     delta = 3/100

     -- Default proportion of screen occupied by master pane
     ratio = toRational (2 / (1 + sqrt (5))::Double)

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
myManageHook = manageDocks <+> composeAll
    [ manageHook gnomeConfig
    , title =? "foo" --> doShift "2"
    , className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isFullscreen                  --> doFullFloat
    ]

-- Status bars and logging
--
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
myLogHook = return ()

-- Startup hook
--
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

main = xmonad $ gnomeConfig {
         terminal           = "gnome-terminal",
         focusFollowsMouse  = False,
         borderWidth        = 1,
         modMask            = mod4Mask,
         workspaces         = ["??", "??" ,"??", "??", "??", "??", "??", "??", "??"],
         normalBorderColor  = "grey30",
         focusedBorderColor = "red",

         -- hooks, layouts
         layoutHook         = myLayout,
         manageHook         = myManageHook,
         logHook            = myLogHook,
         startupHook        = myStartupHook

       -- , logHook = do
       --   dynamicLogWithPP xmobarPP
       --   updatePointer (Relative 0.9 0.9)
       --   logHook desktopConfig
       }
       `additionalKeysP` myKeys
