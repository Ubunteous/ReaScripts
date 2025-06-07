function msg(str) reaper.ShowConsoleMsg(str) end

function GetCurrentOverride()
   for i = 24803, 24818 do
	  if reaper.GetToggleCommandState(i) == 1 then
		 return i - 24802
	  end
   end

   return 0 -- default/clear
end

function ExecuteCommand(command)
   local handle = io.popen(command)
   local result = handle:read("*a")
   handle:close()
   return result
end

function ShowOverrideBindings(override_num)
   local command = "awk '$5 == " .. override_num ..
	  ' {printf "+ ", $0; for(i=7;i<=NF;i++) printf "%s%s", $i, (i<NF ? OFS : ""); print ""} \' '
	  .. reaper.GetResourcePath() .. '/reaper-kb.ini  | sort'
   
   local output = ExecuteCommand(command)

   if (output == nil or output == "") then
	  msg("Error. No match in reaper-kb.ini for:\n" .. command)
   end

   msg(output)
end

ShowOverrideBindings(GetCurrentOverride())
