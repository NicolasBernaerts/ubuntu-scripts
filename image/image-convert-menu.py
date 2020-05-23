#!/usr/bin/env python3
# ---------------------------------------------------
# Nautilus extension to convert image files 
# to predefined formats
# Tools handled are :
#   * image-convert
# Revision history :
#   03/05/2020, V1.0 - Creation by N. Bernaerts
#   22/05/2020, V1.1 - Add HEIC support
# ---------------------------------------------------

import subprocess
import pathlib
from gi.repository import Nautilus, GObject

class ImageConvertMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def convert_png(self, menu, listUri):
    subprocess.Popen("image-convert --format png " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def convert_jpg(self, menu, listUri):
    subprocess.Popen("image-convert --format jpg " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def convert_tiff(self, menu, listUri):
    subprocess.Popen("image-convert --format tiff " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def convert_gif(self, menu, listUri):
    subprocess.Popen("image-convert --format gif " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def convert_webp(self, menu, listUri):
    subprocess.Popen("image-convert --format webp " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def convert_heic(self, menu, listUri):
    subprocess.Popen("image-convert --format heic " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, window, files):

    # variables
    strFiles = ""
    onlyImage = True;
    
    # check if array is only composed of image files
    for file in files:
      strFiles += file.get_uri() + " "
      mimetype = file.get_mime_type().split('/')
      if mimetype[0] != 'image': onlyImage = False;
      
    # create sub-menu item Image convert
    file = pathlib.Path("/usr/local/bin/image-convert")
    if onlyImage == True and file.exists ():
    
      # create menu item for right click menu
      convert_menu = Nautilus.MenuItem(name='ImageConvertMenuProvider::convert_menu', label='Image - Convert to ...', icon='image-convert')
      submenu = Nautilus.Menu()
      convert_menu.set_submenu(submenu)

      # convert to PNG
      convert_png = Nautilus.MenuItem(name='ImageConvertMenuProvider::convert_png', label='PNG')
      convert_png.connect('activate', self.convert_png, strFiles)
      submenu.append_item(convert_png)

      # convert to JPG
      convert_jpg = Nautilus.MenuItem(name='ImageConvertMenuProvider::convert_jpg', label='JPEG')
      convert_jpg.connect('activate', self.convert_jpg, strFiles)
      submenu.append_item(convert_jpg)

      # convert to TIFF
      convert_tiff = Nautilus.MenuItem(name='ImageConvertMenuProvider::convert_tiff', label='TIFF')
      convert_tiff.connect('activate', self.convert_tiff, strFiles)
      submenu.append_item(convert_tiff)

      # convert to GIF
      convert_gif = Nautilus.MenuItem(name='ImageConvertMenuProvider::convert_gif', label='GIF')
      convert_gif.connect('activate', self.convert_gif, strFiles)
      submenu.append_item(convert_gif)

      # convert to WebP
      convert_webp = Nautilus.MenuItem(name='ImageConvertMenuProvider::convert_webp', label='WebP')
      convert_webp.connect('activate', self.convert_webp, strFiles)
      submenu.append_item(convert_webp)

      # convert to HEIC
      convert_heic = Nautilus.MenuItem(name='ImageConvertMenuProvider::convert_heic', label='HEIC')
      convert_heic.connect('activate', self.convert_heic, strFiles)
      submenu.append_item(convert_heic)

      return [convert_menu]

    # else, nothing to do
    else: return
    
