#!/usr/bin/env python3
# ---------------------------------------------------
#
# Nautilus extension to resize image files 
# to predefined formats
#
# Tools handled are :
#   * image-convert
#
# Revision history :
#   03/05/2020, V1.0 - Creation by N. Bernaerts
#   30/04/2025, v1.1 - Update get_file_items
#
# ---------------------------------------------------

import subprocess
import pathlib
from gi.repository import Nautilus, GObject

class ImageResizeMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def resize_cdcover(self, menu, listUri):
    subprocess.Popen("image-convert --width 480 --height 480 " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def resize_dvdcover(self, menu, listUri):
    subprocess.Popen("image-convert --width 480 --height 600 " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def resize_fullhd(self, menu, listUri):
    subprocess.Popen("image-convert --width 1920 --height 1080 " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def resize_300x300(self, menu, listUri):
    subprocess.Popen("image-convert --width 300 --height 300 --keep-ratio " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def resize_600x600(self, menu, listUri):
    subprocess.Popen("image-convert --width 600 --height 600 --keep-ratio " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def resize_900x900(self, menu, listUri):
    subprocess.Popen("image-convert --width 900 --height 900 --keep-ratio " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def resize_1200x1200(self, menu, listUri):
    subprocess.Popen("image-convert --width 1200 --height 1200 --keep-ratio " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def resize_2000x2000(self, menu, listUri):
    subprocess.Popen("image-convert --width 2000 --height 2000 --keep-ratio " + listUri, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, files):

    # variables
    strFiles = ""
    onlyImage = True;
    
    # check if array is only composed of image files
    for file in files:
      strFiles += file.get_uri() + " "
      mimetype = file.get_mime_type().split('/')
      if mimetype[0] != 'image': onlyImage = False;
      
    # create sub-menu item Image resize
    file = pathlib.Path("/usr/local/bin/image-convert")
    if onlyImage == True and file.exists ():
    
      # create menu item for right click menu
      resize_menu = Nautilus.MenuItem(name='ImageResizeMenuProvider::resize_menu', label='Image - Resize to ...', icon='image-convert')
      submenu = Nautilus.Menu()
      resize_menu.set_submenu(submenu)

      # resize to CD cover
      resize_cdcover = Nautilus.MenuItem(name='ImageResizeMenuProvider::resize_cdcover', label='CD cover (480x480)')
      resize_cdcover.connect('activate', self.resize_cdcover, strFiles)
      submenu.append_item(resize_cdcover)

      # resize to DVD cover
      resize_dvdcover = Nautilus.MenuItem(name='ImageResizeMenuProvider::resize_dvdcover', label='DVD cover (480x600)')
      resize_dvdcover.connect('activate', self.resize_dvdcover, strFiles)
      submenu.append_item(resize_dvdcover)

      # resize to Full HD
      resize_fullhd = Nautilus.MenuItem(name='ImageResizeMenuProvider::resize_fullhd', label='Full HD (1920x1080)')
      resize_fullhd.connect('activate', self.resize_fullhd, strFiles)
      submenu.append_item(resize_fullhd)

      # resize to 300x300
      resize_300x300 = Nautilus.MenuItem(name='ImageResizeMenuProvider::resize_300x300', label='Very small (300 px)')
      resize_300x300.connect('activate', self.resize_300x300, strFiles)
      submenu.append_item(resize_300x300)

      # resize to 600x600
      resize_600x600 = Nautilus.MenuItem(name='ImageResizeMenuProvider::resize_600x600', label='Small (600 px)')
      resize_600x600.connect('activate', self.resize_600x600, strFiles)
      submenu.append_item(resize_600x600)

      # resize to 900x900
      resize_900x900 = Nautilus.MenuItem(name='ImageResizeMenuProvider::resize_900x900', label='Medium (900 px)')
      resize_900x900.connect('activate', self.resize_900x900, strFiles)
      submenu.append_item(resize_900x900)

      # resize to 1200x1200
      resize_1200x1200 = Nautilus.MenuItem(name='ImageResizeMenuProvider::resize_1200x1200', label='Large (1200 px)')
      resize_1200x1200.connect('activate', self.resize_1200x1200, strFiles)
      submenu.append_item(resize_1200x1200)

      # resize to 2000x2000
      resize_2000x2000 = Nautilus.MenuItem(name='ImageResizeMenuProvider::resize_2000x2000', label='Very large (2000 px)')
      resize_2000x2000.connect('activate', self.resize_2000x2000, strFiles)
      submenu.append_item(resize_2000x2000)

      return [resize_menu]

    # else, nothing to do
    else: return
    
