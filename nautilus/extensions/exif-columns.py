#!/usr/bin/env python3
# ---------------------------------------------------
#
# Nautilus extension to add EXIF specific columns
#
# Dependency :
#   - gir1.2-gexiv2-0.10
#
# Procedure :
#   http://www.bernaerts-nicolas.fr/linux/xxx...
#
# Revision history :
#   20/09/2016, V1.0 - Creation by N. Bernaerts
#   25/04/2020, v2.0 - rewrite for python3 compatibility
#
# ---------------------------------------------------

# -------------------
#  Import libraries
# -------------------

import gi
gi.require_version("Gtk", "4.0")
gi.require_version("GExiv2", "0.10")
from urllib.parse import unquote
from gi.repository import Nautilus, GObject
from gi.repository.GExiv2 import Metadata 

# -------------------
# Column extension
# -------------------
class ExifColumnExtension(GObject.GObject, Nautilus.ColumnProvider, Nautilus.InfoProvider):
  def __init__(self): pass

  # -----------------------------
  #   List of available columns
  # -----------------------------
  def get_columns(self):
    return (
      Nautilus.Column(name="NautilusPython::ExifWidth", attribute="exif_width", label=" Width ", description="Image width"),
      Nautilus.Column(name="NautilusPython::ExifHeight", attribute="exif_height", label=" Height ", description="Image height"),
      Nautilus.Column(name="NautilusPython::ExifAperture", attribute="exif_apert", label="Aperture", description="Aperture"),
      Nautilus.Column(name="NautilusPython::ExifFocal", attribute="exif_focal", label="Focal", description="Focal length (35mm)"),
      Nautilus.Column(name="NautilusPython::ExifCity", attribute="exif_city", label="City", description="City"),
      Nautilus.Column(name="NautilusPython::ExifCountry", attribute="exif_country", label="Country", description="Country"),
      Nautilus.Column(name="NautilusPython::ExifGPS", attribute="exif_gps", label="GPS", description="GPS"),
      Nautilus.Column(name="NautilusPython::ExifMaker", attribute="exif_maker", label="Manufacturer", description="Camera manufacturer"),
      Nautilus.Column(name="NautilusPython::ExifModel", attribute="exif_model", label="Model", description="Camera model"),
    )

  # ------------------------
  #   Retrieve file values
  # ------------------------
  def update_file_info(self, file):
    # test file type
    if file.get_uri_scheme() != 'file': return

    # read data only if image file
    mimetype = file.get_mime_type().split('/')
    if mimetype[0] == "image":
    
      # format filename
      filename = unquote(file.get_uri()[7:])

      # get metadata
      self.tags = Metadata()
      self.tags.open_path(filename)

      # image width
      tag_value = ""
      if self.tags.has_tag('Exif.Photo.PixelXDimension'): tag_value = self.tags.get_tag_string('Exif.Photo.PixelXDimension')
      if tag_value == "" and self.tags.has_tag('Exif.Image.ImageWidth'): tag_value = self.tags.get_tag_string('Exif.Image.ImageWidth')
      file.add_string_attribute('exif_width', tag_value)

      # image height
      tag_value = ""
      if self.tags.has_tag('Exif.Photo.PixelYDimension'): tag_value = self.tags.get_tag_string('Exif.Photo.PixelYDimension')
      if tag_value == "" and self.tags.has_tag('Exif.Image.ImageLength'): tag_value = self.tags.get_tag_string('Exif.Image.ImageLength')
      file.add_string_attribute('exif_height', tag_value)

      # camera manufacturer
      tag_value = ""
      if self.tags.has_tag('Xmp.VendorInfo.Manufacturer'): tag_value = self.tags.get_tag_interpreted_string('Xmp.VendorInfo.Manufacturer')
      if tag_value == "" and self.tags.has_tag('Exif.Image.Make'): tag_value = self.tags.get_tag_interpreted_string('Exif.Image.Make')
      file.add_string_attribute('exif_maker', tag_value)

      # camera model
      tag_value = ""
      if self.tags.has_tag('Xmp.VendorInfo.Model'): tag_value = self.tags.get_tag_interpreted_string('Xmp.VendorInfo.Model')
      if tag_value == "" and self.tags.has_tag('Exif.Image.Model'): tag_value = self.tags.get_tag_interpreted_string('Exif.Image.Model')
      file.add_string_attribute('exif_model', tag_value)

      # camera focal length
      tag_value = ""
      if self.tags.has_tag('Xmp.Exif.FocalLengthIn35mmFormat'): tag_value = self.tags.get_tag_interpreted_string('Xmp.Exif.FocalLengthIn35mmFormat')
      if tag_value == "" and self.tags.has_tag('Exif.Photo.FocalLengthIn35mmFilm'): tag_value = self.tags.get_tag_interpreted_string('Exif.Photo.FocalLengthIn35mmFilm')
      if tag_value == "" and self.tags.has_tag('Exif.Photo.FocalLength'): tag_value = self.tags.get_tag_interpreted_string('Exif.Photo.FocalLength')
      file.add_string_attribute('exif_focal', tag_value)

      # camera aperture
      tag_value = ""
      if self.tags.has_tag('Xmp.Exif.ApertureValue'): tag_value = self.tags.get_tag_interpreted_string('Xmp.Exif.ApertureValue')
      if tag_value == "" and self.tags.has_tag('Exif.Photo.ApertureValue'): tag_value = self.tags.get_tag_interpreted_string('Exif.Photo.ApertureValue')
      if tag_value == "" and self.tags.has_tag('Exif.Photo.FNumber'): tag_value = self.tags.get_tag_interpreted_string('Exif.Photo.FNumber')
      file.add_string_attribute('exif_apert', tag_value)

      # city tag
      tag_value = ""
      if self.tags.has_tag('Xmp.City'): tag_value = self.tags.get_tag_interpreted_string('Xmp.City')
      if tag_value == "" and self.tags.has_tag('Xmp.photoshop.City'): tag_value = self.tags.get_tag_interpreted_string('Xmp.photoshop.City')
      if tag_value == "" and self.tags.has_tag('Iptc.City'): tag_value = self.tags.get_tag_interpreted_string('Iptc.City')
      file.add_string_attribute('exif_city', tag_value)
      
      # country tag
      tag_value = ""
      if self.tags.has_tag('Xmp.CountryName'): tag_value = self.tags.get_tag_interpreted_string('Xmp.CountryName')
      if tag_value == "" and self.tags.has_tag('Xmp.photoshop.Country'): tag_value = self.tags.get_tag_interpreted_string('Xmp.photoshop.Country')
      file.add_string_attribute('exif_country', tag_value)

      # GPS tag
      tag_value = "no"
      if self.tags.has_tag('Xmp.Exif.GPSLatitude'): tag_value = "yes"
      if tag_value == "no" and self.tags.has_tag('Xmp.LocationDetails.GPSLatitude'): tag_value = "yes"
      if tag_value == "no" and self.tags.has_tag('Exif.GPSInfo.GPSLatitude'): tag_value = "yes"
      file.add_string_attribute('exif_gps', tag_value)

    # else, file is not an image
    else:
      file.add_string_attribute('exif_maker', "")
      file.add_string_attribute('exif_model', "")
      file.add_string_attribute('exif_focal', "")
      file.add_string_attribute('exif_city', "")
      file.add_string_attribute('exif_country', "")
      file.add_string_attribute('exif_gps', "")

