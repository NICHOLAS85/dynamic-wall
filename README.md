# Dynamic wall

Various edits to the dynamic wallpaper scripts from [Raitaro](https://gitlab.com/RaitaroH/dynamic-wall) which was based on [/u/Electronicbrain work](https://www.reddit.com/r/unixporn/comments/a7mga5/plasma_a_clone_of_macos_mojaves_dynamic_wallpaper/). These edits integrate the script with systemd timers instead of using while do loops. An additional script was also created to change the wallpaper when the computer wakes from suspension. 


#### Installation:  
*Only tested on a Debian system for KDE plasma*

replace every instance of `nicholas` to your username in the scripts. Found in ksetwallpaper, dynamic, autowall.service, and autowall.sh

move bin into your home directory. ```chmod +x ~/bin/dynamic && chmod +x ~/bin/ksetwallpaper``` to make scripts executable 

move autowall.service and autowall.timer into `/etc/systemd/system/` 

Run ```systemctl daemon-reload```, ```systemctl enable /etc/systemd/system/autowall.timer``` and ```systemctl start /etc/systemd/system/autowall.timer``` to turn on timer and start script. Timer set to 15 minutes, can be adjusted in autowall.timer

To check the status of the services use ```systemctl status autowall.timer  autowall.service```


#### Setting wallpaper after waking from suspension

move autowall.sh to `/lib/systemd/system-sleep`

```chmod a+x autowall.sh``` to allow script to run
 
 To check the status of your wake up script use ```journalctl -b -u systemd-suspend.service```

### Other Notes ###

If you find some live wallpapers in the .heic format, use the the [libheif decoder](https://strukturag.github.io/libheif/) to convert it into usable jpegs, and add it into the script.
