function GetActionsWithShortcut()
   local i, t = 0, {}

   while true do
	  local cmdID, cmdName = reaper.kbd_enumerateActions(0, i)
	  i = i + 1

	  if cmdID == 0 then
		 break
	  end

	  if reaper.CountActionShortcuts(0, cmdID) ~= 0 then
		 t[#t+1] = string.format("%i) %s [ID: %s]", i, cmdName, cmdID)
	  end
   end
   return t
end

function DumpToFile(data)
   local file = io.open("/home/ubunteous/Desktop/output.txt", "w")

   if file then
	  file:write(table.concat(data, "\n"))
	  file:close()
	  reaper.ShowConsoleMsg("File written.")
   else
	  reaper.ShowConsoleMsg("Failed to open file.")
   end
end

DumpToFile(GetActionsWithShortcut())
