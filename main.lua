#!/usr/bin/lua

dungeon = {}
dungeon.lib = {}                                                                         -- Helpfunctions for the Game
dungeon.raw_dungeon = {}                                                                 -- Raw Dungeon to edit
dungeon.map = {}                                                                         -- Finished Dungeons
dungeon.directions = 4                                                                   -- Supported Directions
dungeon.room = {}                                                                        -- Coord. of Rooms (with chest)
dungeon.hall = {}                                                                        -- Coord. of Rooms (w/o chest)
dungeon.hall_name = {}                                                                   -- Name of the Hall
dungeon.rooms = 5                                                                        -- Rooms per Level (with chest)
dungeon.halls = 5                                                                        -- Halls per Level (w/o chest)

dofile("data.lua")
dofile("lib.lua")

local d = dungeon
local lib = d.lib

lib.check_directions()

d.dim = { x = 50, y = 50 }                                                               -- Dimenstion of the Dungeon                                                                           

d.raw_dungeon, d.dim = d.lib.prepare_dungeon(d.dim)

lib.generate_dungeon(2,2,lib.get_direction())
lib.trim_dungeon()
lib.set_in()
lib.set_out()

for l = 1,d.dim.y do
    local line = ""
    for r = 1,d.dim.x do
        line = line .. d.raw_dungeon[l][r]
    end

    print(line)
end
