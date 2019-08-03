# ---------------------------------------------------
# Nautilus extension to add a repair menu to PDF files 
# Uses pdf-repair script
#
# Revision history :
#   08/11/2014, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------
import subprocess
from gi.repository import Nautilus, GObject

class PDFCorrectionMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def activate(self, menu, files):
    # get document URI
    filename = files[0].get_uri()

    # run correction command
    command_line = "pdf-repair " + filename
    p = subprocess.Popen(command_line , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, window, files):
    # if multiple selection, nothing to do
    if len(files) != 1: return

    # if file is a PDF document, repair it
    if files[0].get_mime_type() in ('application/pdf'):
      # create menu item for right click menu
      item = Nautilus.MenuItem(name='SimpleMenuExtension::pdf_repair', label='Repair PDF using Ghostscript')
      item.connect('activate', self.activate, files)
      return [item]

    # else, nothing to do
    else: return
