# DarkGrayPastel colorscheme by: spcmd (github.com/spcmd)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

# colors need to be set in the terminal config!
# color vars
RANGER_BG = 18
RANGER_FG = white

class Default(ColorScheme):
    progress_bar_color = 25

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors
                
        elif context.in_browser:
            bg = RANGER_BG
            fg = RANGER_FG
            if context.selected:
                attr = reverse
            else:
                bg = RANGER_BG
                fg = RANGER_FG
                attr = normal
            if context.empty or context.error:
                bg = red
                fg = white
            if context.border:
                fg = 20
            if context.media:
                if context.image:
                    fg = 21
                else:
                    fg = 21
            if context.container:
                fg = 19
                attr |= bold
            if context.directory:
                attr |= bold
                bg = RANGER_BG
                fg = 22
            elif context.executable and not \
                    any((context.media, context.container,
                        context.fifo, context.socket)):
                #attr |= bold
                fg = 26
            if context.socket:
                fg = magenta
                attr |= bold
            if context.fifo or context.device:
                fg = 18
                if context.device:
                    attr |= bold
            if context.link:
                fg = context.good and 25
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
                bg = RANGER_BG
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = 24
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

        elif context.in_titlebar:
            bg = RANGER_BG
            fg = RANGER_FG
            attr |= bold
            if context.hostname:
                #fg = context.bad and red or green
                fg = RANGER_FG
            elif context.directory:
                fg = RANGER_FG
            elif context.tab:
                if context.good:
                    bg = green
            elif context.link:
                fg = 25

        elif context.in_statusbar:
            bg = RANGER_BG
            fg = RANGER_FG
            if context.permissions:
                if context.good:
                    fg = 21
                elif context.bad:
                    fg = magenta
            if context.marked:
                attr |= bold | reverse
                fg = 18
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = 21
                #attr &= ~bold
            if context.vcscommit:
                fg = 21
                #attr &= ~bold


        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = blue

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
                fg = 26
                attr |= bold
            elif context.vcssync:
                fg = 26
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
                fg = blue
            elif context.vcsdiverged:
                fg = magenta
            elif context.vcsunknown:
                fg = red

        return fg, bg, attr
