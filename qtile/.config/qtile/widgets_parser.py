
import json
import os 
import sys
import re
import socket
import subprocess
from libqtile.config import KeyChord, Key, Screen, Group, Drag, Click
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401
import libqtile.widget.volume
from libqtile.log_utils import logger as l
colors = []
LOC = "/home/yogansh/.config/qtile/conf.txt"
def load_widgets(*args,**kwargs):
    with open(LOC, "r") as fp:
        a = fp.read()
    
    
    return ltos(eval(a),*args, **kwargs)


def ltos(widgets: list,colors :list,panelCol = ["#292d3e", "#292d3e"] ,prepend = None, append = None):
    no = len(colors)
    toret = []
    #hoe
    prev = panelCol
    
    for i, item  in enumerate(widgets):
        
        col = colors[i%no]
        toret.append(widget.TextBox(text='',
                       background = prev,
                       foreground = col,
                       padding = 0,
                       fontsize = 37))
        for it in item:
            print(it)
            it: dict
            name = list(it.keys())[0]
            kwargs = list(it.values())[0]
            kwargs["background"] = col
            if not kwargs.get("foreground"):
                kwargs["foreground"] = ["#ffffff", "#ffffff"]
            toret.append(getattr(widget, name)(**kwargs))
        prev = col
    
    return toret

