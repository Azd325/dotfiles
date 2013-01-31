import Control.Monad (liftM2)
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat)
import qualified XMonad.StackSet as W
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "gnome-terminal"
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask
myNormalBorderColor = "#abc123"
myFocusedBorderColor = "#456def"
-- Width of the window border in pixels.
--
myBorderWidth = 3

--myManageHook = composeAll
--    [ isFullscreen --> (doF W.focusDown <+> doFullFloat)
--    , className =? "Gimp"      --> doFloat
--    , className =? "Xmessage"  --> doFloat
--    , manageDocks
--    ]

myWorkspaces = ["web","chat","dev","media","browse"]

myManageHook = composeAll . concat $
    [ -- The applications that go to web
      [ className =? b --> viewShift "web" | b <- myClassWebShifts ]
      -- The applications that go to chat
    , [ resource =? c --> doF (W.shift "chat") | c <- myClassChatShifts ]
    , [ className =? "Git-cola"   --> doFloat ]
    ]
    where
      viewShift = doF . liftM2 (.) W.greedyView W.shift
      myClassWebShifts  = ["Firefox", "Google Chrome"]
      myClassChatShifts = ["Skype"]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig
        { workspaces = myWorkspaces
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