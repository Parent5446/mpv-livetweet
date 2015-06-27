mpv-livetweet
=============
Be that dick who tweets screenshots of their favourite anime spoiling everyone **without even having to leave your player!**

> *"whoa, integrated tweeting in movie players. The relentless march of progress"* - **[@jons520](https://twitter.com/jons520/status/611668022902697984)**

> *"lol straight to twitter, your followers probably hate you"* - **[ChrisK2](https://github.com/ChrisK2)**

> *"you're creating a monster"* - **Cidoku**

### Features
  * Text adding
  * Multi-screenshot drifting
  * Annie-May hashtag retrieving
  * Best app name ever

Download the script [here](https://github.com/steinuil/mpv-livetweet/archive/text.zip).

### Requirements
  * [lua](https://lua.org/) 5.1.x/5.2.x
  * [luarocks](https://luarocks.org/) >= 2.2.0
  * [luatwit](https://github.com/darkstalker/LuaTwit) and [luasocket](http://w3.impa.br/~diego/software/luasocket/) (`luarocks install luatwit luasocket`)
  * [Zenity](https://wiki.gnome.org/Projects/Zenity) (only for Linux/BSD/etc)
  * [A half-decent OS](https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation) (not Windows)

Currently only tested on Lua 5.1, should work on 5.2 too. 5.3 is no good since mpv doesn't support it yet.

One of the libraries required by LuaTwit doesn't support Windows, so you won't be able to install the dependencies. If that somehow changes, the script will run without problems.

Installation
------------
  * Run `lua get-keys.lua` and follow the instructions to get your OAuth keys. Save the keys somewhere safe.
  * Open `mpv-livetweet.lua` in your favourite text editor to configure it.
  * Move `mpv-livetweet.lua` to `~/.config/mpv/scripts` or `%APPDATA%/mpv/scripts` depending on your OS.

### Commands
| Shortcut        | When queue is empty                  | With screenshots in queue             |
| --------------- | ------------------------------------ | ------------------------------------- |
| **Alt+a**       | Queue a screenshot                   | Queue a screenshot                    |
| **Alt+w**       | Tweet single screenshot              | Tweet queued screenshots              |
| **Shift+Alt+w** | Tweet single screenshot with comment | Tweet queued screenshots with comment |
| **Shift+Alt+c** | -                                    | Delete queued screenshots             |

You can tweet up to 4 screenshots at once.

If you want to remap the shortcuts, you can do so by adding them to `~/.config/mpv/input.conf`. For example, to remap the "queue screenshot" function to alt+d, add this to your input.conf:

```
alt+d script_binding mpv-livetweet.queue_screenshot
```

Replace `queue_screenshot` with the name of the function you want to remap. The functions are `queue_screenshot`, `tweet`, `tweet_with_comment` and `cancel_tweet`.

Troubleshooting
---------------
If you did everything right, the script should work. If you still have problems, add an issue on here or fire me a question on [twitter](https://twitter.com/steinuil).

### Lua can't find some of the files in the required libraries!
Good luck with that. It's a luarocks problem, you should try finding out your package path with `lua -e 'print(package.path)'` and change your `/etc/luarocks/config-5.x.lua` file to match that. Setting the path to `/usr` did it for me, but it may depend on your OS/distro.

### I just tweeted a hundred thousand Onodera screenshots while watching Nisekoi and now my followers are halved!
Stop being [@nyarth](http://twitter.com/nyarth).

TODO
----
  - [X] Make the script more verbose.
    - [X] Actually check the answer of the server to determine if the screenshot was actually tweeted.
  - [X] Auto-detect the name of the anime you're watching and tweet with the respective hashtag.
    - [X] Integrate the AniList DB to retrieve said hashtag.
  - [X] Display a window for the tweet body on Linux.
    - [X] Come up with something similar for Windows.
	  - [X] Integrate the hashtag in the Windows script. Fuck you, CScript.exe.
  - [X] Add support for multiple screenshots.
  - [ ] Evaluate user's taste

----
![image](http://blog.codinghorror.com/content/images/uploads/2007/03/6a0120a85dcdae970b0128776ff992970c-pi.png)

If it doesn't work on yours, file an issue or bug me on twitter [@steinuil](https://twitter.com/steinuil)

Excessive use of the script might cause butthurt and follower loss. Use responsibly and in small doses.
