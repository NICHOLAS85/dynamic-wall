# Dynamic Wall

Started as various edits to the dynamic wallpaper scripts from [Raitaro](https://gitlab.com/RaitaroH/dynamic-wall) which was based on [/u/Electronicbrain work](https://www.reddit.com/r/unixporn/comments/a7mga5/plasma_a_clone_of_macos_mojaves_dynamic_wallpaper/). These edits evolved into a complex script that integrates into a KDE system with systemd timers instead of using while do loops. An additional script was also created to change the wallpaper when the computer wakes from suspension. Many new features have been added and can be seen below.

#### Jump to
-   [Installation](#installation)
    -   [Cron](#cronjob-instead-of-systemd-service)
-   [Usage](#usage)
-   [Configuration](#configuration)
-   [Other Notes](#other-notes)
-   [Credits](#credits)
-   [TODO](#todo)

## Installation  
***Only tested Debian Testing and Manjaro Linux***

***Only compatible with distros that use KDE Plasma as their DE***

To install run setup:
```sh
./install
```

To uninstall run remove:
```sh
./remove
```
You will be prompted for a password which will run the scripts as root.

An additional script will be created in `/lib/systemd/system-sleep/` called dynamicwall.sh. This script simply updates the wallpaper when your computer wakes from suspension. You can delete it if you would like to implement this functionality some other way.

To check the status of the timer and service run:
```sh
systemctl status dynamicwall.timer dynamicwall.service
```

To check the status of your wake up scripts run:
```sh
journalctl -b -u systemd-suspend.service
```

## Cronjob instead of Systemd Service

If you would like to install this script and use cron instead of systemd, simply run install with the --cron argument:
```sh
./install --cron
```

This will avoid installing any of the systemd service and timer files, as well as stop from installing the system-sleep script which is reliant on Systemd.

A cronjob will automatically be generated for you. All config options should be adjusted in dynamicwall.config regardless of if you're using cron or systemd.

You can view the cronjob generated for you by running:
```sh
crontab -l
```

## Usage
The systemd service, cronjob, and system-sleep script will automatically change your wallpaper at your set interval if an hour has passed in the day, otherwise it will not do anything. You can run the script manually by typing `dynamicwall` into your terminal.

If you want to skip configuration checking use `dynamicwall --force` or run it with `-f`. This option uses your last saved config and ignores any changes added to your config files since.

Use the `--update` or `-u` argument if you want to forcibly save all your settings and run once. The script should automatically detect changes, but this can be used as a backup.

If you want to preview 24 hours of a specific theme use the `--preview` or `-p` argument then type the name of the theme you want to preview. ex: `dynamicwall --preview EarthView`

## Configuration
All config options can be found in `dynamicwall.config`, adjust settings here. If you mess up your config `default.config` is a backup.

Available config options:
*   `cur_theme`: Choose the theme which will be used.
    -   Three themes are offered by default:<br/>`mojave_dynamic`, `NewOrleans`, and `EarthView`.
*   `timeoffset`: Number of hours the cycle is shifted by.
*   `refreshrate`: Rate at which script is called. Only 16 images are cycled so higher numbers ≠ smoother transitions.
*   `theme_dir`: Path to your theme folder, if you decide to store themes elsewhere.
*   `date`: Freeze wallpaper cycle at specific time of day.

dynamicwall.config is checked every time the script is run and detects changes automatically, applying these changes immediately if they are valid. Run the script or use the `-u` argument to immediately apply changes as seen in the Usage section above.

## Other Notes

If you find some dynamic wallpapers in the .heic format, use the [libheif decoder](https://github.com/strukturag/libheif) to convert it into usable jpegs, and add it into the themes folder. Image names must match the theme folder's name up until the number. ex: `/themes/NewOrleans/NewOrleans1.jpg`

If you've compiled libheif from the source use heif-convert in the examples folder to convert your .heic into usable .jpeg's. Follow this format `./path/to/heif-convert /path/to/encoded/image.heic /path/to/themes/image/image.jpg`. Make sure the theme folder and image file names match. The images are automatically numbered. If for some reason the images are numbered out of order, just rename them and change their numbers.

If you don't feel like installing libheif, Strukturag has hosted an example site which allows you to extract images from .heic files one at a time. [Here's a link](https://strukturag.github.io/libheif/)

Only compatible with images ending in .jpeg or .jpg at the moment.

## Credits
EarthView theme created by developer Marcin Czachurski (<https://itnext.io/macos-mojave-dynamic-wallpapers-ii-f8b1e55c82f>)

NewOrleans theme created by Graphic Designer Yann Gall (<https://yanngall.com/new-orleans-bayou-saint-jean>)

mojave_dynamic theme created by Apple (<https://www.apple.com/macos/mojave/>)



## TODO
-   [x]  Create install script
    -   [ ]  Save config options when updating
-   [x]  Create uninstall script
-   [x]  Find credit for included themes
-   [x]  Support cron
-   [ ]  Create a silent mode, to hide KDE notifications
-   [ ]  Create a Randomize wallpaper option
-   [ ]  Support other image types
-   [ ]  Create override configs which are read from a themes folder
