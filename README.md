# Dynamic wall

Various edits to the dynamic wallpaper scripts from [Raitaro](https://gitlab.com/RaitaroH/dynamic-wall) which was based on [/u/Electronicbrain work](https://www.reddit.com/r/unixporn/comments/a7mga5/plasma_a_clone_of_macos_mojaves_dynamic_wallpaper/). These edits integrate the script with systemd timers instead of using while do loops. An additional script was also created to change the wallpaper when the computer wakes from suspension.


#### Installation:  
*Only tested on a Debian system for KDE plasma*

replace every instance of `nicholas` to your username in the scripts. Found in dynamicwall.service

move bin into your home directory. ```chmod +x ~/bin/dynamic-wall/dynamic && chmod +x ~/bin/dynamic-wall/ksetwallpaper``` to make scripts executable

move dynamicwall.service, dynamicwall.timer, and dynamicwall.timer.d into `~/.config/systemd/user/`, might not exist so create it with `mkdir -p ~/.config/systemd/user/`

Run `sudo ln -s -f ~/.config/systemd/user/dynamicwall.timer.d/ /etc/systemd/system/ && systemctl enable ~/.config/systemd/user/dynamicwall.service ~/.config/systemd/user/dynamicwall.timer && systemctl daemon-reload && systemctl start dynamicwall.timer`to turn on timer and start script. Timer set to 30 minutes by default, can be adjusted in dynamicwall.config

To check the status of the services use `systemctl status dynamicwall.timer  dynamicwall.service`


#### Setting wallpaper after waking from suspension ###

move dynamicwall.sh to `/lib/systemd/system-sleep`

`chmod a+x dynamicwall.sh`to allow script to run

 To check the status of your wake up script use `journalctl -b -u systemd-suspend.service`

### Configuration ###
All config options can be found in `dynamicwall.config`, adjust settings here. If you mess up your config `default.config` is a backup.

### Other Notes ###

If you find some live wallpapers in the .heic format, use the the [libheif decoder](https://strukturag.github.io/libheif/) to convert it into usable jpegs, and add it into the themes folder. Image names must match theme folder name up until the number. ex /NewOrleans/NewOrleans1.jpg

If you've compiled libheif from the source heif-convert in the examples folder to convert your .heic into usable .jpg's. Follow this format `./path/to/heif-convert /path/to/encoded/image.heic /path/to/theme/folder`. Make sure the theme folder and image file names match
Only compatiple with images ending in .jpeg or .jpg at the moment
