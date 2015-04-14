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
 
print("Please type in the address of your recipient: ")
local addr = io.read()
 
print("Please type in the port you wish to send this message along to: ")
local strport = io.read()
 
print("Now, please type the message you wish to transmit")
local message = io.read()
 
print("Finally, type the distance the message must cross (always be liberal when guessing distance): ")
local rangestr = io.read()
 
print("\n\nInformation added in, configuring message parameters...")
local portnum = tonumber(strport)
local rangenum = tonumber(rangestr)
 
print("Configured. Now setting ranges...")
m.setStrength(rangenum)
ap.setStrength(rangenum)
 
print("Ranges configured. Set to: "..rangenum)
print("Inputs compiled. Finalizing transmission...")
m.open(portnum)
 
if m.isOpen(portnum) then
 print("Data port is opened, proceeding with message transmission...")
 if  m.send(addr, portnum, message) then
  print("Message sent! Please ensure receipt of message!")
  return
 else
  print("Message not sent! Communications failure!")
  return
 end
else
 print("Communications failure! Unknown reason!")
end
