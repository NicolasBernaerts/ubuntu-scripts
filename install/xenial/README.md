Ubuntu post-installation scripts
================================

Here are the scripts I use to automatise installation of an Ubuntu or Ubuntu Gnome workstation.

Main script to be called is **post-install**. It takes few parameters according to the distribution type you are installing and the options you want.

- [x] --ubuntu          Run post-installation for a Ubuntu distribution (unity)"
- [ ] --ubuntugnome     Run post-installation for a Ubuntu Gnome distribution"
- [x] --docky           Add docky launcher"
- [ ] --wifi            Add some tweaks for problematic wifi cards"
- [ ] --ssd             Add some tweaks for SSD disk"
- [ ] --touchpad        Add some tweaks for trackpad"
- [x] --assistance      Add remote assistance tools"
- [x] --gopro           Add GoPro bug correction"

This script call various specialized script in charge of installing latest tools for :
  * office work
  * graphical and design
  * multimedia
  * internet
  * android connectivity
  * utilities

Some of these post-installation operations are explained in details in various articles available under http://bernaerts.dyndns.org/linux/
