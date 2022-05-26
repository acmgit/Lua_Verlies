--[[
 *********************************************************
 **                       lib                           **
 **                                                     **
 **     lib for generating and editing dungeons         **
 **                                                     **
 *********************************************************
--]]

local d = dungeon
local lib = dungeon.lib

math.randomseed(os.time())

--[[
 *********************************************************
 **                prepare_dungeon()                    **
 **                                                     **
 ** Generates an empty Dungeon to carve a Maze.         **
 ** Changes the d.dim.x and d.dim.y to odd.             **
 **                                                     **
 *********************************************************
--]]
function lib.prepare_dungeon(dim)
    if((dim.x % 2) == 0) then dim.x = dim.x + 1 end                                      -- Correct to an odd row
    if((dim.y % 2) == 0) then dim.y = dim.y + 1 end                                      -- Correct to an odd line
    
    if (dim.x < 2) or (dim.y < 2) then
            print("Sensless Dimensions ...")
            os.exit()

    end

    local x = dim.x
    local y = dim.y
    local line = {}

    for l = 1,y do                                                                      -- Each line
        line[l] = {}                                                                    -- preare empty line

        for c = 1,x do                                                                  -- Each colum
            line[l][c] = lib.get_tile("wall")

        end -- rows

    end -- lines
    
    for l = 1,y do
        for c = 1,x do
            if((l % 2) == 0 and (c % 2) == 0) then
                line[l][c] = lib.get_tile("floor")

            end -- each 2.nd line and each 2.nd row

        end -- all rows
        
    end -- all lines

    dim.x = x
    dim.y = y

    
    return line, dim

end

function lib.get_tile(name)

    local tiles = { "#",  -- Wall
                    " ",  -- Floor 
                    "<",  -- Entry
                    ">",  -- Exit
                    "d",  -- Door
                    "r",  -- Room
                    "v",  -- Visited

                } 

    local tile =  { ["wall"] = tiles[1],
                    ["floor"] = tiles[2],
                    ["entry"] = tiles[3],
                    ["exit"] = tiles[4],
                    ["door"] = tiles[5],
                    ["room"] = tiles[6],
                    ["visited"] = tiles[7],

                  }

    return tile[name]

end

function lib.get_direction()
    local dir = (math.random(1,100) % d.directions)+1   
    return dir 

end

function lib.is_floor(line, column)
    local check = false

    if(lib.check_dimension(line,column)) then
        if(d.raw_dungeon[line][column] == lib.get_tile("floor")) then
            check = true        

        end

    end
    
    return check
    
end

function lib.load_dungeon(lines, dim)
    
    local dungeon = {}

    for y = 1, dim.y do
        for x = 1, dim.x do
            dungeon[y][x] = lines[y]:sub(x,x)

        end

    end

    return dungeon

end

function lib.check_directions()
    if(d.directions < 4) then
        d.directions = 4

    elseif(d.directions > 4) then
        d.directions = 1

    end

end

function lib.set_in()
    local line = 1
    local column = math.random(2,d.dim.x)

    while(not lib.is_floor(line+1, column)) do
        column = math.random(2,d.dim.x)
    
    end
    d.raw_dungeon[line][column] = lib.get_tile("entry")

end

function lib.set_out()
    line = d.dim.y
    column = math.random(2,d.dim.x)

    while(not lib.is_floor(line-1, column)) do
        column = math.random(2,d.dim.x)

    end
    d.raw_dungeon[line][column] = lib.get_tile("exit")

end

function lib.set_rooms()

end

function lib.check_dimension(line,column)
    
    local is_valid = false

    if (
        (line >= 2)  and (line < d.dim.y)
        and
        (column >= 2) and (column < d.dim.x)
        ) then

            is_valid = true

    end

    return is_valid

end

local find_way = {}

find_way[1] = function(l, c)
                if(lib.is_floor(l-2, c)) then
                    d.raw_dungeon[l-1][c] = lib.get_tile("floor")
                    lib.generate_dungeon(l-2, c)
                end
            end

find_way[2] = function(l, c)
                if(lib.is_floor(l, c+2)) then
                    d.raw_dungeon[l][c+1] = lib.get_tile("floor")
                    lib.generate_dungeon(l, c+2)
                end
            end
                        
find_way[3] = function(l, c)
                if(lib.is_floor(l+2, c)) then
                    d.raw_dungeon[l+1][c] = lib.get_tile("floor")
                    lib.generate_dungeon(l+2, c)
                end
            end            
        
find_way[4] = function(l, c)
                if(lib.is_floor(l, c-2)) then
                    d.raw_dungeon[l][c-1] = lib.get_tile("floor")
                    lib.generate_dungeon(l, c-2)
                end
            end

function lib.generate_dungeon(line, column)

    if(not lib.check_dimension(line, column)) then                                       -- Out of Range
        return                                                                           -- Do nothing

    end
    
    local dircount = 1
    dir = lib.get_direction()
    d.raw_dungeon[line][column] = lib.get_tile("visited")                            -- Mark as visited

    while(dircount <= 4) do
        find_way[dir](line, column)

        dir = dir + 1
        if( dir > 4) then
            dir = 1

        end
        dircount = dircount + 1

    end

end -- in Range?

function lib.trim_dungeon()
    for y = 1, d.dim.y do
        for x = 1, d.dim.x do
            if(d.raw_dungeon[y][x] == lib.get_tile("visited")) then
                d.raw_dungeon[y][x] = lib.get_tile("floor")

            end -- if(d.raw_dungeon

        end -- for x

    end -- for y
    
end -- lib.trim_dungeon
