if script.active_mods['coverage'] then require('__coverage__/coverage.lua') end
if script.active_mods['debugadapter'] then require('__debugadapter__/debugadapter.lua') end

local crc32 = require "crc32"

local function recipe_id(recipe)
  local id = crc32.Hash(recipe)
  if id > 2147483647 then
    id = id - 4294967295
  end
  return id
end


local function reindex_recipes()
  local recipemap={}

  for recipe,_ in pairs(game.forces['player'].recipes) do
    local id = recipe_id(recipe)
    recipemap[recipe] = id
    recipemap[id] = recipe
  end

  game.write_file('recipemap.txt',serpent.block(recipemap,{comment=false}))
  global.recipemap = recipemap
end

script.on_init(function()
  -- Index recipes for new install
  reindex_recipes()
end
)

script.on_configuration_changed(function(data)
  -- when any mods change, reindex recipes
  reindex_recipes()
end
)

remote.add_interface('recipeid',
{
  -- request teh whole map
  get_recipemap = function() return global.recipemap end,
  -- or just map one thing
  map_recipe = function(recipe) return global.recipemap[recipe] end,

  -- force a reindex
  reindex = reindex_recipes,
})
