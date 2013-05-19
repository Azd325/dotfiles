import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import Control.Monad (liftM2)
import Data.List


------------------------------------------------------------------------
-- Terminal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "terminator"

myModMask = mod4Mask
myNormalBorderColor = "#bada55"
myFocusedBorderColor = "#ed1c25"
myBorderWidth = 1

------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces = ["1:term","2:web","3:code","4:chat","5:media"] ++ map show [6..9]

------------------------------------------------------------------------
-- Window rules
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
--
myManageHook = composeAll
    [ className =? "Chromium"      	--> doShift "2:web"
    , resource  =? "desktop_window" --> doIgnore
    , className =? "Steam"          --> doFloat
    , className =? "Gimp"           --> doFloat
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmh defaultConfig
        { workspaces = myWorkspaces
        , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
        , manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = myModMask
        , terminal = myTerminal
        , normalBorderColor = myNormalBorderColor
        ,focusedBorderColor = myFocusedBorderColor
        , borderWidth = myBorderWidth
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_l), spawn "slock") -- put lock screen on mod + shift + l
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]

