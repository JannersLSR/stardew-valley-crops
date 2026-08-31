execute as @e[type=minecraft:cushion,tag=crop_carrot] at @s if block ~ ~1 ~ minecraft:air store result score @s harvest_count run random value 5..7
execute as @e[type=minecraft:cushion,tag=crop_carrot,scores={harvest_count=5}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:carrot",count:5}}
execute as @e[type=minecraft:cushion,tag=crop_carrot,scores={harvest_count=6}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:carrot",count:6}}
execute as @e[type=minecraft:cushion,tag=crop_carrot,scores={harvest_count=7}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:carrot",count:7}}
execute as @e[type=minecraft:cushion,tag=crop_carrot,scores={harvest_count=5..7}] at @s run kill @e[type=minecraft:marker,distance=..0.1]
execute as @e[type=minecraft:cushion,tag=crop_carrot,scores={harvest_count=5..7}] run kill @s

execute as @e[type=minecraft:cushion,tag=crop_beet] at @s if block ~ ~1 ~ minecraft:air store result score @s harvest_count run random value 5..7
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={harvest_count=5..7}] at @s store result score @s seed_count run random value 1..4
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={harvest_count=5}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:beetroot",count:5}}
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={harvest_count=6}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:beetroot",count:6}}
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={harvest_count=7}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:beetroot",count:7}}
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={seed_count=1}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:beetroot_seeds",count:1}}
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={seed_count=2}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:beetroot_seeds",count:2}}
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={seed_count=3}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:beetroot_seeds",count:3}}
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={seed_count=4}] at @s align xyz positioned ~0.5 ~1.5 ~0.5 run summon item ~ ~ ~ {Item:{id:"minecraft:beetroot_seeds",count:4}}
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={harvest_count=5..7}] at @s run kill @e[type=minecraft:marker,distance=..0.1]
execute as @e[type=minecraft:cushion,tag=crop_beet,scores={harvest_count=5..7}] run kill @s
