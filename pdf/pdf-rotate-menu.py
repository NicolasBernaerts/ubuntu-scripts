#!/usr/bin/env python3
# ---------------------------------------------------
#
# Nautilus extension to add rotation to PDF documents 
# Menus are displayed according to available tools
#
# Tools handled are :
#   * pdf-rotate
#
# Revision history :
#   01/05/2020, V1.0 - Creation by N. Bernaerts
#   30/04/2025, v1.1 - Update get_file_items
#
# ---------------------------------------------------

import subprocess
import pathlib
from gi.repository import Nautilus, GObject

class PDFRotateMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def pdf_rotate_right(self, menu, listUri):
    subprocess.Popen("pdf-rotate --right " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  def pdf_rotate_left(self, menu, listUri):
    subprocess.Popen("pdf-rotate --left " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  def pdf_rotate_updown(self, menu, listUri):
    subprocess.Popen("pdf-rotate --updown " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, files):
  
    # variables
    strFiles = ""
    onlyPDF = True;
    
    # check if array is only composed of PDF files
    for file in files:
      strFiles += file.get_uri() + " "
      if file.get_mime_type() not in ('application/pdf' 'application/x-pdf' 'application/x-bzpdf' 'application/x-gzpdf'): onlyPDF = False;
      
    # create sub-menu item PDF Rotate
    file = pathlib.Path("/usr/local/bin/pdf-rotate")
    if onlyPDF == True and file.exists ():
      # create menu item for right click menu
      pdf_rotate = Nautilus.MenuItem(name='PDFRotateMenuProvider::pdf_rotate', label='PDF - Rotate ...', icon='/usr/share/icons/pdf-menu.png')
      submenu = Nautilus.Menu()
      pdf_rotate.set_submenu(submenu)
      
      # rotate right
      pdf_rotate_right = Nautilus.MenuItem(name='PDFRotateMenuProvider::pdf_rotate_right', label='Rotate Right (+90°)', icon='rotate-right')
      pdf_rotate_right.connect('activate', self.pdf_rotate_right, strFiles)
      submenu.append_item(pdf_rotate_right)

      # rotate left
      pdf_rotate_left = Nautilus.MenuItem(name='PDFRotateMenuProvider::pdf_rotate_left', label='Rotate Left (-90°)', icon='rotate-left')
      pdf_rotate_left.connect('activate', self.pdf_rotate_left, strFiles)
      submenu.append_item(pdf_rotate_left)

      # rotate 180
      pdf_rotate_updown = Nautilus.MenuItem(name='PDFRotateMenuProvider::pdf_rotate_updown', label='Rotate Upside Down (+180°)', icon='rotate-updown')
      pdf_rotate_updown.connect('activate', self.pdf_rotate_updown, strFiles)
      submenu.append_item(pdf_rotate_updown)

      return [pdf_rotate]

    # else, nothing to do
    else: return
