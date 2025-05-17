function GetActionsWithShortcut()
   local i, t = 0, {}
   local section = 32060

   while true do
	  -- 0 - Main
	  -- 100 - Main (alt recording)
	  -- 32060 - MIDI Editor
	  -- 32061 - MIDI Event List Editor
	  -- 32062 - MIDI Inline Editor
	  -- 32063 - Media Explorer
	  local cmdID, cmdName = reaper.kbd_enumerateActions(section, i)
	  i = i + 1

	  if cmdID == 0 then
		 break
	  end

	  if reaper.CountActionShortcuts(section, cmdID) ~= 0 then
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
