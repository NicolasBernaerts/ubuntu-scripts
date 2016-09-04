#!/usr/bin/python
# ---------------------------------------------------------
# Nautilus extension to add Geolocalisation properties tab
# Procedure :
#   http://bernaerts.dyndns.org/linux/...
#
# Depends on :
#   * aapt
#
# Revision history :
#   30/08/2016, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------

# import libraries
import urllib
import os
import os.path
import re
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
    mimetype = file.get_mime_type().split('/')
    if mimetype[0] in ('image'):
    
      # read data from APK file
      filename = urllib.unquote(file.get_uri()[7:])

      # get metadata
      self.tags = GExiv2.Metadata(filename)

      # get GPS position from metadata
      posGPS = self.tags.get_gps_info()
      longitude = posGPS[0]
      latitude = posGPS[1]
      altitude = posGPS[2]

      # if latitude unavailable,
      if latitude == 0:

        # read value from Exif.Exif.GPSInfo.GPSLatitude
        if 'Exif.GPSInfo.GPSLatitude' in self.tags:  
          arr_gps = self.tags['Exif.GPSInfo.GPSLatitude'].split()
          gps_part = arr_gps[0].split('/')
          gps_deg_val = float(gps_part[0])
          gps_deg_div = float(gps_part[1])
          gps_part = arr_gps[1].split('/')
          gps_min_val = float(gps_part[0])
          gps_min_div = float(gps_part[1])
          gps_part = arr_gps[2].split('/')
          gps_sec_val = float(gps_part[0])
          gps_sec_div = float(gps_part[1])
          latitude = (gps_deg_val / gps_deg_div) + (gps_min_val / gps_min_div / 60) + (gps_sec_val / gps_sec_div / 3600)

        # set latitude sign according to Exif.GPSInfo.GPSLatitudeRef
        if 'Exif.GPSInfo.GPSLatitudeRef' in self.tags:  
          gps_ref = self.tags['Exif.GPSInfo.GPSLatitudeRef']
          if gps_ref == 'S': latitude = -latitude

      # if longitude unavailable,
      if longitude == 0:

        # read value from Exif.GPSInfo.GPSLongitude
        if 'Exif.GPSInfo.GPSLongitude' in self.tags:  
          arr_gps = self.tags['Exif.GPSInfo.GPSLongitude'].split()
          gps_part = arr_gps[0].split('/')
          gps_deg_val = float(gps_part[0])
          gps_deg_div = float(gps_part[1])
          gps_part = arr_gps[1].split('/')
          gps_min_val = float(gps_part[0])
          gps_min_div = float(gps_part[1])
          gps_part = arr_gps[2].split('/')
          gps_sec_val = float(gps_part[0])
          gps_sec_div = float(gps_part[1])
          longitude = (gps_deg_val / gps_deg_div) + (gps_min_val / gps_min_div / 60) + (gps_sec_val / gps_sec_div / 3600)

        # set longitude sign according to Exif.GPSInfo.GPSLongitudeRef
        if 'Exif.GPSInfo.GPSLongitudeRef' in self.tags:  
          gps_ref = self.tags['Exif.GPSInfo.GPSLongitudeRef']
          if gps_ref == 'W': longitude = -longitude

      # if altitude unavailable,
      if altitude == 0:

        # read value from Exif.GPSInfo.GPSAltitude
        if 'Exif.GPSInfo.GPSAltitude' in self.tags:  
          gps_part = self.tags['Exif.GPSInfo.GPSAltitude'].split('/')
          alt_val = float(gps_part[0])
          alt_div = float(gps_part[1])
          altitude = (alt_val / alt_div)

        # set altitude sign according to Exif.GPSInfo.GPSAltitudeRef
        if 'Exif.GPSInfo.GPSAltitudeRef' in self.tags:  
          gps_ref = self.tags['Exif.GPSInfo.GPSAltitudeRef']
          if gps_ref == '1': altitude = -altitude

      # generate Google Maps link
      strPosition = str(latitude) + ',' + str(longitude)
      urlMaps = 'https://www.google.com/maps/place/' + strPosition + '/@' + strPosition + ',' + zoomMap + 'z/'
      urlJpeg = 'https://maps.googleapis.com/maps/api/staticmap?maptype=hybrid&zoom=' + zoomMap + '&size=' + sizeMap + '&center=' + strPosition + '&markers=' + strPosition

      # create table
      self.table = Gtk.Table(5, 2)
      self.table.set_col_spacings(20)
      self.table.set_row_spacings(0)

      # populate table
      self.tableSetLabel("<b>Longitude</b>", 0, 0, 1, "right")
      self.tableSetLabel(str(longitude), 0, 1, 1, "left")
      self.tableSetLabel("<b>Latitude</b>", 1, 0, 1, "right")
      self.tableSetLabel(str(latitude), 1, 1, 1, "left")
      self.tableSetLabel("<b>Altitude</b>", 2, 0, 1, "right")
      self.tableSetLabel(str(altitude), 2, 1, 1, "left")
      self.tableSetLabel("<b>Maps</b>", 3, 0, 1, "right")
      self.tableSetLabel("<a href='" + urlMaps + "'>Google Maps</a>", 3, 1, 1, "left")

      # generate map filename
      dirHomeCache = os.environ['HOME'] + '/.cache'
      dirGeotagCache = os.getenv('XDG_CACHE_HOME', dirHomeCache) + '/geotag'
      fileGeotag = dirGeotagCache + '/map_' + sizeMap + '_' + str(longitude) + '_' + str(latitude) + '.png'

      # if cache directory doesn't exist, create it
      if not os.path.exists(dirGeotagCache): os.makedirs(dirGeotagCache)

      # if map is not in the cache, retrieve it from Google Maps
      if not os.path.exists(fileGeotag): urllib.urlretrieve(urlJpeg, fileGeotag)

      # create image from jpeg
      self.tableSetImage(fileGeotag, 4, 1, 1, "left")

      # set tab content (scrolled window -> table)
      tab_win = Gtk.ScrolledWindow()
      tab_win.add_with_viewport(self.table)
      tab_win.show_all()

      # set tab label
      tab_label = Gtk.Label('GPS')

      # return label and tab content
      return Nautilus.PropertyPage( name="NautilusPython::geotag_info", label=tab_label, page=tab_win ),
