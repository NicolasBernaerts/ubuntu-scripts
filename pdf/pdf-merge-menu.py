#!/usr/bin/env python3
# ---------------------------------------------------
#
# Nautilus extension to merge multiple
#  office documents to a PDF document
#
# Tools handled are :
#   * pdf-merge
#
# Revision history :
#   07/05/2020, v1.0 - Creation by N. Bernaerts
#   30/04/2025, v1.1 - Update get_file_items
#
# ---------------------------------------------------

import subprocess
import pathlib
from gi.repository import Nautilus, GObject

class PDFMergeMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def pdf_merge_default(self, menu, listUri):
    subprocess.Popen("pdf-merge --alpha --default " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def pdf_merge_screen(self, menu, listUri):
    subprocess.Popen("pdf-merge --alpha --screen " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def pdf_merge_ebook(self, menu, listUri):
    subprocess.Popen("pdf-merge --alpha --ebook " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def pdf_merge_printer(self, menu, listUri):
    subprocess.Popen("pdf-merge --alpha --printer " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def pdf_merge_prepress(self, menu, listUri):
    subprocess.Popen("pdf-merge --alpha --prepress " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, files):
    # variables
    strFiles = ""
    compatFiles = True;
    
    # check if array is only composed of compatible files
    for file in files:
      strFiles += file.get_uri() + " "
      if file.get_mime_type() not in ('image/png', 'image/jpeg', 'image/bmp', 'image/gif', 'image/tiff', 'image/webp', 'application/pdf', 'application/x-pdf', 'application/x-bzpdf', 'application/x-gzpdf', 'application/msword', 'application/vnd.ms-word', 'application/vnd.oasis.opendocument.text', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/vnd.openxmlformats-officedocument.spreadsheetml.template', 'application/vnd.ms-powerpoint', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 'application/vnd.openxmlformats-officedocument.presentationml.template', 'application/vnd.openxmlformats-officedocument.presentationml.slideshow', 'text/plain'): compatFiles = False;

    # create sub-menu item PDF Merge
    file = pathlib.Path("/usr/local/bin/pdf-merge")
    if compatFiles == True and file.exists ():

      # create menu item for right click menu
      pdf_merge = Nautilus.MenuItem(name='PDFMergeMenuProvider::pdf_merge', label='PDF - Merge documents ...', icon='pdf-merge')
      submenu = Nautilus.Menu()
      pdf_merge.set_submenu(submenu)
      
      # default
      pdf_merge_default = Nautilus.MenuItem(name='PDFMergeMenuProvider::pdf_merge_default', label='Default settings, best quality', icon='pdf-merge')
      pdf_merge_default.connect('activate', self.pdf_merge_default, strFiles)
      submenu.append_item(pdf_merge_default)

      # screen
      pdf_merge_screen = Nautilus.MenuItem(name='PDFMergeMenuProvider::pdf_merge_screen', label='Screen quality, 72 dpi images', icon='pdf-merge')
      pdf_merge_screen.connect('activate', self.pdf_merge_screen, strFiles)
      submenu.append_item(pdf_merge_screen)

      # ebook
      pdf_merge_ebook = Nautilus.MenuItem(name='PDFMergeMenuProvider::pdf_merge_ebook', label='Low quality, 150 dpi images', icon='pdf-merge')
      pdf_merge_ebook.connect('activate', self.pdf_merge_ebook, strFiles)
      submenu.append_item(pdf_merge_ebook)

      # printer
      pdf_merge_printer = Nautilus.MenuItem(name='PDFMergeMenuProvider::pdf_merge_printer', label='High quality, 300 dpi images', icon='pdf-merge')
      pdf_merge_printer.connect('activate', self.pdf_merge_printer, strFiles)
      submenu.append_item(pdf_merge_printer)

      # prepress
      pdf_merge_prepress = Nautilus.MenuItem(name='PDFMergeMenuProvider::pdf_merge_prepress', label='High quality, 300 dpi, color preserving', icon='pdf-merge')
      pdf_merge_prepress.connect('activate', self.pdf_merge_prepress, strFiles)
      submenu.append_item(pdf_merge_prepress)

      # return created menus
      return [pdf_merge]

    else: return
