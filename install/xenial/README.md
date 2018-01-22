Ubuntu post-installation scripts
================================

Here are the scripts I use to automatise installation of an Ubuntu or Ubuntu Gnome workstation.

Main script to be called is **post-install**. As it needs to run some **sudo** commands to install packages, you'll be prompted for your session password.

It takes few parameters according to the distribution type you are installing and the options you want.

| Option             | Description |
| -------------      | ------------- |
| **--ubuntu**       | Run post-installation for a Ubuntu distribution (unity)  |
| **--ubuntugnome**  | Run post-installation for a Ubuntu Gnome distribution |
| **--assistance**   | Add remote assistance tools |
| **--docky**        | Add docky launcher |
| **--wifi**         | Add some tweaks for problematic wifi cards |
| **--ssd**          | Add some tweaks for SSD disk |
| **--touchpad**     | Add some tweaks for trackpad and touchpad (use with caution) |
| **--gopro**        | Add GoPro bug correction |
| **--hp-printer**   | Add HP printers GUI |

This script call various specialized script in charge of installing latest tools for :
  * office work
  * graphical and design
  * multimedia
  * internet
  * android connectivity
  * utilities

Some of these post-installation operations are explained in details in various articles available under http://bernaerts.dyndns.org/linux/

Typical post Ubuntu installation command is :

    # wget https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/install/xenial/post-install
    # chmod +x ./post-install
    # ./post-install --ubuntu --docky --gopro
