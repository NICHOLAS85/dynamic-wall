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
By default this installs dynamicwall into ~/bin in a folder named dynamic-wall. To change this installation prefix run:

```sh
./install --install-dir /your/custom/directory
```

To update an existing installation run :

```sh
./update
```

To uninstall run:

```sh
./remove
```

You will be prompted for a password which will add/remove dynamicwall from your $PATH.

### Cronjob instead of Systemd Service

If you would like to install this script and use cron instead of systemd, simply add the `--cron` argument to your install command:

```sh
./install --cron
```

This will avoid installing any of the systemd service and timer files.

During installation a prompt will appear asking whether or not you would like to install a system-sleep script to trigger dynamicwall on wakeup. This will install a script into `/lib/systemd/system-sleep/` called dynamicwall.sh. This script simply updates your wallpaper when your computer wakes from suspension. You can select n to skip this. (Not needed for those who installed without --cron argument)

A cronjob will automatically be generated for you. All config options should be adjusted in dynamicwall.config regardless of if you're using cron or systemd.

## Usage

The systemd service, cronjob, and system-sleep script will automatically change your wallpaper at your set interval if an hour has passed in the day, otherwise it will not do anything. You can run the script manually by typing `dynamicwall` into your terminal.

```sh
$ dynamicwall -h
Usage: dynamicwall [OPTIONS]

optional args:
  -f, --force [time]     Update wallpaper immediately, optionally to a specific time
  -p, --preview <theme>  Run a 24 hour preview for a certain theme
  -c, --config         	 Edit your config file using your default editor
  -s, --status           Display systemd service status/crontab and system-sleep script log
  -l, --list             List available themes to choose from
  -h, --help             Show help
```

`-f` uses your last saved config and ignores any changes added to your config files since. You can optionally set a time to force update the wallpaper to. You timeoffset value is considered when using this command.

`-c` edits your config file using your $EDITOR (falls back to nano) and then allows dynamicwall to run, reflecting your changes immediately.

**Warning, can cause high memory usage**  
`-p` allows you to quickly preview a specific theme. ex: `dynamicwall --preview EarthView`

`-l` list all folders in your theme directory regardless of if they're in a valid format.

## Configuration

All config options can be found in `~/bin/dynamic-wall/dynamicwall.config`. If you mess up your config `default.config` is a backup.<br/>In addition to `dynamicwall.config` there is a file named `override.config` which can be placed into a theme folder. Any variables set in here will override it's corresponding value in `dynamicwall.config` when that theme is loaded, allowing for per-theme configuration.

Available config options:

-   `cur_theme`: Choose the theme which will be used on your desktop.
-   `lock_theme`: Choose the theme which will be used on your lockscreen.
    -   Three themes are offered by default:<br/>`mojave_dynamic`, `NewOrleans`, and `EarthView`.
    -   Lockscreen theming is completely optional, uncomment this option if you would like to theme your lockscreen.
-   `timeoffset`: Number of hours the cycle is shifted by.
-   `refreshrate`: Rate at which script is called. Only 16 images are cycled so higher numbers ≠ smoother transitions.
-   `notifications`: Sets whether or not desktop notifications are shown.
    -   Notifications are normally shown when configuration options are changed, notifying the user their new settings are in effect.
-   `theme_dir`: Path to your theme folder, if you decide to store themes elsewhere.
-   `date[real]`: Freeze wallpaper cycle at specific time of day.

dynamicwall.config is checked every time the script is run and detects changes automatically, applying these changes immediately if they are valid. Run `dynamicwall -c` to make changes and they will be immediately applied.

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
