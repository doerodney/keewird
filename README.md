# keewird
A clone of the `keyword` game, which my lovely wife ~~elbows me out of the way~~ plays at the first opportunity.

This uses the C ncurses library so that it can be used in a bash terminal.  (I finally have an excuse to learn ncurses.  Too bad I had to retire to get here.)

Eventually, the finished product will be implemented in a container.

## keewird Example

Here is an example of a keewird board:

```
  r       b
  e     h u
  t     e t
  a     a t
_ _ _ _ _ _
o n o o t r
w   u m h 
    n b
    d a
      t
```

Your task is to select the word represented by the underscores that completes the partial words that appear.  For example:
- _ow could be completed with b, c, h, l, m, n, p, r, s, t, v, or w
- reta_n can only be completed with i
- _ound can be completed with b, f, m, p, r, pr s
- _ombat can be completed with c or w
- hea_th can be completed with l or r
- butt_er can only be completed with e



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
 
