local computer = require("computer")
local component = require("component")
local serial = require("serialization")

if not component.isAvailable("modem") then
 io.stderr:write("A modem is required to use this program. Try a Wireless Network Card")
 return
end

local m = component.modem

if not m.isWireless() then
 print("Sorry, this program only does anything useful if you have a wireless network card installed")
 return
end

print("Please type in the address of your recipient: ")
local addr = io.read()

print("Please type in the port you wish to transmit this message on: ")
 local strport = io.read()

print("Please type in the message you wish to transmit now: ")
 local message = io.read()

print("Finally, type the distance you wish to transmit...")
 local rangestr = io.read()

print("Inputs received. Compiling packet now...")
 local portnum = tonumber(strport)
 local rangenum = tonumber(rangestr)
 local serialmsg = serial.serialize(message)

print("Message packet compiled, configuring modem now...")
 m.setStrength(rangenum)

print("Modem configured. Set to: "..rangenum)
print("Finalizing port configuration...")
m.open(portnum)

if m.isOpen(portnum) then
 print("Data port is opened. Beginning transmission...")
  if m.send(addr, portnum, serialmsg) then
   print("Transmission complete! Please ensure receipt of message.")
   return
 else
  print("Tansmission failed! Unknown error!")
  return
 end
 else
 print("Communications systems failure. Reason unknown!")
end
