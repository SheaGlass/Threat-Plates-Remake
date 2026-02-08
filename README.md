# ThreatPlates Remake

A custom WoW nameplate addon inspired by ThreatPlates, built for WoW Midnight / The War Within (11.x).

## Features

- **Custom Health Bars** - Configurable width, height, texture, class coloring, reaction coloring, absorb shields, and multiple health text formats (%, current, deficit, etc.)
- **Aura/Debuff Tracking** - Shows your debuffs (and optionally buffs) on nameplates with cooldown spirals, duration text, stack counts, and debuff-type colored borders. Supports whitelist/blacklist filtering.
- **Cast Bar** - Custom cast bar with spell icon, spell name, cast timer, interruptible/uninterruptible indicators with shield icon and color coding.
- **Threat Coloring** - Color-coded nameplates and threat glow based on your threat status. Auto-detects tank vs DPS/healer role and inverts colors accordingly.
- **Target Highlight** - Border glow, scale increase, target arrow, and non-target alpha dimming for your current target.
- **Full AceConfig GUI** - All settings configurable via `/tpr` or the minimap button. Includes profile management for per-character or shared configs.

## Installation

1. **Download required libraries** into the `Libs/` folder:
   - [Ace3](https://www.curseforge.com/wow/addons/ace3) (AceAddon, AceDB, AceDBOptions, AceConfig, AceConfigDialog, AceConfigRegistry, AceConfigCmd, AceConsole, AceEvent, AceTimer)
   - [CallbackHandler-1.0](https://www.curseforge.com/wow/addons/callbackhandler)
   - [LibSharedMedia-3.0](https://www.curseforge.com/wow/addons/libsharedmedia-3-0)
   - [LibDataBroker-1.1](https://www.curseforge.com/wow/addons/libdatabroker-1-1)
   - [LibDBIcon-1.0](https://www.curseforge.com/wow/addons/libdbicon-1-0)

2. Copy the entire `ThreatPlatesRemake` folder to:
   ```
   World of Warcraft/_retail_/Interface/AddOns/ThreatPlatesRemake/
   ```

3. Restart WoW or `/reload`

## Slash Commands

| Command | Action |
|---------|--------|
| `/tpr` | Open config panel |
| `/threatplates` | Open config panel |
| `/tpr reset` | Reset current profile to defaults |

## Configuration

Open the config with `/tpr`. Tabs available:

- **General** - Nameplate range, stacking behavior
- **Health Bar** - Size, texture, colors, text format, scaling
- **Cast Bar** - Enable/disable, size, colors, icon, timer
- **Auras** - Enable/disable, debuffs/buffs, filtering, icon size, cooldown spirals
- **Threat** - Enable/disable, DPS/healer colors, glow settings
- **Target Highlight** - Border color, scale, non-target alpha
- **Profiles** - Per-character or shared profile management

## Custom Textures

Place `.tga` or `.blp` textures in `Media/Textures/` and reference them in the database defaults or via LibSharedMedia.

## Extending

The addon uses a modular architecture. Each feature lives in its own file under `Modules/`. To add new modules:

1. Create `Modules/YourModule.lua`
2. Add it to `ThreatPlatesRemake.toc`
3. Access the addon via `local ADDON_NAME, TPR = ...` and `TPR.Addon`

## Known Limitations

- Textures reference paths that may need custom `.tga`/`.blp` files created
- The `pointed_glow` texture for threat glow needs to be created or replaced with an existing texture path
- Whitelist/blacklist aura editing requires manual table entries for now (GUI spell picker planned)

## Roadmap

- [ ] Spell picker GUI for aura whitelist/blacklist
- [ ] Combo point display
- [ ] Totem/pet special plate styling
- [ ] LibSharedMedia texture/font dropdown in config
- [ ] Import/export profiles
- [ ] Nameplate click-through toggle
