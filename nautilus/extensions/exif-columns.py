#!/usr/bin/python3
# ---------------------------------------------------
# Nautilus extension to add EXIF specific columns
# Procedure :
#   http://bernaerts.dyndns.org/linux/xxx...
#
# Revision history :
#   20/09/2016, V1.0 - Creation by N. Bernaerts
# ---------------------------------------------------

# import libraries
import urllib
import os
import re
import gi
gi.require_version("GExiv2", "0.10")
from gi.repository import GExiv2
gi.require_version("Nautilus", "3.0")
from gi.repository import Nautilus, GObject

# -------------------
# Column extension
# -------------------
class ExifColumnExtension(GObject.GObject, Nautilus.ColumnProvider, Nautilus.InfoProvider):
  def __init__(self):
    pass
    
  def get_data(self,filename):
    tag_camera = ""
    tag_focal = ""
    tag_city = ""
    tag_country = ""

    # get EXIF metadata
    self.tags = GExiv2.Metadata(filename)

    # read tags from metadata
    if 'Exif.Image.Model' in self.tags: tag_camera = self.tags['Exif.Image.Model']
    if 'Exif.Photo.FocalLengthIn35mmFilm' in self.tags: tag_focal = self.tags['Exif.Photo.FocalLengthIn35mmFilm']
    if 'Xmp.photoshop.City' in self.tags: tag_city = self.tags['Xmp.photoshop.City']
    if 'Xmp.photoshop.Country' in self.tags: tag_country = self.tags['Xmp.photoshop.Country']

    # check if GPS info available
    posGPS = self.tags.get_gps_info()
    if posGPS[0] <> 0 or posGPS[1] <> 0: tag_gps = "yes"
    else: tag_gps = "no"

    return tag_camera, tag_focal, tag_gps, tag_city, tag_country

  def get_columns(self):
      return (
        Nautilus.Column(name="NautilusPython::ExifCameraType", attribute="exif_camera_type", label="Camera", description="Camera model"),
        Nautilus.Column(name="NautilusPython::ExifFocalLength", attribute="exif_focal_length", label="Focal length", description="Focal length (equiv. 35mm)"),
        Nautilus.Column(name="NautilusPython::ExifGPS", attribute="exif_gps", label="GPS", description="Has GPS tags"),
        Nautilus.Column(name="NautilusPython::XMPCity", attribute="xmp_city", label="City", description="City (XMP tag)"),
        Nautilus.Column(name="NautilusPython::XMPCountry", attribute="xmp_country", label="Country", description="Country (XMP tag)"),
      )

  def update_file_info(self, file):
    # if not dealing with file, return
    if file.get_uri_scheme() != 'file':
      return
        
    # read data only if image file
    mimetype = file.get_mime_type().split('/')
    if mimetype[0] in ('image'):
      filename = urllib.unquote(file.get_uri()[7:])
      result = self.get_data(filename)
    else:
      result=("-", "-", "-", "-", "-") 

    # add data to file attributes
    file.add_string_attribute('exif_camera_type', result[0])
    file.add_string_attribute('exif_focal_length', result[1])
    file.add_string_attribute('exif_gps', result[2])
    file.add_string_attribute('xmp_city', result[3])
    file.add_string_attribute('xmp_country', result[4])
