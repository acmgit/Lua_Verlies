#!/usr/bin/lua

dofile("data_game.lua")
dofile("data_player.lua")
dofile("lib.lua")

local d = dungeon
local lib = d.lib

lib.check_directions()

d.raw_dungeon, d.dim = d.lib.prepare_dungeon(d.dim)

lib.generate_dungeon(2,2,lib.get_direction())
lib.trim_dungeon()
lib.set_in()
lib.set_out()
--lib.set_rooms(1, lib.get_tile("room"), d.rooms)
--lib.set_rooms(1, lib.get_tile("hall"), d.halls)

for l = 1,d.dim.y do
    local line = ""
    for r = 1,d.dim.x do
        line = line .. d.raw_dungeon[l][r]
    end

    print(line)
end
