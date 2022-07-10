CODE = """widgets = [
    [
    widget.Battery(
          format = "{char} {percent:2.0%} {hour:d}:{min:02d} ",
              background = colors[4],
              foreground = colors[2],
              padding = 0,
              
              ),

    widget.TextBox(
              text = '',
              background = colors[4],
              foreground = colors[5],
              padding = 0,
              fontsize = 37
              ),
    ],
  [
    widget.TextBox(
          text = " WLan:",
            foreground = colors[2],
            background = colors[5],
            padding = 0
            ),
    widget.Wlan(
              foreground = colors[2],
              background = colors[5],
              padding = 5,
              interface = "wlo1"
              ),],
[widget.TextBox(
          text = '',
          background = colors[5],
          foreground = colors[4],
          padding = 0,
          fontsize = 37
          ),
widget.CurrentLayoutIcon(
          custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
          foreground = colors[0],
          background = colors[4],
          padding = 0,
          scale = 0.7
          ),],
[widget.CurrentLayout(
          foreground = colors[2],
          background = colors[4],
          padding = 5
          ),
widget.TextBox(
          text = '',
          background = colors[4],
          foreground = colors[5],
          padding = 0,
          fontsize = 37
          ),
widget.Clock(
          foreground = colors[2],
          background = colors[5],
          format = "%A, %B %d  [ %H:%M ]"
          ),],]
          """

code = """
widgets_list = [

[            widget.TextBox(
                      text = " ⟳",
                      padding = 2,
                      foreground = colors[2],
                      background = colors[4],
                      fontsize = 14
                      ),
            widget.CheckUpdates(
                      update_interval = 1800,
                      foreground = colors[2],
                      mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e \"sudo pacman -Syu\"')},
                      background = colors[4]
                      ),
            widget.TextBox(
                      text = "Updates",
                      padding = 5,
                      mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e \"sudo pacman -Syu')},
                      foreground = colors[2],
                      background = colors[4]
                      ),],

[            widget.TextBox(
                      text = " 🖬",
                      foreground = colors[2],
                      background = colors[5],
                      padding = 0,
                      fontsize = 14
                      ),
            widget.Memory(
                      foreground = colors[2],
                      background = colors[5],
                      mouse_callbacks = {'Button1': lambda qtile: qtile.cmd_spawn(myTerm + ' -e htop')},
                      padding = 5
                      ),
],

[          widget.TextBox(
                      foreground = colors[2],
                      text = 'Brightness:',
                      mouse_callbacks = {"Button4":lambda q: subprocess.call("",shell=True)},
                      background = colors[4],
                      padding = 5
                      ),
          widget.Backlight(
                      foreground = colors[2],
                      backlight_name="intel_backlight",
                      background = colors[4],
                      padding = 5,)
],

[            widget.TextBox(
                    text = " Vol:",
                      foreground = colors[2],
                      background = colors[5],
                      padding = 0
                      ),
            widget.Volume(
                      foreground = colors[2],
                      background = colors[5],
                      padding = 5,
                      volume_app = "pavucontrol"
                      ),],

[          widget.TextBox(
                      text = 'Battery:',
                      background = colors[4],
                      foreground = colors[2],
                      padding = 0,
                      
                      ),
          widget.Battery(
                  format = "{char} {percent:2.0%} {hour:d}:{min:02d} ",
                      background = colors[4],
                      foreground = colors[2],
                      padding = 0,
                      
                      ),],

[          widget.TextBox(
                    text = " WLan:",
                      foreground = colors[2],
                      background = colors[5],
                      padding = 0
                      ),
            widget.Wlan(
                      foreground = colors[2],
                      background = colors[5],
                      padding = 5,
                      interface = "wlo1"
                      ),],

[            widget.CurrentLayoutIcon(
                      custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                      foreground = colors[0],
                      background = colors[4],
                      padding = 0,
                      scale = 0.7
                      ),
            widget.CurrentLayout(
                      foreground = colors[2],
                      background = colors[4],
                      padding = 5
                      ),],

[            widget.Clock(
                      foreground = colors[2],
                      background = colors[5],
                      format = "%A, %B %d  [ %H:%M ]"
                      ),]

]
"""