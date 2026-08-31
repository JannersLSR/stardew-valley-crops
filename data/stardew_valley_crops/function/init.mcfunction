scoreboard objectives add crop_roll dummy
scoreboard objectives add giant_chance dummy
scoreboard objectives add harvest_count dummy
scoreboard objectives add seed_count dummy

# Default giant crop chance (percent). Change anytime with:
# /scoreboard players set #config giant_chance <0-100>
scoreboard players set #config giant_chance 10

tellraw @a {"text":"[Stardew Valley Crops] Datapack loaded.","color":"green"}
