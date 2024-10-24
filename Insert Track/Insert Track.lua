function Foreign_OnCommand(cmd_name)
   cmd_id = reaper.NamedCommandLookup(cmd_name)
   reaper.Main_OnCommand(cmd_id, 0)
end

reaper.Main_OnCommand(40001, 0) -- Track: Insert new track
new_track = reaper.GetLastTouchedTrack()
parent = reaper.GetParentTrack(new_track)

if parent then
   -- SWS: Select only parent of selected track
   Foreign_OnCommand("_SWS_SELPARENTS")

   -- Script ICIO set color gradient to children tracks starting from parent color
   Foreign_OnCommand("_RSbf2bd246be433097ca27eb29844c243b636a3747")

   reaper.SetOnlyTrackSelected(new_track, false)
end
