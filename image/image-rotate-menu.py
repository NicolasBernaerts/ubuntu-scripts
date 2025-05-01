#!/usr/bin/env python3
# ---------------------------------------------------
#
# Nautilus extension to rotate image files lossless
#
# Tools handled are :
#   * image-rotate
#
# Revision history :
#   03/05/2020, V1.0 - Creation by N. Bernaerts
#   30/04/2025, v1.1 - Update get_file_items
#
# ---------------------------------------------------

import subprocess
import pathlib
from gi.repository import Nautilus, GObject

class ImageRotateMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def rotate_left(self, menu, listUri):
    subprocess.Popen("image-rotate --left " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def rotate_right(self, menu, listUri):
    subprocess.Popen("image-rotate --right " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def rotate_updown(self, menu, listUri):
    subprocess.Popen("image-rotate --updown " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, files):

    # variables
    strFiles = ""
    onlyImage = True;
    
    # check if array is only composed of image files
    for file in files:
      strFiles += file.get_uri() + " "
      if file.get_mime_type() not in ('image/jpeg' 'image/png' 'image/tiff' 'image/tiff'): onlyImage = False;
      
    # create sub-menu item Image rotate
    file = pathlib.Path("/usr/local/bin/image-rotate")
    if onlyImage == True and file.exists ():
    
      # create menu item for right click menu
      rotate_menu = Nautilus.MenuItem(name='ImageRotateMenuProvider::rotate_menu', label='Image - Rotate ...', icon='image-rotate')
      submenu = Nautilus.Menu()
      rotate_menu.set_submenu(submenu)

      # rotate left
      rotate_left = Nautilus.MenuItem(name='ImageRotateMenuProvider::rotate_left', label='Left (-90°)', icon='image-rotate-left')
      rotate_left.connect('activate', self.rotate_left, strFiles)
      submenu.append_item(rotate_left)

      # rotate right
      rotate_right = Nautilus.MenuItem(name='ImageRotateMenuProvider::rotate_right', label='Right (+90°)', icon='image-rotate-right')
      rotate_right.connect('activate', self.rotate_right, strFiles)
      submenu.append_item(rotate_right)

      # rotate updown
      rotate_updown = Nautilus.MenuItem(name='ImageRotateMenuProvider::rotate_updown', label='Up side down (+180°)', icon='image-rotate-updown')
      rotate_updown.connect('activate', self.rotate_updown, strFiles)
      submenu.append_item(rotate_updown)

      return [rotate_menu]

    # else, nothing to do
    else: return
    
