local component = require("component")
local event = require("event")
local serial = require("serialization")

if not component.isAvailable("modem") then
 print("A modem from a  network card is necessary to use this program.")
 return
end

local m = component.modem

if not m.isWireless() then
 print("This modem should be from a wireless network card. Please replace the network card with a wireless network card.")
 return
end

print("Please enter desired range for listening: ")
local strrange = io.read()
local range = tonumber(strrange)
m.setStrength(range)
print("Listening range set to "..range)
print("Opening several ports to listen in on...")

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

local _,_, from, port, _, message = event.pull("modem_message")
print("Got a message from" ..from.. " on port" ..port..". Parsing message data now...")
local messagestr = serial.unserialize(message)
print("Message parsed. Displaying results now: ")
print(messagestr)
