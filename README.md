# Dynamic Wall

Started as various edits to the dynamic wallpaper scripts from [Raitaro](https://gitlab.com/RaitaroH/dynamic-wall) which was based on [/u/Electronicbrain work](https://www.reddit.com/r/unixporn/comments/a7mga5/plasma_a_clone_of_macos_mojaves_dynamic_wallpaper/). These edits evolved into a complex script that integrate into a KDE system with systemd timers instead of using while do loops. An additional script was also created to change the wallpaper when the computer wakes from suspension. Many new features have been added and can be seen below.

#### Jump to

-   [Cron](#cronjob-instead-of-systemd-timers)
-   [Usage](#usage)
-   [Configuration](#configuration)
-   [Other Notes](#other-notes)
-   [Credits](#credits)
-   [TODO](#todo)

## Installation:  
*Only tested on a Debian system*

*Only compatible with distros that use KDE Plasma as their DE*

Replace every instance of `nicholas` to your username in the scripts. Found in dynamicwall.service

run setup as root:
```sh
sudo ./setup
```

This will also create a script in `/lib/systemd/system-sleep/` called dynamicwall.sh. This script simply updates the wallpaper when your computer wakes from suspension. You can delete it if you would like to implement this functionality some other way.

To check the status of the timer and service run:
```sh
systemctl status dynamicwall.timer dynamicwall.service
```

To check the status of your wake up scripts run:
```sh
journalctl -b -u systemd-suspend.service
```

## Cronjob instead of Systemd timers

If you would like to install this script and use cron instead of systemd, simply run setup with the --cron argument:
```sh
sudo ./setup --cron
```

This will avoid installing any of the systemd service and timer files, as well as stop from installing the system-sleep script.

Now you can create a cronjob to call your script. ex: `*/30 * * * * ~/bin/dynamic-wall/dynamic`

I haven't tested the above, but in theory it should work perfectly fine as a cronjob.

## Usage
The systemd service and system-sleep script will automatically change your wallpaper at your set interval. If you want to update your wallpaper immediately simply run the script manually via `./bin/dynamic-wall/dynamic` or `systemctl start dynamicwall`

If you want to manually force the script to run use the command `~/bin/dynamic-wall/dynamic --force` or run it with `-f`. This option uses your last saved config and ignores any changes added since.

Use the `--update` or `-u` argument if you want to forcibly save all your settings and run once. The script should automatically detect changes, but this can be used as a backup.

If you want to preview 24 hours of a specific theme use the `--preview` or `-p` argument then type the name of the theme you want to preview. ex: `~/bin/dynamic-wall/dynamic --preview mojave_dynamic`

## Configuration
All config options can be found in `dynamicwall.config`, adjust settings here. If you mess up your config `default.config` is a backup.

Available config options:
*   `cur_theme`: Select the theme which will be used.
*   `timeoffset`: Number of hours the cycle is shifted by.
*   `refreshrate`\*: Rate at which script is called automatically. Only 16 images are cycled so higher numbers ≠ smoother transitions.
*   `theme_dir`: Path to your theme folder, if you decide to store it elsewhere.
*   `date`: Freeze wallpaper cycle at specific time of day.

\* Unused if installed with --cron

dynamicwall.config is checked every time the script is run and detects changes automatically, applying these changes immediately if they are valid. Use run the script or use the `-u` argument to immediately apply changes as seen in the Usage section above.

## Other Notes

If you find some dynamic wallpapers in the .heic format, use the [libheif decoder](https://github.com/strukturag/libheif) to convert it into usable jpegs, and add it into the themes folder. Image names must match the theme folder's name up until the number. ex: `/theme_folder/NewOrleans/NewOrleans1.jpg`

If you've compiled libheif from the source use heif-convert in the examples folder to convert your .heic into usable .jpeg's. Follow this format `./path/to/heif-convert /path/to/encoded/image.heic /path/to/theme_folder/image/image.jpg`. Make sure the theme folder and image file names match. The images are automatically numbered. If for some reason the images are numbered out of order, just rename them and change their numbers.

If you don't feel like installing libheif, Strukturag has hosted an example site which allows you to extract images from .heic files one at a time. [Here's a link](https://strukturag.github.io/libheif/)

Only compatible with images ending in .jpeg or .jpg at the moment.

## Credits
EarthView theme created by developer Marcin Czachurski (<https://itnext.io/macos-mojave-dynamic-wallpapers-ii-f8b1e55c82f>)

NewOrleans theme created by Graphic Designer Yann Gall (<https://yanngall.com/new-orleans-bayou-saint-jean>)

mojave_dynamic theme created by Apple (<https://www.apple.com/macos/mojave/>)



## TODO
-   [x]  Create install script
-   [ ]  Create uninstall script
-   [x]  Find credit for included themes
-   [ ]  Support cron
-   [ ]  Create a silent mode, to hide KDE notifications
-   [ ]  Create a Randomize wallpaper option
-   [ ]  Support other image types
-   [ ]  Create timeoffset which is read from a themes folder
