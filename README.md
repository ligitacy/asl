# Autosplitter general information
These scripts are used when speedrunning various games, completing them as fast as possible. To keep the games competitive regardless of hardware, the scripts pause the timer during loads and automatically section the time into "splits" to compare against your previous attempts.

These ASL (autosplitter language) scripts are plugins for the popular timer LiveSplit.  They consist of pointer paths to necessary information inside a game's process.  The paths are followed and read by LiveSplit, and their data is returned to the plug-in and processed to determine whether the timer should be paused during loads or whether the timer should split now.  Paths are usually found with Cheat Engine and its pointer scan tool.  For Killer is Dead, I also decompiled the game using UE Explorer to find the necessary data.  In Fable, I took publicly known routine addresses and watched the register contents during those routines to find some of the data used.

# Killer is Dead Autosplitter and Load Remover by blastedt

Load removal is vaguely done.  The following are detected as loads:
* Full screen loads
* Episode intros
* Those animated cutscenes before episode intros, like the one before e6


The following are not:
* Streamed loads, like the freeze between Episode 3 and Alice
* Loads where the only indication is the blood spatter on the right side
* Anything not mentioned


Autosplitting is in natal stages.  The following splits are available:
* After every episode, as the ranking screen music begins.  Note that for episode 12 this is long after the end of timing.
* Auto start (including resetting if timer is running).  Note that the timing is off - auto start comes about 1.3 seconds after you press A on Very Hard

All splits are optional.  Apologies, but I do not plan to continue work on this script.





# Fable: TLC Autosplitter and Load Remover by blastedt

Load and autosave removal are available.  To prevent teleporter abuse that would be faster loadless but much slower real-time, the teleport animation is included in your time.

Autosplits are available, check the settings page.  If you want a new autosplit, let me know via the Skype or Discord groups.

Auto start and reset are available.

Loading a save is not detected.  If you start your run by loading a save, don't start your timer until the first autosave.

# CHANGELOG:

## Fable
### 1.1.0 (7/10/16):
* Auto-start
* Auto-reset
* Graveyard Path split
* Imprisoned! split
* Three souls splits
* Dragon Jack split

### 1.0.1 (4/29/16):
* Started timing the portaling animation.  As a side effect, the fade-in after a map load will now be timed.  Etem says this is 100% consistent, so it shouldn't matter.


## Killer is Dead
### 1.0.2 (6/19/16):
* Autostart, autoreset.
* (6/21/16): Fixed livesplit crash after episode 11


### 1.0.1 (6/19/16):
* Autosplit for episodes 1 through 11
