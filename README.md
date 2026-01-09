# keewird
A clone of the `keyword` game, which my lovely wife ~~elbows me out of the way~~ plays at the first opportunity.

This uses the C ncurses library so that it can be used in a bash terminal.  (I finally have an excuse to learn ncurses.  Too bad I had to retire to get here.)

Eventually, the finished product will be implemented in a container.

## Dependencies
To build locally, this requires:
* Installation of the ncurses library.
* Installation of the wamerican word list.

## Installation of the ncurses library

For Ubuntu:
```
sudo apt install libncurses5-dev libncursesw5-dev
```

NOTE:  You may be asked to `sudo apt update` and then `sudo apt upgrade` as part of the installation process.
 
