# Dynamic Wall

Started as various edits to the dynamic wallpaper scripts from [Raitaro](https://gitlab.com/RaitaroH/dynamic-wall) which was based on [/u/Electronicbrain work](https://www.reddit.com/r/unixporn/comments/a7mga5/plasma_a_clone_of_macos_mojaves_dynamic_wallpaper/). These edits evolved into a complex script that integrates into a KDE system with systemd timers instead of using while do loops. Additionally cron compatibility was added, as an alternative to systemd. Many new features have been added and can be seen below.

#### Jump to

-   [Installation](#installation)
    -   [Cron](#cronjob-instead-of-systemd-service)
-   [Usage](#usage)
-   [Configuration](#configuration)
-   [Other Notes](#other-notes)
-   [Credits](#credits)
-   [TODO](#todo)

## Installation

**_Only tested Debian Testing and Manjaro Linux_**

**_Only compatible with distros that use KDE Plasma as their DE_**

**Prerequisites:**

-   kdialog
-   systemd OR cron

To install run:

```sh
./install
```

To update an existing installation run :

```sh
./update
```

To uninstall run:

```sh
./remove
```

You will be prompted for a password which will run the scripts as root.

To check the status of the timer and service run:

```sh
dynamicwall --status
```

### Cronjob instead of Systemd Service

If you would like to install this script and use cron instead of systemd, simply run install with the --cron argument:

```sh
./install --cron
```

This will avoid installing any of the systemd service and timer files.

During installation a prompt will appear asking whether or not you would like to install a system-sleep script to trigger dynamicwall on wakeup. This will install a script into `/lib/systemd/system-sleep/` called dynamicwall.sh. This script simply updates your wallpaper when your computer wakes from suspension. You can select n to skip this. (Not needed for those who installed without --cron argument)

A cronjob will automatically be generated for you. All config options should be adjusted in dynamicwall.config regardless of if you're using cron or systemd.

You can view the cronjob generated for you by running:

```sh
crontab -l
```

To check the status of your wake up scripts run:

```sh
journalctl -b -u systemd-suspend.service
```

Or simple run the following to view both

```sh
dynamicwall --status
```

## Usage

The systemd service, cronjob, and system-sleep script will automatically change your wallpaper at your set interval if an hour has passed in the day, otherwise it will not do anything. You can run the script manually by typing `dynamicwall` into your terminal.

```sh
$ dynamicwall -h
Usage: dynamicwall [OPTIONS]

optional args:
  -f, --force [time]     Update wallpaper immediately, optionally to a specific time
  -p, --preview <theme>  Run a 24 hour preview for a certain theme***EXPERIMENTAL***
  -c, --check            Force check configuration options and push to script
  -s, --status           Display systemd service status
  -h, --help             Show help
```

`-f` uses your last saved config and ignores any changes added to your config files since. You can optionally set a time to force update the wallpaper to. You timeoffset value is considered when using this command.

`-c` forcibly saves all your settings and run's dynamicwall once. The script should automatically detect changes, but this can be used as a backup.

**Warning EXPERIMENTAL, can cause high memory usage and trigger [EARLYOOM](https://github.com/rfjakob/earlyoom) if in use**  
`-p` allows you to preview a specific theme. ex: `dynamicwall --preview EarthView`

## Configuration

All config options can be found in `dynamicwall.config`, adjust settings here. If you mess up your config `default.config` is a backup.<br/>In addition to `dynamicwall.config` there is a file named `override.config` which can be placed into a theme folder. Any variables set in here will override it's corresponding value in `dynamicwall.config` when that theme is loaded, allowing for per-theme configuration.

Available config options:

-   `cur_theme`: Choose the theme which will be used.
    -   Three themes are offered by default:<br/>`mojave_dynamic`, `NewOrleans`, and `EarthView`.
-   `timeoffset`: Number of hours the cycle is shifted by.
-   `refreshrate`: Rate at which script is called. Only 16 images are cycled so higher numbers ≠ smoother transitions.
-   `notifications`: Sets whether or not desktop notifications are shown.
    -   Notifications are normally shown when configuration options are changed, notifying the user their new settings are in effect.
-   `theme_dir`: Path to your theme folder, if you decide to store themes elsewhere.
-   `date`: Freeze wallpaper cycle at specific time of day.

dynamicwall.config is checked every time the script is run and detects changes automatically, applying these changes immediately if they are valid. Run the script or use the `-c` argument to immediately apply changes as seen in the Usage section above.

## Other Notes

If you find some dynamic wallpapers in the .heic format, use the [libheif decoder](https://github.com/strukturag/libheif) to convert it into usable jpegs, and add it into the themes folder. Image names must match the theme folder's name up until the number. ex: `/themes/NewOrleans/NewOrleans1.jpg`

If you've compiled libheif from the source use heif-convert in the examples folder to convert your .heic into usable .jpeg's. Follow this format `./path/to/heif-convert /path/to/encoded/image.heic /path/to/themes/image/image.jpg`. Make sure the theme folder and image file names match. The images are automatically numbered. If for some reason the images are numbered out of order, just rename them and change their numbers.

If you don't feel like installing libheif, Strukturag has hosted an example site which allows you to extract images from .heic files one at a time. [Here's a link.](https://strukturag.github.io/libheif/)

**Only compatible with images ending in .jpeg, .jpg, or .png at the moment.**

## Credits

EarthView theme created by developer Marcin Czachurski (<https://itnext.io/macos-mojave-dynamic-wallpapers-ii-f8b1e55c82f>)

NewOrleans theme created by Graphic Designer Yann Gall (<https://yanngall.com/new-orleans-bayou-saint-jean>)

mojave_dynamic theme created by Apple (<https://www.apple.com/macos/mojave/>)

## TODO

-   [x]  Create install script
    -   [ ]  Save config options when updating
    -   [x]  <s>Optional system-sleep installation</s>
-   [x]  <s>Create uninstall script</s>
-   [x]  <s>Find credit for included themes</s>
-   [x]  <s>Support cron</s>
-   [x]  <s>Create a silent mode, to hide KDE notifications</s>
-   [ ]  Create a Randomize wallpaper option
-   [ ]  Support other image types
-   [x]  <s>Create override configs which are read from a themes folder</s>
