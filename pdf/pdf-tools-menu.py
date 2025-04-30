#!/usr/bin/env python3
# ---------------------------------------------------
#
# Nautilus extension to add misc PDF tools menus 
# Menus are displayed according to available tools
#
# Tools handled are :
#   * pdf-repair
#   * pdf-compress
#
# Revision history :
#   01/05/2020, V1.0 - Creation by N. Bernaerts
#   30/04/2025, v1.1 - Update get_file_items
#
# ---------------------------------------------------

import subprocess
import pathlib
from gi.repository import Nautilus, GObject

class PDFToolsMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def pdf_compress(self, menu, listUri):
    subprocess.Popen("pdf-compress " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def pdf_repair_ghost(self, menu, listUri):
    subprocess.Popen("pdf-repair --method ghostscript " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    
  def pdf_repair_mutool(self, menu, listUri):
    subprocess.Popen("pdf-repair --method mutool " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, files):
    # variables
    strFiles = ""
    onlyPDF = True;
    
    # check if array is only composed of PDF files
    for file in files:
      strFiles += file.get_uri() + " "
      if file.get_mime_type() not in ('application/pdf' 'application/x-pdf' 'application/x-bzpdf' 'application/x-gzpdf'): onlyPDF = False;

    # if all files are images
    if onlyPDF == True:
      # create menu item for right click menu
      pdf_tools = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_tools', label='PDF - Misc tools ...', icon='pdf-menu')
      submenu = Nautilus.Menu()
      pdf_tools.set_submenu(submenu)
      
      # create sub-menu item PDF Compress
      file = pathlib.Path("/usr/local/bin/pdf-compress")
      if file.exists ():
        pdf_compress = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_compress', label='Compress scanned document', icon='pdf-compress')
        pdf_compress.connect('activate', self.pdf_compress, strFiles)
        submenu.append_item(pdf_compress)

      # create sub-menu item PDF Repair
      file = pathlib.Path("/usr/local/bin/pdf-repair")
      if file.exists ():
        # ghostscript method
        pdf_repair_ghost = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_repair_ghost', label='Repair (Ghostscript)', icon='pdf-repair')
        pdf_repair_ghost.connect('activate', self.pdf_repair_ghost, strFiles)
        submenu.append_item(pdf_repair_ghost)

        # mutool method
        pdf_repair_mutool = Nautilus.MenuItem(name='PDFToolsMenuProvider::pdf_repair_mutool', label='Repair (MU Tool)', icon='pdf-repair')
        pdf_repair_mutool.connect('activate', self.pdf_repair_mutool, strFiles)
        submenu.append_item(pdf_repair_mutool)

      # return created menus
      return [pdf_tools]

    else: return
