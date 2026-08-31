execute as @e[type=minecraft:marker,tag=crop_check] at @s run kill @e[type=minecraft:marker,tag=crop_check,distance=0.01..0.5]

execute as @e[type=minecraft:marker,tag=crop_check_carrot] at @s if block ~ ~ ~ minecraft:carrots[age=7] store result score @s crop_roll run random value 1..100
execute as @e[type=minecraft:marker,tag=crop_check_carrot] at @s if score @s crop_roll <= #config giant_chance run setblock ~ ~ ~ minecraft:sweet_berry_bush[age=1]
execute as @e[type=minecraft:marker,tag=crop_check_carrot] at @s if score @s crop_roll <= #config giant_chance unless entity @e[type=minecraft:cushion,distance=..0.1] run summon minecraft:cushion ~ ~-0.0625 ~ {color:"orange",Invulnerable:1b,Silent:1b,Tags:["stardew_crop","crop_carrot"],Passengers:[{id:"minecraft:marker"}]}
execute as @e[type=minecraft:marker,tag=crop_check_carrot] at @s if score @s crop_roll matches 1..100 run kill @s
execute as @e[type=minecraft:marker,tag=crop_check_carrot] at @s unless block ~ ~ ~ minecraft:carrots run kill @s

execute as @e[type=minecraft:marker,tag=crop_check_beet] at @s if block ~ ~ ~ minecraft:beetroots[age=3] store result score @s crop_roll run random value 1..100
execute as @e[type=minecraft:marker,tag=crop_check_beet] at @s if score @s crop_roll <= #config giant_chance run setblock ~ ~ ~ minecraft:sweet_berry_bush[age=1]
execute as @e[type=minecraft:marker,tag=crop_check_beet] at @s if score @s crop_roll <= #config giant_chance unless entity @e[type=minecraft:cushion,distance=..0.1] run summon minecraft:cushion ~ ~-0.0625 ~ {color:"red",Invulnerable:1b,Silent:1b,Tags:["stardew_crop","crop_beet"],Passengers:[{id:"minecraft:marker"}]}
execute as @e[type=minecraft:marker,tag=crop_check_beet] at @s if score @s crop_roll matches 1..100 run kill @s
execute as @e[type=minecraft:marker,tag=crop_check_beet] at @s unless block ~ ~ ~ minecraft:beetroots run kill @s
