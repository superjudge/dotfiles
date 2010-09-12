-- -*- mode: haskell; coding: utf-8 -*-

--
-- XMonad configuration file
--
import XMonad

import XMonad.Actions.CycleWS
import XMonad.Actions.Warp

import XMonad.Config.Desktop
import XMonad.Config.Gnome

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doCenterFloat, isInProperty, isFullscreen, doFullFloat)

import XMonad.Layout
import XMonad.Layout.Circle
import XMonad.Layout.Grid
import XMonad.Layout.LayoutHints
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowNavigation

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh

import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Scratchpad (scratchpadSpawnAction, scratchpadManageHook, scratchpadFilterOutWorkspace)
import XMonad.Util.WorkspaceCompare (getSortByIndex)

import IO
import Data.Ratio
import System.Exit

import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- My preferred terminal program
-- myTerminal      = "urxvt"
myTerminal      = "gnome-terminal"

-- Window border width in pixels
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
myModMask       = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["α", "β" ,"γ", "δ", "ε", "ζ", "η", "θ", "ι"]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor  = "grey30"
myFocusedBorderColor = "goldenrod"

-- Key bindings. Add, modify or remove key bindings here.
myKeys =
         [ -- Launch terminal
           -- ("M-S-<Return>", spawn $ XMonad.terminal conf)

           -- launch dmenu
           ("M-p", spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

         -- launch emacs
         , ("M-e", spawn "emacsclient -c")
         , ("M-e", spawn "emacsclient -c")

         -- launch Eclipse
         -- , ("M-e", spawn "eclipse -nosplash")

         -- launch gmrun
         , ("M-S-p", spawn "gmrun")

         -- close focused window
         , ("M-S-c", kill)

         -- Rotate through the available layout algorithms
         , ("M-<Space>", sendMessage NextLayout)

         --  Reset the layouts on the current workspace to default
         -- , ("M-S-<Space>", setLayout $ XMonad.layoutHook conf)

         -- Resize viewed windows to the correct size
         , ("M-n", refresh)

         -- Move focus to the next window
         , ("M-<Tab>", windows W.focusDown)

         -- Move focus to the next window
         , ("M-j", windows W.focusDown)

         -- Move focus to the previous window
         , ("M-k", windows W.focusUp  )

         -- Move focus to the master window
         , ("M-m", windows W.focusMaster  )

         -- Swap the focused window and the master window
         , ("M-<Return>", windows W.swapMaster)

         -- Swap the focused window with the next window
         , ("M-S-j", windows W.swapDown  )

         -- Swap the focused window with the previous window
         , ("M-S-k", windows W.swapUp    )

         -- Shrink the master area
         , ("M-h", sendMessage Shrink)

         -- Expand the master area
         , ("M-l", sendMessage Expand)

         -- Push window back into tiling
         , ("M-t", withFocused $ windows . W.sink)

         -- Increment the number of windows in the master area
         , ("M-,", sendMessage (IncMasterN 1))

         -- Deincrement the number of windows in the master area
         , ("M-.", sendMessage (IncMasterN (-1)))

         -- toggle the status bar gap (used with avoidStruts from Hooks.ManageDocks)
         -- , ((modm , xK_b ), sendMessage ToggleStruts)

         -- Quit xmonad
         , ("M-S-q", io (exitWith ExitSuccess))

         -- Restart xmonad
         , ("M-q", restart "xmonad" True)

         -- SSH Prompt
         , ("M-C-s", sshPrompt defaultXPConfig)
         , ("M-C-x", shellPrompt defaultXPConfig { position = Top })

         -- Scratchpad
         , ("M-s", scratchpadSpawnAction gnomeConfig { terminal = myTerminal })

         -- Start terminals
         , ("M-a", spawn "urxvt -fn 'xft:Consolas:pixelsize=13' -bg '#101010'")
         , ("M-z", spawn "urxvtcd -e screen -x")
         , ("M-S-z", spawn "urxvtcd -fn 'xft:Consolas:pixelsize=13' -bg '#101010' -e screen -x")

         -- Banish mouse pointer
         , ("M-b", banish LowerRight)

         -- Window navigation
         , ("M-<Right>", sendMessage $ Go R)
         , ("M-<Left>",  sendMessage $ Go L)
         , ("M-<Up>",    sendMessage $ Go U)
         , ("M-<Down>",  sendMessage $ Go D)

         , ("M-C-<Right>", sendMessage $ Swap R)
         , ("M-C-<Left>",  sendMessage $ Swap L)
         , ("M-C-<Up>",    sendMessage $ Swap U)
         , ("M-C-<Down>",  sendMessage $ Swap D)

         , ("M-C-S-<Right>", sendMessage $ Move R)
         , ("M-C-S-<Left>",  sendMessage $ Move L)
         , ("M-C-S-<Up>",    sendMessage $ Move U)
         , ("M-C-S-<Down>",  sendMessage $ Move D)

         , ("M-m", spawn "echo 'Hi, mom!' | dzen2 -p 4")
         , ("M-<Backspace>", withFocused hide) -- N.B. this is an absurd thing to do

         , ("M-<Left>", prevWS)
         , ("M-<Right>", nextWS)
         ]

-- Mouse bindings
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- Window layouts
myLayout = desktopLayoutModifiers (tiled ||| Mirror tiled ||| Circle ||| magnify Grid ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Percent of screen to increment by when resizing panes
     delta = 3/100

     -- Default proportion of screen occupied by master pane
     ratio = toRational (2 / (1 + sqrt (5))::Double)

     magnify = magnifiercz (12%10)

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
myManageHook = manageDocks <+>
               scratchpadManageHook (W.RationalRect 0.25 0.375 0.5 0.35) <+>
               composeAll
    [ manageHook gnomeConfig
    , title =? "foo" --> doShift "2"
    , className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    -- , q_eclipse_spl                 --> doCenterFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isFullscreen                  --> doFullFloat
    ]

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

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

-- Now run XMonad
main = xmonad $ defaults
       --{

       -- add manage hooks while still ignoring panels and using default manageHooks
       -- , manageHook = composeAll
       --                [ manageHook gnomeConfig
       --                , title =? "foo" --> doShift "2"
       --                , isFullscreen --> doFullFloat
       --                ]

       -- , layoutHook = myLayout

       -- , logHook = do
       --   dynamicLogWithPP xmobarPP
       --   updatePointer (Relative 0.9 0.9)
       --   logHook desktopConfig
       --}
       -- add a screenshot key to the default desktop bindings
       `additionalKeys` [ ((mod4Mask, xK_F8), spawn "scrot") ]
       `additionalKeysP` myKeys

defaults = gnomeConfig {
      -- simple stuff
      terminal           = myTerminal,
      focusFollowsMouse  = myFocusFollowsMouse,
      borderWidth        = myBorderWidth,
      modMask            = myModMask,
      numlockMask        = myNumlockMask,
      workspaces         = myWorkspaces,
      normalBorderColor  = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,

      -- keys               = myKeys,
      mouseBindings      = myMouseBindings,

      -- hooks, layouts
      layoutHook         = myLayout,
      manageHook         = myManageHook,
      logHook            = myLogHook,
      startupHook        = myStartupHook
}
