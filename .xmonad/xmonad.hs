import Control.Monad (liftM2)
import Data.List
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat)
import qualified XMonad.StackSet as W
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myTerminal = "terminator"
myModMask = mod4Mask
myNormalBorderColor = "#bada55"
myFocusedBorderColor = "#ed1c25"

myBorderWidth = 1

myWorkspaces = ["web","chat","dev","media","browse"] ++ map show [6..9]

myManageHook = composeAll . concat $
    [
        [className =? c   --> doShift "web" |    c <- myWebApps]
    ,   [className =? c   --> doShift "chat" |    c <- myChatApps]
    ]
    where
        myWebApps = ["Firefox","Google-chrome"]
        myChatApps = ["Skype"]

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
