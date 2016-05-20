# colorscheme by: spcmd (github.com/spcmd)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

# Colors vars (color codes need to be set in ~/.Xresources)
COLOR_RED = 1
COLOR_GREEN = 2
COLOR_BLUE = 4
COLOR_BLUE_BRIGHT = 12
COLOR_MAGENTA = 5
COLOR_CYAN = 6
COLOR_WHITE = 7
COLOR_BLACK = 8
COLOR_YELLOW = 11

class Default(ColorScheme):
    progress_bar_color = COLOR_CYAN

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            bg = COLOR_BLACK
            fg = COLOR_WHITE
            if context.selected:
                attr = reverse
            else:
                bg = COLOR_BLACK
                fg = COLOR_WHITE
                attr = normal
            if context.empty or context.error:
                bg = red
                fg = white
            if context.border:
                fg = COLOR_BLUE
            if context.media:
                if context.image:
                    fg = COLOR_MAGENTA
                else:
                    fg = COLOR_MAGENTA
            if context.container:
                fg = COLOR_RED
                #attr |= bold
            if context.directory:
                attr |= bold
                bg = COLOR_BLACK
                fg = COLOR_BLUE
            elif context.executable and not \
                    any((context.media, context.container,
                        context.fifo, context.socket)):
                #attr |= bold
                fg = COLOR_GREEN
            if context.socket:
                fg = magenta
                attr |= bold
            if context.fifo or context.device:
                fg = magenta
                if context.device:
                    attr |= bold
            if context.link:
                fg = context.good and COLOR_CYAN
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (red, magenta):
                    fg = white
                else:
                    fg = red
            #if not context.selected and (context.cut or context.copied):
                #fg = black
                #attr |= bold
            if context.main_column:
                bg = COLOR_BLACK
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = COLOR_YELLOW
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

        elif context.in_titlebar:
            bg = COLOR_BLACK
            fg = COLOR_WHITE
            attr |= bold
            if context.hostname:
                #fg = context.bad and red or green
                fg = COLOR_WHITE
            elif context.directory:
                fg = COLOR_WHITE
            elif context.tab:
                if context.good:
                    fg = COLOR_BLACK
                    bg = COLOR_YELLOW
            elif context.link:
                fg = COLOR_CYAN

        elif context.in_statusbar:
            bg = COLOR_BLACK
            fg = COLOR_WHITE
            if context.permissions:
                if context.good:
                    fg = COLOR_WHITE
                elif context.bad:
                    fg = COLOR_RED
            if context.marked:
                attr |= bold | reverse
                fg = COLOR_WHITE
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = COLOR_MAGENTA
                #attr &= ~bold
            if context.vcscommit:
                fg = COLOR_MAGENTA
                #attr &= ~bold


        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = COLOR_BLUE_BRIGHT

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color


        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = magenta
            elif context.vcschanged:
                fg = red
                attr |= bold
            elif context.vcsunknown:
                fg = red
                attr |= bold
            elif context.vcsstaged:
                fg = COLOR_GREEN
                attr |= bold
            elif context.vcssync:
                fg = COLOR_GREEN
                attr |= bold
            elif context.vcsignored:
                fg = default
                attr |= bold

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync:
                fg = green
            elif context.vcsbehind:
                fg = red
            elif context.vcsahead:
                fg = COLOR_BLUE_BRIGHT
            elif context.vcsdiverged:
                fg = magenta
            elif context.vcsunknown:
                fg = red

        return fg, bg, attr
