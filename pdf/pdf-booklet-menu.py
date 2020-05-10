#!/usr/bin/env python3
# ---------------------------------------------------------
# Nautilus extension to add PDF booklet generation menu 
# Menus is displayed according to pdf-booklet availability
#
# Revision history :
#   02/05/2020, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------------

import subprocess
import pathlib
from gi.repository import Nautilus, GObject

class PDFBookletMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def pdf_booklet(self, menu, file): subprocess.Popen("pdf-booklet --file '" + file + "'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, window, files):
    # if multiple selection, nothing to do
    if len(files) != 1: return

    # check availability of booklet generation tool
    file = pathlib.Path("/usr/local/bin/pdf-booklet")
    if not file.exists (): return

    # check if file is in the supported file types
    if files[0].get_mime_type() in ('application/pdf' 'application/x-pdf' 'application/x-bzpdf' 'application/x-gzpdf' 'application/msword' 'application/vnd.ms-word' 'application/vnd.ms-powerpoint' 'application/vnd.oasis.opendocument.text' 'application/vnd.oasis.opendocument.presentation' 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' 'application/vnd.openxmlformats-officedocument.presentationml.presentation' 'application/vnd.openxmlformats-officedocument.presentationml.template' 'application/vnd.openxmlformats-officedocument.presentationml.slideshow' 'text/plain'):
      
      # get filename
      filename = files[0].get_uri()
      
      # create menu item for right click menu
      pdf_menu = Nautilus.MenuItem(name='PDFBookletMenuProvider::pdf_booklet', label='PDF - Generate booklet', icon='pdf-booklet')
      pdf_menu.connect('activate', self.pdf_booklet, filename)

      return [pdf_menu]

    # else, nothing to do
    else: return
