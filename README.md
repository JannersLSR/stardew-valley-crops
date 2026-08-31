# Stardew Valley Crops in Minecraft

This datapack adds a configurable chance for carrots and beetroots to grow into giant crops when harvested, similar to the ones in Stardew Valley. 

Inspired by Stardew Valleys Giant Crops, [tg13fire's post on the r/Minecraft Subreddit](https://www.reddit.com/r/Minecraft/comments/1vp86vz/carrot/), and [PhoenixSC's video](https://youtu.be/Mg09ZgU2Ng8?si=K57xKPFV8m6zH5wY&t=271).

## Features

- **Giant crop chance** — fully grown carrots and beetroot have a **10% chance** (configurable in-game) to turn into a giant crop instead of dropping normally.
- **Bumper harvest** — giant crops drop **5–14 carrots/beetroot** (vs the normal 1–4).
- **Resetting berry bush** — the bush automatically resets to age 1 to avoid berries growing on the giant crop.

## Requirements

| Requirement | Version |
|---|---|
| Minecraft | 26.3.X |
| Environment | Singleplayer world *or* server with datapacks enabled |

> The datapack uses `minecraft:cushion` entities (added in 26.3) and `minecraft:sweet_berry_bush` as the visual proxy for giant crops.

## Installation

1. Download **`stardew_valley_crops.zip`** (included in this repository).
2. Place it in your world's `datapacks/` folder:
   ```
   .minecraft/saves/<Your World>/datapacks/stardew_valley_crops.zip
   ```
3. In-game, run:
   ```
   /reload
   ```
   You should see **`[Stardew Valley Crops] Datapack loaded.`** in chat.

## Configuration

The giant crop chance is stored in a scoreboard and can be changed **live** without reloading:

```mcfunction
# Set chance to 25 %
scoreboard players set #config giant_chance 25

# Disable giant crops entirely
scoreboard players set #config giant_chance 0

# Always spawn a giant crop (100 %)
scoreboard players set #config giant_chance 100
```

The value is a whole-number percentage (0–100). Default: **10**.

## How It Works

The datapack runs four systems on every tick.

### System 1 — Planting Detection (`on_carrot_planted` / `on_beetroot_planted`)

Two separate advancements fire the moment a player places a crop — `stardew_valley_crops:carrot_planted` and `stardew_valley_crops:beetroot_planted` — each triggering its own function.

Because the advancement trigger runs *at the player's feet*, each function raycasts up to 4 blocks forward from the player's eyes (at ground level and +1 Y) looking for a freshly planted `carrots[age=0]` or `beetroots[age=0]` block. When found, a `minecraft:marker` tagged with both `crop_check` and either `crop_check_carrot` or `crop_check_beet` is summoned at that exact block. The advancement is immediately revoked so it can fire again on the next placement.

### System 2 — Growth & Transformation (`system2_growth`)

Runs every tick. For each `crop_check` marker:

1. **Dedup pass** — kills any duplicate markers within 0.5 blocks of each other (guards against edge cases where two raycasts tag the same block).
2. **Maturity check** — checks the block under each marker: `carrots[age=7]` for carrot markers, `beetroots[age=3]` for beetroot markers (beetroot's max age is 3, not 7). Rolls a random number 1–100 on maturity.
3. **Giant crop conversion** — if the roll is ≤ `#config giant_chance`, the crop block is replaced with `sweet_berry_bush[age=1]` and a `minecraft:cushion` entity is summoned 1/16 of a block below it — orange and tagged `crop_carrot` for carrots, red and tagged `crop_beet` for beetroots. Both also carry the `stardew_crop` tag.
4. **Marker cleanup** — the marker is killed once it has rolled *or* if the tracked block is no longer a carrot/beetroot (i.e. harvested normally before going giant).

### System 3 — Harvest Detection (`system3_harvest`)

Runs every tick. Watches every `stardew_crop` cushion:

- If the block **above** the cushion (where the bush sits) is `air`, the giant crop has been broken.
- **Giant carrot** — rolls 5–7 and spawns that many `minecraft:carrot` items at the centre of the block above.
- **Giant beetroot** — rolls 5–7 beetroots *and* separately rolls 1–4 `minecraft:beetroot_seeds`, dropping both.
- The cushion (and its passenger marker) are then killed, completing the cleanup.

> **Y-offset note:** the cushion is summoned at `y − 0.0625` (to not popoff, since farmland is 15/16 of a block). All Y-relative block checks in Systems 3 and 4 add `~1` to compensate.

### System 4 — Bush State Management (`system4_bush_state`)

Runs every tick. Prevents Minecraft's berry-bush growth from advancing the giant crop past `age=1`:

- If the bush above a `stardew_crop` cushion reaches `age=2` or `age=3`, it is immediately reset to `age=1`.

This keeps the bush non-harvestable.

## File Structure

```
stardew_valley_crops.zip
├── pack.mcmeta
└── data/
    ├── stardew_valley_crops/
    │   ├── advancement/
    │   │   ├── carrot_planted.json           # Fires on_carrot_planted when player places carrots
    │   │   └── beetroot_planted.json         # Fires on_beetroot_planted when player places beetroots
    │   └── function/
    │       ├── init.mcfunction               # Registers scoreboards; runs on load/reload
    │       ├── tick.mcfunction               # Entry point — calls systems 2, 3, 4 every tick
    │       ├── on_carrot_planted.mcfunction  # System 1: raycast & carrot marker placement
    │       ├── on_beetroot_planted.mcfunction# System 1: raycast & beetroot marker placement
    │       ├── system2_growth.mcfunction     # System 2: giant crop conversion (carrot + beetroot)
    │       ├── system3_harvest.mcfunction    # System 3: drop & cleanup on break
    │       └── system4_bush_state.mcfunction # System 4: keep bush at age=1
    └── minecraft/
        └── tags/function/
            ├── load.json                     # Calls stardew_valley_crops:init on load/reload
            └── tick.json                     # Calls stardew_valley_crops:tick every game tick
```

## Scoreboards

| Objective | Type | Purpose |
|---|---|---|
| `crop_roll` | `dummy` | Stores the random roll (1–100) for each `crop_check` marker |
| `giant_chance` | `dummy` | Config value — the % threshold for giant crop conversion |
| `harvest_count` | `dummy` | Stores the random crop drop count (5–7) per giant harvest |
| `seed_count` | `dummy` | Stores the random beetroot seed drop count (1–4) per giant beetroot harvest |

## Known Limitations

- **Carrots and beetroot support only** — these are the only crops that make sense to have giant versions of (at least for now).  
- **Raycasting range** — the planting detector scans up to 4 blocks forward. Crops placed further away (e.g. changing reach) may not be tracked.
- **Multiplayer** — the advancement fires per-player, so multiple players planting near each other simultaneously should be handled correctly, but has not been stress-tested.

Yes the giant beetroot looks like a tomato, *sorry*.

## License

Please credit me if you utilize this datapack in any public project.

Thanks for downloading this datapack! I hope you enjoy it.
