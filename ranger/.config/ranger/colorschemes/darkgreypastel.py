# DarkGrayPastel colorscheme by: spcmd (github.com/spcmd)

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

# colors need to be set in the terminal config!
# color vars
COLOR_BG_DEFAULT = 18
COLOR_FG_DEFAULT = white
COLOR_ARCHIVE = 19
COLOR_BORDER = 20
COLOR_MEDIA = 21
COLOR_DIR = 22
COLOR_MARK = 24
COLOR_LINK = 25
COLOR_EXEC_VCS = 26

class Default(ColorScheme):
    progress_bar_color = COLOR_LINK

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors
                
        elif context.in_browser:
            bg = COLOR_BG_DEFAULT
            fg = COLOR_FG_DEFAULT
            if context.selected:
                attr = reverse
            else:
                bg = COLOR_BG_DEFAULT
                fg = COLOR_FG_DEFAULT
                attr = normal
            if context.empty or context.error:
                bg = red
                fg = white
            if context.border:
                fg = COLOR_BORDER
            if context.media:
                if context.image:
                    fg = COLOR_MEDIA
                else:
                    fg = COLOR_MEDIA
            if context.container:
                fg = COLOR_ARCHIVE
                attr |= bold
            if context.directory:
                attr |= bold
                bg = COLOR_BG_DEFAULT
                fg = COLOR_DIR
            elif context.executable and not \
                    any((context.media, context.container,
                        context.fifo, context.socket)):
                #attr |= bold
                fg = COLOR_EXEC_VCS
            if context.socket:
                fg = magenta
                attr |= bold
            if context.fifo or context.device:
                fg = 18
                if context.device:
                    attr |= bold
            if context.link:
                fg = context.good and COLOR_LINK
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
                bg = COLOR_BG_DEFAULT
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = COLOR_MARK
            if context.badinfo:
                if attr & reverse:
                    bg = magenta
                else:
                    fg = magenta

        elif context.in_titlebar:
            bg = COLOR_BG_DEFAULT
            fg = COLOR_FG_DEFAULT
            attr |= bold
            if context.hostname:
                #fg = context.bad and red or green
                fg = COLOR_FG_DEFAULT
            elif context.directory:
                fg = COLOR_FG_DEFAULT
            elif context.tab:
                if context.good:
                    bg = green
            elif context.link:
                fg = COLOR_LINK

        elif context.in_statusbar:
            bg = COLOR_BG_DEFAULT
            fg = COLOR_FG_DEFAULT
            if context.permissions:
                if context.good:
                    fg = COLOR_MEDIA
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
                fg = COLOR_MEDIA
                #attr &= ~bold
            if context.vcscommit:
                fg = COLOR_MEDIA
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
                fg = COLOR_EXEC_VCS
                attr |= bold
            elif context.vcssync:
                fg = COLOR_EXEC_VCS
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
