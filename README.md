# Wings Icon (CS2 Style) for CS:GO

This plugin replicates the "wings" (airborne) icon feature from CS2 in CS:GO's killfeed.

## Features
- Displays the airborne icon (using the `noscope` flag) for kills made while in the air.
- Works for every weapon type except utility (grenades).
- Compatible with custom HUDs that replace the `noscope` icon with the CS2 wings icon.

## Installation
1. Compile the `wings.sp` file using the SourceMod compiler (e.g., [spcomp](https://www.sourcemod.net/downloads.php)).
2. Upload the resulting `wings.smx` to your server's `addons/sourcemod/plugins/` directory.
3. Load the plugin by restarting the server or using the console command `sm plugins load wings`.

## Technical Note
In CS:GO, this plugin uses the `noscope` flag to trigger an extra icon in the killfeed. To see a true pair of "wings" as in CS2, your server should use a custom panorama HUD or icon replacement that changes the default `noscope` icon to a "wings" icon.

## Credits
Author: **v0tekick**  
Repository: [v0tekick/wingshx](https://github.com/v0tekick/wingshx)
