#!/usr/bin/env python3
# ---------------------------------------------------------
# Nautilus extension to add Geolocalisation properties tab
# Dependency :
#   * python3-geopy
# Procedure :
#   http://bernaerts.dyndns.org/linux/...
#
# Revision history :
#   30/08/2016, V1.0 - Creation by N. Bernaerts
#   05/11/2018, V1.1 - Add useragent to Nominatim
#   25/04/2020, v2.0 - rewrite for python3 compatibility
# ---------------------------------------------------

# -------------------
#  Import libraries
# -------------------

import os
import codecs
import re
import urllib.request
import gi
gi.require_version('Nautilus', '3.0')
gi.require_version("GExiv2", "0.10")
from urllib.parse import unquote
from gi.repository import Nautilus, GObject, Gtk, Gio
from gi.repository.GExiv2 import Metadata 
from geopy.geocoders import Nominatim

# -------------------
# Property page
# -------------------

class GeotagPropertyPage(GObject.GObject, Nautilus.PropertyPageProvider):
  def __init__(self): pass

  # -------------------
  #  Display text cell
  # -------------------
  def DisplayText(self, value, x, y, width, height, align):
    gtk_label = Gtk.Label()
    gtk_label.set_markup(value)
    if align == "left": gtk_label.set_alignment(0.0, 0)
    elif align == "right": gtk_label.set_alignment(1.0, 0)
    else: gtk_label.set_alignment(0.5, 0)
    gtk_label.set_padding(5, 2)
    gtk_label.show()
    self.grid.attach(gtk_label, x, y, width, height)

  # --------------------
  #  Display image cell
  # --------------------
  def DisplayImage(self, filename, x, y, width, height):
    # create image from jpeg
    gtk_image = Gtk.Image()
    gtk_image.set_from_file(filename)
    gtk_image.set_padding(5, 5)
    gtk_image.show()
    self.grid.attach(gtk_image, x, y, width, height)

  # -------------------------
  #   Display property tab
  # -------------------------
  def get_property_pages(self, files):
    # default map size and zoom factor
    sizeMap = "512x512"
    zoomMap = "7"
    apikey = "your-google-key"
  
    # test file type
    file = files[0]
    if len(files) != 1: return
    if file.get_uri_scheme() != 'file': return

    # if mimetype corresponds to JPG image, read data and populate tab
    mimetype = file.get_mime_type().split('/')
    if mimetype[0] in ('image'):
    
      # create tab
      self.tab = Gtk.Label('GPS')
      self.tab.show()

      # create grid
      self.grid = Gtk.Grid()
      self.grid.set_margin_start(10)
      self.grid.set_margin_end(10)
      self.grid.set_margin_top(5)
      self.grid.set_margin_bottom(5)
      self.grid.show()

      # create main scrolled window
      self.window = Gtk.ScrolledWindow()
      self.window.add_with_viewport(self.grid)
      self.window.show_all()

      # read metadata from file
      filename = unquote(file.get_uri()[7:])
      self.tags = Metadata()
      self.tags.open_path(filename)

      # get signed GPS position
      latitude  = self.tags.get_gps_latitude()
      longitude = self.tags.get_gps_longitude()
      altitude  = self.tags.get_gps_altitude()

      # if no GPS data, return
      if latitude == 0 and longitude == 0 and altitude == 0: return

      # trunk GPS data to 6 digits
      parts = str(latitude).split(".")
      strLatitude = parts[0] + "." + parts[1][:6]
      parts = str(longitude).split(".")
      strLongitude = parts[0] + "." + parts[1][:6]
      strAltitude = str(altitude)

      # generate GPS position
      strPosition = strLatitude + ',' + strLongitude

      # generate Google Maps links
      urlMaps = 'https://www.google.com/maps/place/' + strPosition + '/@' + strPosition + ',' + zoomMap + 'z/'
      urlJpeg = 'https://maps.googleapis.com/maps/api/staticmap?maptype=hybrid&zoom=' + zoomMap + '&size=' + sizeMap
      urlJpeg += '&center=' + strPosition + '&markers=' + strPosition + '&key=' + apikey
      
      # generate cache folder, and create if needed
      dirHomeCache = os.environ['HOME'] + '/.cache'
      dirGeotagCache = os.getenv('XDG_CACHE_HOME', dirHomeCache) + '/geotag'
      if not os.path.exists(dirGeotagCache): os.makedirs(dirGeotagCache)

      # generate cache file names
      fileMap = dirGeotagCache + '/map_' + strLatitude + '_' + strLongitude + '_' + sizeMap + '_' + zoomMap + '.png'
      fileDesc = dirGeotagCache + '/map_' + strLatitude + '_' + strLongitude + '.txt'

      # if description is not in the cache, retrieve it from Nominatim
      if not os.path.exists(fileDesc):
        # retrieve place description
        geolocator = Nominatim(user_agent="nautilus-exif-geotag")
        location = geolocator.reverse(strPosition)
        strDescription = location.address

        # write description to cache
        file = codecs.open(fileDesc, "w", "utf-8")
        file.write(strDescription)
        file.close()

      # if map is not in the cache, retrieve it from Google Maps
      if not os.path.exists(fileMap): urllib.request.urlretrieve(urlJpeg, fileMap)

      # retrieve description from cache
      file = codecs.open(fileDesc, "r", "utf-8")
      strDescription = file.read()
      file.close()

      # dislay GPS data
      self.DisplayText("<b>latitude</b>", 0, 0, 1, 1, "right")
      self.DisplayText(strLatitude, 1, 0, 1, 1, "left")
      self.DisplayText("<b>longitude</b>", 0, 1, 1, 1, "right")
      self.DisplayText(strLongitude, 1, 1, 1, 1, "left")
      self.DisplayText("<b>altitude</b>", 0, 2, 1, 1, "right")
      self.DisplayText(strAltitude, 1, 2, 1, 1, "left")

      # dislay address
      value = re.compile(',').sub('\n', strDescription)
      self.DisplayText("<b>address</b>", 2, 0, 1, 3, "right")
      self.DisplayText("<a href='" + urlMaps + "'>" + value + "</a>", 3, 0, 1, 5, "left")

      # dislay gmaps image
      self.DisplayImage(fileMap, 0, 5, 4, 1)

      # return label and tab content
      return Nautilus.PropertyPage( name="NautilusPython::geotag_info", label=self.tab, page=self.window ),
