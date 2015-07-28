# Simple titlebar plugin for ranger with trash indicator on the left side
# Trash indicator appears only if trash contains at least one file
# Indicator is a unicode symbol, it may not appear on some systems (plugin is tested on Arch Linux)

from ranger.gui.widgets.titlebar import TitleBar
import os

def _get_left_part(self, bar):

    username = os.environ["USER"]
    trashdir = "/home/"+username+"/.local/share/Trash/files"

    #if self.fm.username == 'root':
        #clr = 'bad'
    #else:
        #clr = 'good'

    if len(os.listdir(trashdir)) == 0:
        bar.add(' Trash: [           ] ', fixed=True)
    elif len(os.listdir(trashdir)) >= 1:
        bar.add(' Trash: [#┄┄┄┄┄┄┄┄┄┄] ', fixed=True)
    elif len(os.listdir(trashdir)) >= 10:
        bar.add(' Trash: [##┄┄┄┄┄┄┄┄┄] ', fixed=True)
    elif len(os.listdir(trashdir)) >= 20:
        bar.add(' Trash: [###┄┄┄┄┄┄┄┄] ', fixed=True)
    elif len(os.listdir(trashdir)) >= 50:
        bar.add(' Trash: [######┄┄┄┄┄] ', fixed=True)
    elif len(os.listdir(trashdir)) >= 80:
        bar.add(' Trash: [#########┄┄] ', fixed=True)
    elif len(os.listdir(trashdir)) >= 100:
        bar.add(' Trash: [###########] ', fixed=True)

    # Username and hostname commented out for simplicity, however it still usable
    #bar.add(self.fm.username, 'hostname', clr, fixed=True)
    #bar.add('@', 'hostname', clr, fixed=True)
    #bar.add(self.fm.hostname, 'hostname', clr, fixed=True)
    #bar.add(':', 'hostname', clr, fixed=True)

    pathway = self.fm.thistab.pathway
    if self.settings.tilde_in_titlebar and \
            self.fm.thisdir.path.startswith(self.fm.home_path):
        pathway = pathway[self.fm.home_path.count('/')+1:]
        bar.add('~/', 'directory', fixed=True)

    for path in pathway:
        if path.is_link:
            clr = 'link'
        else:
            clr = 'directory'

        bar.add(path.basename, clr, directory=path)
        bar.add('/', clr, fixed=True, directory=path)

    if self.fm.thisfile is not None and \
            self.settings.show_selection_in_titlebar:
        bar.add(self.fm.thisfile.relative_path, 'file')

TitleBar._get_left_part = _get_left_part
