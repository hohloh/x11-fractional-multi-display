# X11-fractional-multi-display
An autostart script introducing fractional display scaling for X11 using multiple displays. Includes ordering of display outputs.

## Disclaimer and current issues 
This script is designed to run as an autostart application and needs a corresponding .desktop file. I created it under GNOME 40.4.0 due to the lack of other options to correctly scale multiple displays fractionally.

### Known issues 
Due to the script only executing after boot/login, display output breaks when:

- Disconnecting/connecting a display
- Resetting the GNOME shell using _Alt+F2 + "r"_ or _gnome-shell --replace &_
- Changing display settings in the GUI

Two workarounds are logging out or resetting xrandr using the _displays_reset.sh_ script in the repository before (dis-)connecting displays or making changes in the GUI.

## Instructions

### Short note on the "right" settings
When using the script, I had the best results setting my system scaling to 200% and then "zooming out" using xrandr. In my version of GNOME, the safest way to permanently setting the scaling to 200% was to editthe scaling factor in _org.gnome.desktop.interface_ and set it to _2_.

The graphical tool to do this is [dconf-editor](https://apps.gnome.org/DconfEditor/).

In my setup, I'm using three displays of the same brand and model. For now, I haven't had the need to extend the script for multiple displays using different resolutions, although that certainly can be done. 

tl;dr of my setup and settings: 
- Displays: 4K 27" x3
- Xrandr scaling: 1.35x1.35
- GNOME scaling factor: 2

### How to use

Create the autostart directory if it does not exist:
```sh
mkdir -p ~/.config/autostart
```

Clone the repository:
```sh
git clone https://github.com/hohloh/x11-fractional-multi-display && cd x11-fractional-multi-display
```

Make your modifications to _set_all_displays.sh_. You can see your currently connected displays using: 

```
xrandr
```

You will have to reference these displays inside the script in the correct order.

The _xrandr_ command will also show you information about which display is set to "primary". In order to figure out the correct order/positioning, you can use your DEs/WMs built in tools or a tool like [arandr](https://christian.amsuess.com/tools/arandr/).

The other most important thing you will want to change in the script is of course _scale_. See the note above for a reference and adjust it to your preference.

Copy the files to autostart:
```sh
cp set_all_displays.sh set_displays.desktop ~/.config/autostart
```

Make the script and .desktop files executable:
```sh
cd ~/.config/autostart && sudo chmod +x set_all_displays.sh set_displays.desktop 
```
Log out and back in to confirm your settings.
