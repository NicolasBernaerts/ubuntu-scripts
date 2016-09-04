#!/usr/bin/python
# ---------------------------------------------------------
# Nautilus extension to add Geolocalisation properties tab
# Procedure :
#   http://bernaerts.dyndns.org/linux/...
#
# Depends on :
#   * 
#
# Revision history :
#   30/08/2016, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------

# import libraries
import subprocess 
import urllib
import os
import os.path
import re
import pipes
import tempfile
import pygtk
import gi
gi.require_version("GExiv2", "0.10")
from gi.repository import GExiv2
gi.require_version("Nautilus", "3.0")
from gi.repository import Nautilus, GObject, Gtk

# -------------------
# Property page
# -------------------
class GeotagPropertyPage(GObject.GObject, Nautilus.PropertyPageProvider):
  def __init__(self):
    pass

  # method to set one label in the table
  def tableSetLabel(self, value, row, column, width, align):
    # create label
    labelValue = Gtk.Label()
    labelValue.set_markup(value)
    if align == "left": labelValue.set_alignment(xalign=0.0, yalign=0.5)
    if align == "right": labelValue.set_alignment(xalign=1.0, yalign=0.5)

    # place label
    self.table.attach(labelValue, column, column + width, row, row + 1)
    return

  # method to set one label in the table
  def tableSetImage(self, filename, row, column, width, align):
    # create image from jpeg
    imageGeotag = Gtk.Image()
    imageGeotag.set_from_file(filename)
    if align == "left": imageGeotag.set_alignment(xalign=0.0, yalign=0.5)
    if align == "right": imageGeotag.set_alignment(xalign=1.0, yalign=0.5)

    # place image
    self.table.attach(imageGeotag, column, column + width, row, row + 1)
    return

  # method to generate properties tab
  def get_property_pages(self, files):
    # default map size and zoom factor
    sizeMap = '320x320'
    zoomMap = '10'
  
    # if dealing with multiple selection, return
    if len(files) != 1:
      return

    # if not dealing with file, return
    file = files[0]
    if file.get_uri_scheme() != 'file':
      return

    # if mimetype corresponds to JPG image, read data and populate tab
    if file.get_mime_type() in ('image/jpeg' 'image/png'):
    
      # read data from APK file
      filename = urllib.unquote(file.get_uri()[7:])

      # get EXIF metadata
      self.exif = GExiv2.Metadata(filename)

      # get GPS position from metadata
      posGPS = self.exif.get_gps_info()
      longitude = posGPS[1]
      latitude = posGPS[0]
      strPosition = str(longitude) + ',' + str(latitude)

      # generate Google Maps link
      urlMaps = 'https://www.google.com/maps/place/' + strPosition + '/@' + strPosition + ',' + zoomMap + 'z/'
      urlJpeg = 'https://maps.googleapis.com/maps/api/staticmap?maptype=hybrid&zoom=' + zoomMap + '&size=' + sizeMap + '&center=' + strPosition + '&markers=' + strPosition

      # create table
      self.table = Gtk.Table(4, 2)
      self.table.set_col_spacings(20)
      self.table.set_row_spacings(0)

      # populate table
      self.tableSetLabel("<b>Longitude</b>", 0, 0, 1, "right")
      self.tableSetLabel(str(longitude), 0, 1, 1, "left")
      self.tableSetLabel("<b>Latitude</b>", 1, 0, 1, "right")
      self.tableSetLabel(str(latitude), 1, 1, 1, "left")
      self.tableSetLabel("<b>Maps</b>", 2, 0, 1, "right")
      self.tableSetLabel("<a href='" + urlMaps + "'>Google Maps</a>", 2, 1, 1, "left")

      # generate map filename
      dirHomeCache = os.environ['HOME'] + '/.cache'
      dirGeotagCache = os.getenv('XDG_CACHE_HOME', dirHomeCache) + '/geotag'
      fileGeotag = dirGeotagCache + '/map_' + sizeMap + '_' + str(longitude) + '_' + str(latitude) + '.png'

      # if cache directory doesn't exist, create it
      if not os.path.exists(dirGeotagCache): os.makedirs(dirGeotagCache)

      # if map is not in the cache, retrieve it from Google Maps
      if not os.path.exists(fileGeotag): urllib.urlretrieve(urlJpeg, fileGeotag)

      # create image from jpeg
      self.tableSetImage(fileGeotag, 3, 1, 1, "left")

      # set tab content (scrolled window -> table)
      tab_win = Gtk.ScrolledWindow()
      tab_win.add_with_viewport(self.table)
      tab_win.show_all()

      # set tab label
      tab_label = Gtk.Label('GPS')

      # return label and tab content
      return Nautilus.PropertyPage( name="NautilusPython::geotag_info", label=tab_label, page=tab_win ),
