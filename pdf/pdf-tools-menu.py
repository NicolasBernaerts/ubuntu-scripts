# ---------------------------------------------------
# Nautilus extension to add misc PDF tools menus 
# Menus are displayed according to available tools
# Tools handled are :
#   * pdf-repair
#   * pdf-compress

# Revision history :
#   01/05/2020, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------

import subprocess
import pathlib
from gi.repository import Nautilus, GObject

class PDFToolsMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def pdf_compress(self, menu, file): subprocess.Popen("pdf-compress --file '" + file + "'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  def pdf_repair_ghostscript(self, menu, file): subprocess.Popen("pdf-repair --method ghostscript --file '" + file + "'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  def pdf_repair_mutool(self, menu, file): subprocess.Popen("pdf-repair --method mutool --file '" + file + "'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  def pdf_rotate_right(self, menu, file): subprocess.Popen("pdf-rotate --right --file '" + file + "'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  def pdf_rotate_left(self, menu, file): subprocess.Popen("pdf-rotate --left --file '" + file + "'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  def pdf_rotate_updown(self, menu, file): subprocess.Popen("pdf-rotate --updown --file '" + file + "'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, window, files):
    # if multiple selection, nothing to do
    if len(files) != 1: return

    # if file is a PDF document,
    if files[0].get_mime_type() in ('application/pdf' 'application/x-pdf' 'application/x-bzpdf' 'application/x-gzpdf'):
      # get filename
      filename = files[0].get_uri()
      
      # create menu item for right click menu
      pdf_tools = Nautilus.MenuItem(name='SimpleMenuExtension::pdf_tool', label='PDF Tools', icon='/usr/share/icons/pdf-menu.png')
      submenu = Nautilus.Menu()
      pdf_tools.set_submenu(submenu)
      
      # create sub-menu item PDF Compress
      file = pathlib.Path("/usr/local/bin/pdf-compress")
      if file.exists ():
        pdf_compress = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_compress', label='Compress scanned document', icon='/usr/share/icons/pdf-compress.png')
        pdf_compress.connect('activate', self.pdf_compress, filename)
        submenu.append_item(pdf_compress)

      # create sub-menu item PDF Repair
      file = pathlib.Path("/usr/local/bin/pdf-repair")
      if file.exists ():
        # ghostscript method
        pdf_repair_ghostscript = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_repair_ghostscript', label='Repair (Ghostscript)', icon='/usr/share/icons/pdf-repair.png')
        pdf_repair_ghostscript.connect('activate', self.pdf_repair_ghostscript, filename)
        submenu.append_item(pdf_repair_ghostscript)

        # mutool method
        pdf_repair_mutool = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_repair_mutool', label='Repair (MU Tool)', icon='/usr/share/icons/pdf-repair.png')
        pdf_repair_mutool.connect('activate', self.pdf_repair_mutool, filename)
        submenu.append_item(pdf_repair_mutool)

      # create sub-menu item PDF Rotate
      file = pathlib.Path("/usr/local/bin/pdf-rotate")
      if file.exists ():
        # rotate right
        pdf_rotate_right = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_rotate_right', label='Rotate Right (+90°)', icon='/usr/share/icons/rotate-right.png')
        pdf_rotate_right.connect('activate', self.pdf_rotate_right, filename)
        submenu.append_item(pdf_rotate_right)

        # rotate left
        pdf_rotate_left = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_rotate_left', label='Rotate Left (-90°)', icon='/usr/share/icons/rotate-left.png')
        pdf_rotate_left.connect('activate', self.pdf_rotate_left, filename)
        submenu.append_item(pdf_rotate_left)

        # rotate 180
        pdf_rotate_updown = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_rotate_updown', label='Rotate Upside Down (+180°)', icon='/usr/share/icons/rotate-updown.png')
        pdf_rotate_updown.connect('activate', self.pdf_rotate_updown, filename)
        submenu.append_item(pdf_rotate_updown)

      return [pdf_tools]

    # else, nothing to do
    else: return
