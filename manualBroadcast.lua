local component = require("component")
local computer = require("computer")
 
if not component.isAvailable("modem") then
 io.stderr:write("A modem is required to use this program, preferably from a wireless network card.")
 return
end
 
local m = component.modem
 
print("Please input on which port you would like to broadcast: ")
local portstr = io.read()
print("Now, please input the message you would like to send: ")
local msg = io.read()
 
print("Reading input, preparing message...")
local portnum = tonumber(portstr)
 
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
