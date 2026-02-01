# SpellDensity
Sets the CVAR, spellVisualDensityFilterSetting, to 1 upon logging in or changing zones.

This WoW addon was inspired by several WeakAuras (RIP) which performed the same function.
Inidications are, this is currently fixed and no longer needed.  But I'm just going to put
this out there anyhow, as we know Blizzard loves to reintroduce old bugs.

In the spirit of keeping this addon simple and lightweight, there is no UI for customization.  
However, one can edit the values at the top of the SpellDensity.lua file, as illustrated below.

```
-- 1 - minimum, 2 - reduced, 3 - performance, 4 - full
local DEFAULT_spellVisualDensityFilterSetting = 1  
```

Coded with 100% **VIBE**
