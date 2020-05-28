#!/usr/bin/env python3
# ---------------------------------------------------------
# Nautilus extension to convert a video file
#  to MKV with AAC audio and optional midnight mode 
# Menus is displayed according to pdf-booklet availability
#
# Revision history :
#   26/05/2020, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------------

import subprocess
import pathlib
from gi.repository import Nautilus, GObject

class ConvertMkvAacMenuProvider(GObject.GObject, Nautilus.MenuProvider):

  def convert_mkvaac(self, menu, file): subprocess.Popen("video-convert2mkvaac --video '" + file + "'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  def get_file_items(self, window, files):
    # if multiple selection, nothing to do
    if len(files) != 1: return

    # check availability of video conversion tool
    file = pathlib.Path("/usr/local/bin/video-convert2mkvaac")
    if not file.exists (): return

    # check if file is in the supported file types
    if files[0].get_mime_type() in ('video/x-matroska' 'video/mp4' 'video/mpeg' 'video/web' 'video/x-msvideo'):
      
      # get filename
      filename = files[0].get_uri()
      
      # create menu item for right click menu
      convert_mkvaac_menu = Nautilus.MenuItem(name='ConvertMkvAacMenuProvider::convert_mkvaac', label='Video - Convert to MKV/AAC', icon='video-aac')
      convert_mkvaac_menu.connect('activate', self.convert_mkvaac, filename)

      return [convert_mkvaac_menu]

    # else, nothing to do
    else: return
