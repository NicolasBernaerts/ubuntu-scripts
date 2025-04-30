#!/usr/bin/env python3
# -------------------------------------------------------------------------------
#
# Nautilus extension to display EXIF properties tab
# Dependency :
#   - gir1.2-gexiv2-0.10
# Procedure :
#   http://www.bernaerts-nicolas.fr/linux/...
#
# Revision history :
#   02/09/2016, V1.0 - Creation by N. Bernaerts
#   24/04/2020, v2.0 - rewrite for python3 compatibility
#   30/04/2025, v2.1 - change PropertiesPageProvider to PropertiesModelProvider
#
# --------------------------------------------------------------------------------

# -------------------
#  Import libraries
# -------------------

import gi
gi.require_version("Gtk", "4.0")
gi.require_version("GExiv2", "0.10")
from urllib.parse import unquote
from gi.repository import Nautilus, GObject, Gtk
from gi.repository.GExiv2 import Metadata 

# --------------------
#   Class definition
# --------------------

class TagsPropertyPage(GObject.GObject, Nautilus.PropertiesModelProvider):
  def __init__(self):
    pass

  # --------------------
  #   Display one tag
  # --------------------
  def dislayTag(self, name, interpreted, raw_value, x, y):

    # check if third column is needed
    width = 1
    if raw_value == "": width = 2
    
    # dislay name
    gtk_label = Gtk.Label()
    gtk_label.set_markup(name)
    gtk_label.set_alignment(1.0, 0)
    gtk_label.set_padding(10, 2)
    gtk_label.show()
    self.grid.attach(gtk_label, x, y, 1, 1)

    # dislay interpreted string
    gtk_label = Gtk.Label()
    gtk_label.set_markup(interpreted)
    gtk_label.set_alignment(0.0, 0)
    gtk_label.set_padding(10, 2)
    gtk_label.show()
    self.grid.attach(gtk_label, x + 1, y, width, 1)

    # if different, dislay raw string
    if raw_value != "": 
      gtk_label = Gtk.Label()
      gtk_label.set_markup(raw_value)
      gtk_label.set_alignment(0.0, 0)
      gtk_label.set_padding(10, 2)
      gtk_label.show()
      self.grid.attach(gtk_label, x + 2, y, 1, 1)
    
    return

  # -------------------------
  #   Display property tab
  # -------------------------
  def get_property_pages(self, files):

    # test file type
    if len(files) != 1: return
    file = files[0]
    if file.get_uri_scheme() != 'file': return

    # if mimetype corresponds to an image, read exif tags
    #if file.get_mime_type() in ('image/jpeg' 'image/png'):
    mimetype = file.get_mime_type().split('/')
    if mimetype[0] == "image":
    
      # create label and grid
      self.property_label = Gtk.Label('EXIF')
      self.property_label.show()
      self.grid = Gtk.Grid()
      self.grid.set_margin_start(10)
      self.grid.set_margin_end(10)
      self.grid.set_margin_top(5)
      self.grid.set_margin_bottom(5)
      self.grid.show()

      # display title
      self.dislayTag("<b>Tag</b>", "<b>Readable value</b>", "<b>Raw value</b>", 0, 0)
      gtk_separator = Gtk.Separator(orientation=Gtk.Orientation.HORIZONTAL)
      self.grid.attach(gtk_separator, 0, 1, 3, 1)

      # read metadata from file
      filename = unquote(file.get_uri()[7:])
      self.tags = Metadata()
      self.tags.open_path(filename)

      # loop thru the tags
      index = 0
      for name in self.tags:
        interpreted = self.tags.get_tag_interpreted_string(name)[0:64]
        string_raw = self.tags.get_tag_string(name)[0:64]
        if interpreted == string_raw: string_raw = ""
        else: string_raw = "<i>" + string_raw + "</i>" 
        name = "<b>" + name + "</b>"
        self.dislayTag(name, interpreted, string_raw, 0, index + 2)
        index = index + 1

      # declare main scrolled window
      self.window = Gtk.ScrolledWindow()
      self.window.add_with_viewport(self.grid)
      self.window.show_all()

      # return label and tab content
      return Nautilus.PropertyPage( name="NautilusPython::tags_info", label=self.property_label, page=self.window),
