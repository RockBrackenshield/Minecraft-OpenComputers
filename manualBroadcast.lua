local component = require("component")
local computer = require("computer")
 
if not component.isAvailable("modem") then
 io.stderr:write("A modem is required to use this program, preferably from a wireless network card.")
 return
end
if not component.isAvailable("access_point") then
 io.stderr:write("An access point is required to use this program. It allows for great wireless transmissions")
 return
end
 
local ap = component.access_point
local m = component.modem
 
if not m.isWireless() then
 print("Sorry, this program only really does anything useful if you have a wireless network card installed")
 return
end
 
print("Please input on which port you would like to broadcast (number): ")
local portstr = io.read()
print("Now, please input the message you would like to send (string): ")
local msg = io.read()
print("Lastly, how far would you like this broadcast to go? (number): ")
local strrange = io.read()
 
print("Reading input, preparing message...")
local portnum = tonumber(portstr)
print("Message prepared, setting desired broadcast range...")
local range = tonumber(strrange)
m.setStrength(range)
ap.setStrength(range)
print("Range set to: " .. range)
 
print("Input read, checking port status...")
 
if m.isOpen(portnum) then
 print("Port is opened, proceeding with broadcast...")
 if m.broadcast(portnum, msg) then
  print("Message successfully sent!")
  return
 else
  print("Message not sent! Unknown reason!")
  return
 end
else
 m.open(portnum)
 print("Port has been manually opened, proceeding with broadcast...")
 if m.broadcast(portnum, msg) then
  print("Message successfully sent!")
  return
 else
  print("Message not sent! Unknown reason!")
  return
 end
end
