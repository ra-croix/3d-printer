--croix's 3d printer version 0.1.0
    --code printed by notnotmelon
    --ideas by croix

--to be added:
    --lasers break items marked for deconstruction in range
        --returning nothing, or the original item if item wasn't printed
    --fix on_player_mined_entity
    --fix on_robot_mined_entity
    --lasers place non printable items if you have the item in your inventory
    --idk

local printable = {
    ['transport-belt'] = 1,
    ['fast-transport-belt'] = 3,
    ['express-transport-belt'] = 6,
    ['underground-belt'] = 1,
    ['fast-underground-belt'] = 3,
    ['express-underground-belt'] = 6,
    ['splitter'] = 1,
    ['fast-splitter'] = 3,
    ['express-splitter'] = 6,
    ['inserter'] = 1,
    ['long-handed-inserter'] = 1,
    ['fast-inserter'] = 3,
    ['stack-inserter'] = 6,
    ['assembling-machine-1'] = 1,
    ['assembling-machine-2'] = 3,
    ['assembling-machine-3'] = 6,
    ['medium-electric-pole'] = 3,
    ['big-electric-pole'] = 3,
    ['substation'] = 6,
    ['iron-chest'] = 1,
    ['steel-chest'] = 3,
    }

local fire_rate = 20

script.on_init(function()
    global.plastic_entities = {}
end)


script.on_nth_tick(fire_rate, function(event)
    for _, player in pairs(game.players) do
        local surface = player.surface
        local inventory = player.get_inventory(defines.inventory.character_armor)
        if inventory then
            local grid = inventory[1]
            if grid.valid_for_read then
                grid = grid.grid
                if grid and grid.get_contents()['3d-printer'] then
                    local entites = surface.find_entities_filtered{
                        area = {{player.position.x - 16, player.position.y - 16}, {player.position.x + 16, player.position.y + 16}},
                        type = {'entity-ghost', 'tile-ghost'}
                    }
                    local filtered_prints = {}
                    for i, entity in pairs(entites) do
                        --game.print('test')
                        if printable[entity.ghost_name] then
                            --game.print('test2')
                            filtered_prints[i] = entity

                        end
                    end
                    entites = filtered_prints
                    if next(entites) then
                        local entity = surface.get_closest(player.position, entites)
                        --game.print('pre if print')
                        if player.remove_item{name = 'filament', count = printable[entity.ghost_name]} == printable[entity.ghost_name] then
                            --game.print('remove item print')
                            surface.create_entity{ 
                                name = 'laser-beam',
                                position = player.position,
                                target_position = entity.position,
                                source = player.character,
                                duration = fire_rate
                            }
                            local _, revived_entity = entity.revive{raise_revive = true}
                            if revived_entity then
                                global.plastic_entities[revived_entity.unit_number] = revived_entity
                            end
                        else
                            break
                        end
                    end
                end
            end
        end
    end
end)

script.on_event(defines.event.on_player_mined_entity, function(event)
    if plastic_entities[entity.unit_number] then
        event.buffer.clear() 
        plastic_entities[entity.unit_number] = nil
    end
end)

script.on_event(defines.event.on_robot_mined_entity, function(event)
    if plastic_entities[entity.unit_number] then
        event.buffer.clear() 
        plastic_entities[entity.unit_number] = nil
    end
end)


