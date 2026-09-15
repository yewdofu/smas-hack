# smas-hack

## Build

To be assembled using [Asar](https://github.com/RPGHacker/asar), see the Makefile.

## Global Features

- In-game save states for fxpak/sd2snes. Note that you should load the relevant game before loading a state
	- `R+Select` to save
	- `L+Select` to load
	
## SMB1 / Lost Levels Features

- HUD menu
	- `R+Start` to open menu
	- `left`/`right` to navigate through the options
	- `up`/`down` to edit the value. hold `Y` for larger increment/decrement steps
	- `B` to confirm
	- available options:
		- change powerup
		- change coin count
		- warp to any level
- press `L+R` to die instantly
- IGT frame counter display
- 21 frame rule excess display when beating levels

## SMB3 Features

- Infinite map item stock
	- press `X` or `Y` on the map to open the item menu
	- all 13 item types are available; using an item does not consume it
- press `L+R` to reset the level
	- restore the level-entry state, including powerup, lives, coins, score, timer and frame counter
	- restart from the beginning even after entering a subarea
	- also works while paused

## TODO

- add all the smb2j features to smb1 because it's really easy to do
