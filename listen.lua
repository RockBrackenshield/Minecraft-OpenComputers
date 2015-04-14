local component = require("component")
local event = require("event")
 
if not component.isAvailable("access_point") then
 print("Access Point should be available to assist this program...")
 return
end
 
if not component.isAvailable("modem") then
 print("A modem (from a network/wireless network) card is necessary to use this program. Thanks!")
 return
end
local m = component.modem
local ap = component.access_point
 
if not m.isWireless() then
 print("This modem should be from a wireless network card. Please replace the network card with a wireless network card.")
 return
end
 
print("Please enter desired range for listening/relaying: ")
local strrange = io.read()
local range = tonumber(strrange)
 
ap.setStrength(range)
print("Listening/Relay range set to "..range)
print("Opening ports for listening (1-20)...")
 
local portnum = 20
 
while portnum>0 do
 m.open(portnum)
 portnum = portnum - 1
end
 
print("Confirming ports are open...")
local portscan = 20
 
while portscan>0 do
 if m.isOpen(portscan) then
  print("Port: "..portscan.." is ready.")
 else
  print("Issue with port: "..portscan..". This port is not open.")
 end
 portscan = portscan - 1
end
print("Ports have been opened. Awaiting message...")
 
local _, _, from, port, _, message = event.pull("modem_message")
print("Got a message from " .. from .. " on port " .. port .. ": " .. tostring(message))
