from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    Key(
        [mod], "k",
        lazy.layout.down()
    ),
    Key(
        [mod], "j",
        lazy.layout.up()
    ),

    # Move windows up or down in current stack
    Key(
        [mod, "control"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [mod, "control"], "j",
        lazy.layout.shuffle_up()
    ),

    # Switch window focus to other pane(s) of stack
    Key(
        [mod], "space",
        lazy.layout.next()
    ),

    # Swap panes of split stack
    Key(
        [mod, "shift"], "space",
        lazy.layout.rotate()
    ),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"], "Return",
        lazy.layout.toggle_split()
    ),
    Key([mod], "Return", lazy.spawn("gnome-terminal")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "space", lazy.spawncmd()),
]

groups = [Group(i) for i in "12345"]

for i in groups:
    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i.name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name))
    )

layout_kwargs = {
    'border_width': 0
}

layouts = [
    layout.Max(),
    layout.MonadTall(**layout_kwargs)
]

widget_defaults = {
    'font': 'Source Code Pro',
    'fontsize': 13,
    'padding': 1,
    'background': "002b36",
    'foreground': "859900",
    'error_message': '',  # Battery
    'default_timeout': 5,  # notify
    'format': '%H:%M:%S',  # clock
    'active': '93a1a1',  # groupbox
    'inactive': '586e75',  # groupbox
    'rounded': False,  # groupbox
    'this_current_screen_border': 'cb4b16'  # groupbox
}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Notify(),
                widget.Systray(),
                widget.Clock(),
                widget.Battery()
            ],
            22
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

@hook.subscribe.client_new
def dialogs(window):
    if(window.window.get_wm_type() == 'dialog'
        or window.window.get_wm_transient_for()):
        window.floating = True
