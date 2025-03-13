"""
Adapted from https://github.com/pwndbg/pwndbg/blob/dev/FEATURES.md#splitting--layouting-context
Adapted from https://blog.jcfg.re/posts/pwndbg-tmux/
"""

import os
import atexit

import pwndbg
from pwndbg.commands.context import contextoutput


panes = {
    # Split vertical next to the disassemble for the registers
    # For ipython: ' tmux split-window -v -d -P -F "#{pane_id}:#{pane_tty}" -t -1 -l 15% "ipython --no-banner"'
    "regs": os.popen(
        'tmux split-window -h -d -P -F "#{pane_id}:#{pane_tty}" -t -1 -l 35% "cat -"'
    )
    .read()
    .strip()
    .split(":"),
    "backtrace": os.popen(
        ' tmux split-window -v -d -P -F "#{pane_id}:#{pane_tty}" -t -1 -l 20% "cat -"'
    )
    .read()
    .strip()
    .split(":"),
}

# Tell pwndbg which panes are to be used for what
for section, p in panes.items():
    contextoutput(section, p[1], True, "top", False)

# Also add the sections legend and expressions to already existing panes
contextoutput("legend", panes["regs"][1], True)
contextoutput("expressions", panes["regs"][1], True, "top", False)

# To see more options to customize run `theme` and `config` in gdb
pwndbg.config.context_stack_lines.value = 10
# Give backtrace a little more color
pwndbg.config.backtrace_prefix_color.value = "red,bold"
pwndbg.config.backtrace_frame_label_color.value = "green"
pwndbg.config.backtrace_address_color.value = "blue"
pwndbg.config.backtrace_symbol_color.value = "yellow"

# Remove the panes when gdb exits
atexit.register(
    lambda: [os.popen(f"tmux kill-pane -t {p[0]}").read() for p in panes.values()]
)
