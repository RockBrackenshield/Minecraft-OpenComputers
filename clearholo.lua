-- Clears the displayed hologram from the connected Hologram Projector
local component = require("component")
local computer = require("computer")
 
local holo = component.hologram
 
if not component.isAvailable("hologram") then
 io.stderr:write("Error: This program requires a hologram projector to run.")
 return
end
 
print("Clearing hologram... ")
holo.clear()
print("Success! Hologram cleared, it is ready for use!")
