-- Checks and displays whether the connect Access Point is a Repeater, or is not a Repeater
local component = require("component")
local computer = require("computer")
 
if not component.isAvailable("access_point") then
 io.stderr:write("Can't see if the Access Point is a relay without an Access Point!")
 return
end
 
local component = require "component"
local ap = component.access_point
 
print("Checking if local access point is a Repeater...")
 
if ap.isRepeater() == true then
 print("Access Point is a Repeater!")
else
 print("Access Point is not a Repeater!")
end
