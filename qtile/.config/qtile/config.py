# TODO: add pomodoro <12-03-21> #
# TODO: change opacity of panel  <12-03-21, yourname> #
import json
import os
import re
import socket
import subprocess
from typing import List  # noqa: F401

import libqtile.widget.volume
from libqtile import bar, hook, layout, qtile, widget
from libqtile.command import base, lazy
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile.log_utils import logger

# from custom_widgets.notify import *

# from powerline.bindings.qtile.widget import PowerlineTextBox
mod = "mod4"                                     # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"                             # My terminal of choice

# The Qtile config file location
myConfig = "/home/yogansh/.config/qtile/config.py"

# Scripts
launcher = "/home/yogansh/.config/rofi/launchers/ribbon/launcher.sh"
powermenu = "/home/yogansh/.config/rofi/powermenu/powermenu.sh"
screenshot = "/home/yogansh/.config/rofi/applets/menu/screenshot.sh"
dmsearch = "/home/yogansh/.local/bin/dmsearch"
dmkill = "/home/yogansh/.local/bin/dmkill"
dmclip="/home/yogansh/.config/scripts/clipmagic.sh"
browser = "/usr/bin/librewolf"
newsboat = "alacritty -e newsboat"
screenshotnow = " scrot '/home/yogansh/Pictures/Screenshot_%Y-%m-%d-%S_$wx$h.png' -e 'mv $f $$(xdg-user-dir PICTURES);notify-send \"screenshot captured\"' "

audiofile = "/home/yogansh/.config/qtile/hastydum.ogg"
keys = [
    # The essentials
    Key([mod], "Return",
        lazy.spawn(myTerm+' -e zsh'),
        desc='Launches My Terminal'
        ),
    Key([mod], "Tab",
        lazy.next_layout(),
        desc='Toggle through layouts'
        ),
    Key([mod, "shift"], "Tab",
        lazy.prev_layout(),
        desc='Toggle through layouts'
        ),
    Key([mod, "shift"], "w",
        lazy.window.kill(),
        desc='Kill active window'
        ),
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc='Restart Qtile'
        ),
    Key([mod], "r",
        lazy.spawn(launcher),
        desc="Run rofi"
        ),
    # Scripts
    Key([mod], "e",
        lazy.spawn("/home/yogansh/.local/bin/dmenuunicode"),
        desc="emoji"
        ),
    Key([mod], "s",
        lazy.spawn(screenshotnow),
        desc='Captures screenshot'
        ),

    Key([mod], "F1",
        lazy.spawn('sxiv -r -q -t -o /home/yogansh/wallpapers|xargs -r nitrogen --set-scaled --save'),
        desc='changes wallpaper'
        ),
    # Treetab controls
    Key([mod, "control"], "k",
        lazy.layout.section_up(),
        desc='Move up a section in treetab'
        ),
    Key([mod, "control"], "j",
        lazy.layout.section_down(),
        desc='Move down a section in treetab'
        ),
    # Window controls
    Key([mod], "k",
        lazy.layout.up(),
        desc='Move focus down in current stack pane'
        ),
    Key([mod], "j",
        lazy.layout.down(),
        desc='Move focus up in current stack pane'
        ),
    Key([mod], "h",
        lazy.layout.left(),
        desc='Move focus down in current stack pane'
        ),
    Key([mod], "l",
        lazy.layout.right(),
        desc='Move focus up in current stack pane'
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        desc='Move windows down in current stack'
        ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        desc='Move windows up in current stack'
        ),
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        desc='Move windows down in current stack'
        ),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        desc='Move windows up in current stack'
        ),
    # Key([mod], "h",
    #     lazy.layout.grow(),
    #     lazy.layout.increase_nmaster(),
    #     desc='Expand window (MonadTall), increase number in master pane (Tile)'
    #     ),
    # Key([mod], "l",
    #     lazy.layout.shrink(),
    #     lazy.layout.decrease_nmaster(),
    #     desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
    #     ),
    Key([mod, "control"], "j", lazy.layout.grow_down(),lazy.layout.shrink()),
    Key([mod, "control"], "k", lazy.layout.grow_up(),lazy.layout.grow()),
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod], "n",
        lazy.layout.normalize(),
        desc='normalize window size ratios'
        ),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
        ),
    Key([mod, "shift"], "f",
        lazy.window.toggle_floating(),
        desc='toggle floating'
        ),
    Key([mod, "shift"], "m",
        lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'
        ),
    # Stack controls
    Key([mod, "shift"], "space",
        lazy.layout.rotate(),
        lazy.layout.flip(),
        desc='Switch which side main pane occupies (XmonadTall)'
        ),
    Key([mod], "space",
        lazy.layout.next(),
        desc='Switch window focus to other pane(s) of stack'
        ),
    Key([mod, "control"], "Return",
        lazy.layout.toggle_split(),
        desc='Toggle between split and unsplit sides of stack'
        ),

    # for gnome qtile
    #  Key([mod, 'control'], 'l', lazy.spawn('gnome-screensaver-command -l')),
    # Key([mod, 'control'], 'q', lazy.spawn('gnome-session-quit --logout --no-prompt')),
    # Key([mod, 'shift', 'control'], 'q', lazy.spawn('gnome-session-quit --power-off')),

    # Dmenu scripts launched with ALT + CTRL + KEY
    Key(["mod1", "control"], "q",
        lazy.spawn(powermenu),
        desc='spawns power menu'
        ),
    Key(["mod1", "control"], "s",
        lazy.spawn(screenshot),
        desc='spawns screenshot menu'
        ),
    Key(["mod1", "control"], "x",
        lazy.spawn(dmsearch),
        desc='spawns search menu'
        ),
    Key(["mod1", "control"], "w",
        lazy.spawn(dmkill),
        desc='spawns kill menu'
        ),
    Key(["mod1", "control"], "r",
        lazy.spawn(dmclip),
        desc='spawns clipmagic'
        ),

    # My applications launched with SUPER + ALT + KEY

    Key([mod, "mod1"], "b",
        lazy.spawn(browser),
        desc='spawns brave browser'
        ),
    Key([mod, "mod1"], "n",
        lazy.spawn(newsboat),
        desc='spawns newsboat'
        ),
    Key([mod, "mod1"], "w",
        lazy.spawn('alacritty -e nmtui'),
        desc='spawns nmtui (wifi)'
        ),

    # ScratchPads
    Key([mod], 'c', lazy.group['scratchpad'].dropdown_toggle('qalc')),
    Key([mod], 'v', lazy.group['scratchpad'].dropdown_toggle('volume')),
    Key([mod], 'b', lazy.group['scratchpad'].dropdown_toggle('bpms')),
    Key([mod], 't', lazy.group['scratchpad'].dropdown_toggle('terminal')),


  # Change the volume if your keyboard has special volume keys.
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("pamixer -i 5")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("pamixer -d 5")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("pamixer -t")
    ),
]
def inc(n, l=2): return (n+1) % l


class GetCol:
    def __init__(self, col: list, bg, font='#ffffff'):
        self.col = col
        self.n = len(self.col)
        self.last_ind = -1
        self.cur_ind = 0
        self.bg = bg
        self.font = font

    def next(self):
        self.last_ind = inc(self.last_ind, self.n)
        self.cur_ind = inc(self.cur_ind, self.n)
        return self.col[self.cur_ind]

    def cur(self):
        return self.col[self.cur_ind]

    def last(self):
        return self.col[self.last_ind]


group_names = [("WWW", {'layout': 'max'}),
               ("DEV", {'layout': 'columns'}),
               ("VID", {'layout': 'max'}),
               ("DOC", {'layout': 'columns'}),

               ("SYS", {'layout': 'columns'}),
               ("CHAT", {'layout': 'columns'}),
               ("MUS", {'layout': 'columns'}),
               ("GFX", {'layout': 'floating'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]
other_groups = [
    ScratchPad('scratchpad', [
        DropDown("qalc", "alacritty -e qalc", y=0.3, width=0.4, x=0.3, warp_pointer=False),
        DropDown("bpms", "alacritty -e .config/scripts/fzl.sh /mnt/winlinux/bpms", width=0.8, x=.1, y=0.2, height=0.5, warp_pointer=False),
        DropDown("terminal", "alacritty -e zsh", width=0.8, x=.1, y=0.2, height=0.5, warp_pointer=False),
        DropDown("volume", "alacritty -e pulsemixer", width=0.5, x=.25, y=0.2, height=0.5, warp_pointer=False),
    ])
]
groups.extend(other_groups)
for i, (name, kwargs) in enumerate(group_names, 1):
    # Switch to another group
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
    # Send current window to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

with open("/home/yogansh/.config/qtile/colors.json") as fp:
    col = json.load(fp)
    colors = col["colors"]
colors = [col["special"]["background"],  # panel background
          colors["color9"],  # background for current screen tab
          col["special"]["foreground"],  # font color for group names
          colors["color8"],  # border line color for current tab
          colors["color3"],  # border line color for other tab and odd widgets
          colors["color2"],  # color for the even widgets
          colors["color8"],  # window name
          colors["color10"],  # font color for odd widgets
          colors["color11"],  # font color for even widgets
          ]
getCol = GetCol([colors[4], colors[5]], colors[0], colors[2])
layout_theme = {"border_width": 2,
                "margin": 4,
                "border_focus": colors[2],
                "border_normal": colors[0],
                }
layouts = [
    # layout.MonadWide(**layout_theme),
    # layout.Bsp(**layout_theme),
    layout.Stack(stacks=2, **layout_theme),
    layout.Columns(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Matrix(**layout_theme),
    # layout.Zoomy(**layout_theme),
    # layout.Slice(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    # layout.Tile(shift_windows=True, **layout_theme),
    # layout.TreeTab(
        # font="Ubuntu",
        # fontsize=10,
        # sections=["FIRST", "SECOND"],
        # section_fontsize=11,
        # bg_color="141414",
        # active_bg="90C435",
        # active_fg="000000",
        # inactive_bg="384323",
        # inactive_fg="a0a0a0",
        # padding_y=5,
        # section_top=10,
        # panel_width=320
    # ),
    layout.Floating(**layout_theme)
]

for i, (name, kwargs) in enumerate(group_names, 1):
    # Switch to another group
    keys.append(Key([mod, "control"], str(i), lazy.group[name].toscreen()))
    # Send current window to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="JetBrains Mono ExtraBold",
    fontsize=16,
    padding=2,
    style="Bold",
    background=getCol.bg
)
extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.Sep(
            linewidth=0,
            padding=6,
            foreground=colors[2],
            background=colors[0]
        ),
        widget.Image(
            filename="~/.config/qtile/icons/python-white-transparent.png",
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(launcher)},
            background=getCol.bg,
        ),
        widget.GroupBox(
            font="Ubuntu Bold",
            fontsize=14,
            margin_y=5,
            margin_x=5,
            padding_y=5,
            padding_x=3,
            borderwidth=3,
            active=colors[2],
            inactive=colors[2],
            rounded=False,
            highlight_color=colors[1],
            highlight_method="line",
            this_current_screen_border=colors[3],
            this_screen_border=colors[4],
            other_current_screen_border=colors[0],
            other_screen_border=colors[0],
            foreground=colors[2],
            background=colors[0]
        ),
        widget.WindowName(
            foreground=colors[6],
            background=colors[0],
            padding=5
        ),
        widget.TextBox(
            text='',
            background=getCol.bg,
            foreground=getCol.cur(),
            padding=-1,
            margin=0,
            fontsize=48
        ),
        widget.CheckUpdates(
            update_interval=1800,
            distro="Arch_checkupdates",
            display_format=" ⟳{updates} Updates",
            foreground=getCol.font,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(
                myTerm + ' -e sudo pacman -Syu')},
            background=getCol.cur()
        ),
        widget.TextBox(
            text='',
            background=getCol.cur(),
            foreground=getCol.next(),
            padding=-1,
            margin=0,
            fontsize=48
        ),

        widget.Memory(
            foreground=getCol.font,
            background=getCol.cur(),
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
            format='{MemUsed}M',
            fmt='🖬 {}',
            padding=5
        ),
        widget.TextBox(
            text='',
            background=getCol.cur(),
            foreground=getCol.next(),
            padding=-1,
            margin=0,
            fontsize=48
        ),
        # widget.TextBox(
        # text='',
        # foreground = getCol.font,
        # background= getCol.cur(),
        # fontsize='20'
        # ),
        widget.Backlight(
            foreground=getCol.font,
            backlight_name="intel_backlight",
            change_command='xbacklight -set {0}',
            fmt=':{}',
            background=getCol.cur(),
            padding=5,
        ),
        widget.TextBox(
            text='',
            background=getCol.cur(),
            foreground=getCol.next(),
            padding=-1,
            margin=0,
            fontsize=48
        ),
        widget.TextBox(
            text=" Vol:",
            foreground=getCol.font,
            background=getCol.cur(),
            padding=0
        ),
        widget.Volume(
            foreground=getCol.font,
            background=getCol.cur(),
            padding=5,
        ),
        # widget.TextBox(
        # text = '',
        # background = getCol.cur(),
        # foreground = getCol.next(),
        # padding = -1,
        # margin=0,
        # fontsize = 48
        # ),
        # widget.TextBox(
        # text = ':',
        # background = getCol.cur(),
        # foreground = getCol.font,

        # ),
        # widget.Battery(
        # format = "{char} {percent:2.0%} {hour:d}:{min:02d} ",
        # background = getCol.cur(),
        # foreground = getCol.font,
        # padding = 5,
        # unknown_char = "",
        # ),
        widget.TextBox(
            text='',
            background=getCol.cur(),
            foreground=getCol.next(),
            padding=-1,
            margin=0,
            fontsize=48
        ),
        widget.TextBox(
            text=" WLan:",
            foreground=getCol.font,
            background=getCol.cur(),
            padding=5
        ),
        widget.Wlan(
            foreground=getCol.font,
            background=getCol.cur(),
            padding=5,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("nm-connection-editor")},
            interface="wlo1"
        ),
        widget.TextBox(
            text='',
            background=getCol.cur(),
            foreground=getCol.next(),
            padding=-1,
            margin=0,
            fontsize=48
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            background=getCol.cur(),
            padding=5,
            scale=0.7
        ),
        widget.CurrentLayout(
            foreground=getCol.font,
            background=getCol.cur(),
            padding=5
        ),
        widget.TextBox(
            text='',
            background=getCol.cur(),
            foreground=getCol.next(),
            padding=-1,
            margin=0,
            fontsize=48
        ),
        widget.WidgetBox(widgets=[
            widget.Pomodoro(
                background=getCol.cur(),
                color_inactive=getCol.font,
                length_pomodori=30,
            ),
        ],
            foreground=colors[2],
            background=getCol.cur(),
        ),
        widget.Clock(
            foreground=getCol.font,
            background=getCol.cur(),
            format="%a, %b %d  [ %I:%M %p ]"
        ),

        # widget.TextBox(
        # text = '',
        # background = colors[5],
        # foreground = colors[4],
        # padding = -1,
        # margin=0,
        # fontsize = 48
        # ),
        # Notify(
        # # audiofile= audiofile,
        # default_timeout = 20,
        # foreground = colors[2],
        # background = colors[4],
        # padding = 5,
        # format = "%A, %B %d  [ %H:%M ]"
        # ),
        widget.Sep(
            linewidth=0,
            padding=10,
            foreground=getCol.bg,
            background=getCol.cur()
        ),
        widget.TextBox(
            text='',
            background=getCol.cur(),
            foreground=getCol.bg,
            padding=-1,
            margin=0,
            fontsize=48
        ),
        widget.Systray(
            background=getCol.bg,
            padding=5
        ),
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    # Slicing removes unwanted widgets on Monitors 1,3
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    # Monitor 2 will display all widgets in widgets_list
    return widgets_screen2


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=28)), ]


if __name__ in ["config", "__main__"]:

    screens = init_screens()
    widgets_list = init_widgets_list()
    # widgets_screen1 = init_widgets_screen1()
    # widgets_screen2 = init_widgets_screen2()


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
bring_front_click = False
cursor_warp = False

# floating_layout = layout.Floating(float_rules=[
# # {'wmclass': 'confirm'},
# # {'wmclass': 'dialog'},
# # {'wmclass': 'download'},
# # {'wmclass': 'error'},
# # {'wmclass': 'file_progress'},
# # {'wmclass': 'notification'},
# # {'wmclass': 'splash'},
# # {'wmclass': 'toolbar'},
# # {'wmclass': 'confirmreset'},  # gitk
# # {'wmclass': 'makebranch'},  # gitk
# # {'wmclass': 'maketag'},  # gitk
# # {'wname': 'branchdialog'},  # gitk
# # {'wname': 'pinentry'},  # GPG key password entry
# # {'wmclass': 'ssh-askpass'},  # ssh-askpass
# # {'wname':'Float'},#asd        Match(wm_type='utility'),
# Match(wm_type='notification'),
# Match(wm_type='toolbar'),
# Match(wm_type='splash'),
# Match(wm_type='dialog'),
# Match(wm_class='file_progress'),
# Match(func=lambda c: c.has_fixed_size())
# ])

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),  # tastyworks exit box
    Match(title='Calculator'),  # qalculate-gtk
    Match(wm_class='kdenlive'),  # kdenlive
    Match(wm_class='pinentry-gtk-2'),  # GPG key password entry
],**layout_theme)
auto_fullscreen = True
focus_on_window_activation = "smart"


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])
    id = os.environ.get('DESKTOP_AUTOSTART_ID')
    if not id:
        return

    # subprocess.Popen(['dbus-send',
        # '--session',
        # '--print-reply',
        # '--dest=org.gnome.SessionManager',
        # '/org/gnome/SessionManager',
        # 'org.gnome.SessionManager.RegisterClient',
        # 'string:qtile',
        # 'string:' + id])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
