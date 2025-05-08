if not reaper.HasExtState("mine", "unsel_folder_visibility") then
   reaper.SetExtState("mine", "unsel_folder_visibility", "true", false)
end

function Foreign_OnCommand(cmd_name)
   local cmd_id = reaper.NamedCommandLookup(cmd_name)
   reaper.Main_OnCommand(cmd_id, 0)
end

function main()
   -- toggle to only show selected tracks/full folder or show all
   toggle = reaper.GetExtState("mine", "unsel_folder_visibility") == "true"

   if toggle == true then
      if reaper.CountSelectedTracks(0) == 0 then
	 return 0
      end

      -- SWS: Select children of selected folder track(s)
      Foreign_OnCommand("_SWS_SELCHILDREN2")

      -- SWS: Show selected track(s), hide others
      Foreign_OnCommand("_SWSTL_SHOWEX")

      -- SWS: Unselect children of selected folder track(s)
      Foreign_OnCommand("_SWS_UNSELCHILDREN")

   elseif not toggle then
      -- SWS: Show all tracks
      Foreign_OnCommand("_SWSTL_SHOWALL")
   end

   toggle = tostring(not toggle)
   reaper.SetExtState("mine", "unsel_folder_visibility", toggle, false)
end

main()
