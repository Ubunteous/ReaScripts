if not reaper.HasExtState("mine", "unsel_track_visibility") then
   reaper.SetExtState("mine", "unsel_track_visibility", "true", false)
end

function Foreign_OnCommand(cmd_name)
   local cmd_id = reaper.NamedCommandLookup(cmd_name)
   reaper.Main_OnCommand(cmd_id, 0)
end

function main()
   -- either hide unselected tracks or show all
   toggle = reaper.GetExtState("mine", "unsel_track_visibility") == "true"
   
   if toggle then
      if reaper.CountSelectedTracks(0) == 0 then
	 return 0
      end
      
      -- SWS: Show selected track(s), hide others
      Foreign_OnCommand("_SWSTL_SHOWEX")      

   elseif not toggle then      
      -- SWS: Show all tracks
      Foreign_OnCommand("_SWSTL_SHOWALL")
   end
   
   toggle = tostring(not toggle)
   reaper.SetExtState("mine", "unsel_track_visibility", toggle, false)
end

main()
