# Dynamic wall

I wanted to improve what a guy made on reddit. [/u/Electronicbrain](https://www.reddit.com/r/unixporn/comments/a7mga5/plasma_a_clone_of_macos_mojaves_dynamic_wallpaper/)

Also check out my [better repo here](https://gitlab.com/RaitaroH/KDE-Terminal-Wallpaper-Changer)

#### Installation:  

Clone and... basically just have the 2 scripts in your `~/bin`. 

You can also put the pics somewhere else but I provide a var you could change for that.

Not so fancy, but I expect you to know what to do.

#### Cronjob

You can use a crontab to call the script. I offer an onliner with no need for the `dynamic` script
```
*/30 * * * * date=$(date +%H | sed 's/\<0//g'); ~/bin/ksetwallpaper PATH_HERE/mojave_dynamic/mojave_dynamic_$date.jpeg
```