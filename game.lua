Game = Object:extend()

function Game:new()
    character = Character(50, 400)
    -- create a table for collision check
    objects = {}
    table.insert(objects, box)
    table.insert(objects, character)
    -- create a table for all the enemys 
    enemys = {}
    -- create en extra table for the walltiles to not check the collision with each other
    tiles = {}
    map = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,1},
        {1,4,0,0,0,0,0,0,0,0,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
        {1,2,2,3,0,0,0,3,0,0,1,1,0,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,1},
        {1,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,0,0,3,0,0,0,0,0,0,0,1},
        {1,2,2,2,2,2,2,2,2,2,1,1,0,0,0,0,0,1,0,1,1,0,0,0,0,0,1,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,1,1,2,2,2,2,2,2,0,1,1,1,1,1,1,1,1,0,0,2,2,1},
        {1,0,0,0,0,0,0,2,2,2,1,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,2,2,2,1,1,0,0,0,0,0,0,0,1,1,2,2,0,0,0,0,0,0,2,2,1},
        {1,0,0,0,0,0,0,0,0,0,1,1,0,0,5,0,0,0,0,1,1,0,0,5,0,0,0,0,0,0,0,1},
        {1,2,2,2,0,0,0,0,0,0,1,1,0,2,2,2,0,0,0,1,1,2,2,2,2,0,0,0,0,0,0,1},
        {1,0,3,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,2,2,2,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1},
        {1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,1,1,1},
        {1,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1},
        {1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1},
        {1,0,0,0,0,0,1,1,3,0,0,0,0,1,1,1,0,3,0,0,0,0,0,0,1,1,1,1,1,1,1,1},
        {1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1},
        {1,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0}
    }
    for i, v in ipairs(map) do
        for j,w in ipairs(v) do
            if w == 1 then
                table.insert(tiles, Tiles((j-1)*25, (i-1)*25))
            elseif w == 2 then
                table.insert(tiles, Cloud((j-1)*25, (i-1)*25))
            elseif w == 3 then
                table.insert(enemys, Enemy((j-1)*25, (i-1)*25))
            elseif w == 4 then
                table.insert(tiles, Portal((j-1)*25, (i-1)*25))
            elseif w == 5 then 
                table.insert(objects, Box((j-1)*25, (i-1)*25))
            end
        end
    end
end

function Game:update(dt)
    --update all objects in the list
    for i,v in ipairs(objects) do
        v:update(dt)
    end
    -- update the walltiles of the game
    for i,v in ipairs(tiles) do
        v:update(dt)
    end
    -- update the enemys of the game
    for i,v in ipairs(enemys) do
        v:update(dt)
    end
    local loop = true
    local limit = 0
    while loop do
        loop = false
        limit = limit + 1
        if limit > 100 then
            break
        end
        -- go through all objects except the last
        for i=1,#objects-1 do
            -- go through all objects again starting from the second 
            for j=i+1,#objects do
                local collision = objects[i]:resolveCollision(objects[j])
                if collision then
                    loop = true
                end
            end
        end
        -- resolve Collision with tiles and clouds
        for i,tile in ipairs(tiles) do
            for j,object in ipairs(objects) do
                local collision = object:resolveCollision(tile)
                if collision then
                    loop = true
                end
            end
        end
        -- resolve collision between enemys and tiles
        for i,tile in ipairs(tiles) do
            for j,enemy in ipairs(enemys) do
                local collision = enemy:resolveCollision(tile)
                if collision then
                    loop = true
                end
            end
        end
        -- resolve collision with objects
        for i,object in ipairs(objects) do
            for j,enemy in ipairs(enemys) do
                local collision = enemy:resolveCollision(object)
                if collision then
                    loop = true
                end
            end
        end
    end
end

function Game:draw()
    -- loop over each object and draw them
    for i,v in ipairs(tiles) do
        v:draw()
    end
    for i,v in ipairs(enemys) do
        v:draw()
    end
    for i,v in ipairs(objects) do
        v:draw()
    end
    love.graphics.print("Lives:"..liveCount, love.graphics.getWidth()-75, love.graphics.getHeight()-50)
    love.graphics.print("R for restart", love.graphics.getWidth()- 85, love.graphics.getHeight()-25)
end