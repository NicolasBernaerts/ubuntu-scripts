#!/usr/bin/python3
# ---------------------------------------------------------
# Nautilus extension to add Geolocalisation properties tab
# Procedure :
#   http://bernaerts.dyndns.org/linux/...
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
import codecs
gi.require_version("Nautilus", "3.0")
from gi.repository import Nautilus, GObject, Gtk
gi.require_version("GExiv2", "0.10")
from gi.repository import GExiv2
from gi.repository import Gio
from geopy.geocoders import Nominatim

# -------------------
# Property page
# -------------------
class GeotagPropertyPage(GObject.GObject, Nautilus.PropertyPageProvider):
  def __init__(self):
    pass

  # method to set one label in the table
  def SetLabel(self, value, row, column, width, align):
    # create label
    labelValue = Gtk.Label()
    labelValue.set_markup(value)

    # set alignment
    if align == "left": labelValue.set_alignment(xalign=0.0, yalign=0.0)
    if align == "center": labelValue.set_alignment(xalign=0.5, yalign=0.0)
    if align == "right": labelValue.set_alignment(xalign=1.0, yalign=0.0)

    # place label
    self.table.attach(labelValue, column, column + width, row, row + 1)
    return

  # method to set one label in the table
  def SetImage(self, filename, row, column, width, align):
    # create image from jpeg
    imageGeotag = Gtk.Image()
    imageGeotag.set_from_file(filename)

    # set margins
    imageGeotag.set_margin_top(10)
    imageGeotag.set_margin_bottom(5)

    # set alignment
    if align == "left": imageGeotag.set_alignment(xalign=0.0, yalign=0.0)
    if align == "center": imageGeotag.set_alignment(xalign=0.5, yalign=0.0)
    if align == "right": imageGeotag.set_alignment(xalign=1.0, yalign=0.0)

    # place image
    self.table.attach(imageGeotag, column, column + width, row, row + 1)
    return

  # method to generate properties tab
  def get_property_pages(self, files):
    # default map size and zoom factor
    sizeMap = '400x400'
    zoomMap = '8'
  
    # if dealing with multiple selection, return
    if len(files) != 1: return

    # if not dealing with file, return
    file = files[0]
    if file.get_uri_scheme() != 'file': return

    # if mimetype corresponds to JPG image, read data and populate tab
    mimetype = file.get_mime_type().split('/')
    if mimetype[0] in ('image'):
    
      # read data from APK file
      #filename = urllib.unquote(file.get_uri()[7:])
      uri = file.get_uri()
      gvfs = Gio.Vfs.get_default()
      filename = gvfs.get_file_for_uri(uri).get_path()

      # get metadata
      self.tags = GExiv2.Metadata(filename)

      # get GPS position from metadata
      posGPS = self.tags.get_gps_info()
      longitude = posGPS[0]
      latitude = posGPS[1]
      altitude = posGPS[2]

      # if no GPS data, return 
      if latitude == 0 and longitude == 0: return

      # generate GPS position
      strPosition = str(latitude) + ',' + str(longitude)

      # generate Google Maps links
      urlMaps = 'https://www.google.com/maps/place/' + strPosition + '/@' + strPosition + ',' + zoomMap + 'z/'
      urlJpeg = 'https://maps.googleapis.com/maps/api/staticmap?maptype=hybrid&zoom=' + zoomMap + '&size=' + sizeMap + '&center=' + strPosition + '&markers=' + strPosition

      # generate cache filenames
      dirHomeCache = os.environ['HOME'] + '/.cache'
      dirGeotagCache = os.getenv('XDG_CACHE_HOME', dirHomeCache) + '/geotag'
      fileMap = dirGeotagCache + '/map_' + str(longitude) + '_' + str(latitude) + '_' + sizeMap + '.png'
      fileDesc = dirGeotagCache + '/map_' + str(longitude) + '_' + str(latitude) + '.txt'

      # if cache directory doesn't exist, create it
      if not os.path.exists(dirGeotagCache): os.makedirs(dirGeotagCache)

      # if description is not in the cache, retrieve it from Nominatim
      if not os.path.exists(fileDesc):
        # retrieve place description
        geolocator = Nominatim()
        location = geolocator.reverse(strPosition)
        strDescription = location.address
        strDescription = strDescription[:90]

        # write description to cache
        file = codecs.open(fileDesc, "w", "utf-8")
        file.write(strDescription)
        file.close()
      else:
        # read description from cache
        file = codecs.open(fileDesc, "r", "utf-8")
        strDescription = file.read()
        file.close()

      # if map is not in the cache, retrieve it from Google Maps
      if not os.path.exists(fileMap): urllib.urlretrieve(urlJpeg, fileMap)

      # create table
      self.table = Gtk.Table(4, 3)

      # set spacing
      self.table.set_col_spacings(10)
      self.table.set_row_spacings(5)

      # set margins
      self.table.set_margin_start(10)
      self.table.set_margin_end(10)
      self.table.set_margin_top(10)
      self.table.set_margin_bottom(10)

      # populate table
      self.SetLabel("<b>Longitude</b>", 0, 0, 1, "center")
      self.SetLabel("<b>Latitude</b>", 0, 1, 1, "center")
      self.SetLabel("<b>Altitude</b>", 0, 2, 1, "center")
      self.SetLabel(str(longitude), 1, 0, 1, "center")
      self.SetLabel(str(latitude), 1, 1, 1, "center")
      self.SetLabel(str(altitude), 1, 2, 1, "center")
      self.SetImage(fileMap, 2, 0, 3, "center")
      self.SetLabel("<a href='" + urlMaps + "'>" + strDescription + "</a>", 3, 0, 3, "center")
 
      # set tab content (scrolled window -> table)
      tab_win = Gtk.ScrolledWindow()
      tab_win.add_with_viewport(self.table)
      tab_win.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.NEVER)
      tab_win.show_all()

      # set tab label
      tab_label = Gtk.Label('GPS')

      # return label and tab content
      return Nautilus.PropertyPage( name="NautilusPython::geotag_info", label=tab_label, page=tab_win ),
