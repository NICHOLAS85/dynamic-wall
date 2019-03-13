# Dynamic wall

Started as various edits to the dynamic wallpaper scripts from [Raitaro](https://gitlab.com/RaitaroH/dynamic-wall) which was based on [/u/Electronicbrain work](https://www.reddit.com/r/unixporn/comments/a7mga5/plasma_a_clone_of_macos_mojaves_dynamic_wallpaper/). These edits evolved into a complex script that integrate into a KDE with systemd timers instead of using while do loops. An additional script was also created to change the wallpaper when the computer wakes from suspension. Many new features have been added and can be seen below.


#### Installation:  
*Only tested on a Debian system*

*Only compatible with distros that use KDE Plasma as their DE*

Replace every instance of `nicholas` to your username in the scripts. Found in dynamicwall.service

Move dynamic-wall into `~/bin/`

Run to make script executable.
```sh
chmod +x ~/bin/dynamic-wall/dynamic && chmod
```

move dynamicwall.service, dynamicwall.timer, and dynamicwall.timer.d into `~/.config/systemd/user/`, might not exist so create it with
```sh
mkdir -p ~/.config/systemd/user/
```

Run to turn on timer and start script. Timer set to 30 minutes by default, can be adjusted in dynamicwall.config
```sh
sudo ln -s -f ~/.config/systemd/user/dynamicwall.timer.d/ /etc/systemd/system/ && systemctl enable ~/.config/systemd/user/dynamicwall.service ~/.config/systemd/user/dynamicwall.timer && systemctl daemon-reload && systemctl start dynamicwall.timer
```

To check the status of the services run
```sh
systemctl status dynamicwall.timer  dynamicwall.service
```


#### Setting wallpaper after waking from suspension ###

move dynamicwall.sh to `/lib/systemd/system-sleep`

Run to allow script to run.
```sh
chmod a+x dynamicwall.sh
```

To check the status of your wake up script run
```sh
journalctl -b -u systemd-suspend.service
```

### Usage ###
The systemd service and system-sleep script will automatically change your wallpaper at your set interval. If you want to update your wallpaper immediately simply run the script manually via `./bin/dynamic-wall/dynamic` or `systemctl start dynamicwall`

If you want to manually force the script to run use the command `~/bin/dynamic-wall/dynamic --force` or run it with `-f`. This option uses your last saved config and ignores any changes added since.

Use the `--update` or `-u` argument if you want to forcibly save all your settings. The script should automatically detect changes, but this can be used as a backup.

If you want to preview 24 hours of a specific theme use the `--preview` or `-p` argument then type the name of the theme you want to preview. ex: `~/bin/dynamic-wall/dynamic --preview mojave_dynamic`

### Configuration ###
All config options can be found in `dynamicwall.config`, adjust settings here. If you mess up your config `default.config` is a backup.

Options include using a custom theme, changing the default directory for the theme folder, timeoffset to shift the wallpaper cycle ahead or behind, refresh rate at which time is checked and wallpaper updates (Only 16 images are used so higher numbers do not equal smoother transitions), and manually inputting the time of day, effectively freezing the wallpaper cycle.

dynamicwall.config is checked every time the script is run and detects changes automatically, updating the active settings with the new configuration options. Use the `-u` argument to immediately apply changes seen in the Usage section above.

### Other Notes ###

If you find some dynamic wallpapers in the .heic format, use the [libheif decoder](https://github.com/strukturag/libheif) to convert it into usable jpegs, and add it into the themes folder. Image names must match the theme folder's name up until the number. ex: `/NewOrleans/NewOrleans1.jpg`

If you've compiled libheif from the source use heif-convert in the examples folder to convert your .heic into usable .jpeg's. Follow this format `./path/to/heif-convert /path/to/encoded/image.heic /path/to/theme_folder/image/image.jpg`. Make sure the theme folder and image file names match. The images are automatically labeled with the correct number needed, if not just renumber them to reorder them.

Only compatible with images ending in .jpeg or .jpg at the moment.

### TODO ###
* Create install/uninstall script
* Find licensing information for included themes
* Create a Randomize wallpaper option
