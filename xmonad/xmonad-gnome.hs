import XMonad

import XMonad.Actions.CycleWS

import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Layout.Tabbed
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageHelpers (doCenterFloat, isInProperty, isFullscreen, doFullFloat)

import XMonad.Layout
import XMonad.Layout.Circle
import XMonad.Layout.Grid
import XMonad.Layout.LayoutHints
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.WindowNavigation

import Data.Ratio

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


main = xmonad $ gnomeConfig
       { terminal = "gnome-terminal"
       , modMask = mod4Mask

       -- add manage hooks while still ignoring panels and using default manageHooks
       , manageHook = composeAll
                      [ manageHook gnomeConfig
                      , title =? "foo" --> doShift "2"
                      , isFullscreen --> doFullFloat
                      ]

       , layoutHook = myLayout

       -- , logHook = do
       --   dynamicLogWithPP xmobarPP
       --   updatePointer (Relative 0.9 0.9)
       --   logHook desktopConfig
       }
       -- add a screenshot key to the default desktop bindings
       `additionalKeys`
       [ ((mod4Mask, xK_F8), spawn "scrot") ]
       `additionalKeysP`
       [ ("M-m", spawn "echo 'Hi, mom!' | dzen2 -p 4")
       , ("M-<Backspace>", withFocused hide) -- N.B. this is an absurd thing to do

       , ("M-<Left>", prevWS)
       , ("M-<Right>", nextWS)
       ]
