-- Load the 'impatient' plugin if it's available to speed up lua imports
pcall(function() require("impatient") end)

require("settings")
require("plugins")
require("keys")
