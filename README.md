# Wings Icon (CS2 Style) for CS:GO

This plugin replicates the "wings" (airborne) icon feature from CS2 in CS:GO's killfeed. Unlike other versions, this plugin does **not** replace the existing `noscope` icon for snipers, but instead adds a dedicated icon for airborne kills for all weapons.

## Features
- Adds a "wings" icon to the killfeed for kills made while jumping or falling.
- Works for every weapon type (rifles, pistols, knives, zeus).
- Does **NOT** trigger for utility (grenades).
- Does **NOT** overwrite the native `noscope` icon, allowing both to appear simultaneously for jumping no-scopes.

## Installation
1. Compile the `wings.sp` file using the SourceMod compiler (e.g., [spcomp](https://www.sourcemod.net/downloads.php)). (there is also a compiled version if you're to lazy hehe)
2. Upload the resulting `wings.smx` to your server's `addons/sourcemod/plugins/` directory.
3. Load the plugin: `sm plugins load wings`.

## Adding the Icons (Required)
Since CS:GO does not have a native "wings" slot, this plugin works by looking for a custom weapon icon. You must provide these icons in your server's resource files (FastDL).

### 1. The Icon Path
Place your custom `.svg` icons in the following directory on your server/FastDL:
`csgo/materials/panorama/images/icons/equipment/`

**Note:** The `materials/` prefix is mandatory for the game to download the files and for the Panorama engine to find them.

## FastDL Setup
For players to download the icons, you must sync your FastDL server:

1.  **Game Server Path**: 
    `/csgo/materials/panorama/images/icons/equipment/*.svg`
2.  **FastDL (Web Server) Path**: 
    Ensure the path on your web server matches exactly. If your `sv_downloadurl` is `http://yourfastdl.com/csgo/`, the file should be at:
    `http://yourfastdl.com/csgo/materials/panorama/images/icons/equipment/ak47_wings.svg`
3.  **Config**: Ensure these CVARs are set in your `server.cfg`:
    ```text
    sv_allowdownload 1
    sv_downloadurl "http://yourfastdl.com/csgo/"
    ```

### 2. Extracting from CS2
You can grab the original wings icon directly from CS2's files.
- **Location in CS2**: `game/csgo/panorama/images/icons/equipment/attacker_in_air.svg`
- **How to extract**: Use [Source 2 Viewer](https://valveresourceformat.github.io/) to open the `pak01_dir.vpk` file in your CS2 directory and search for `attacker_in_air.svg`.
- **Note**: For CS:GO, you'll need to combine this wings icon with each weapon's icon to create files like `ak47_wings.svg`.

### 3. Naming Convention
For every weapon you want to support, you need an icon named `{weapon}_wings.svg`. 
Examples:
- `ak47_wings.svg`
- `deagle_wings.svg`
- `knife_wings.svg`
- `awp_wings.svg`

**Tip:** These icons should be a combination of the original weapon icon and the CS2 wings icon.

### 3. Translation (Optional)
To prevent the game from showing `#ak47_wings` as the weapon name in the killfeed (for some languages), add the following to your `resource/csgo_english.txt` (and other languages):
```text
"SFUI_WPNHX_ak47_wings"    "AK-47"
"SFUI_WPNHX_deagle_wings"  "Desert Eagle"
... and so on for each weapon.
```

## Credits
Author: **v0tekick**  
Repository: [v0tekick/wingshx](https://github.com/v0tekick/wingshx)
