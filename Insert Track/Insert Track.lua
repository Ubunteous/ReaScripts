function Foreign_OnCommand(cmd_name)
   cmd_id = reaper.NamedCommandLookup(cmd_name)
   reaper.Main_OnCommand(cmd_id, 0)
end

function update_folder_color(new_track)   
   -- SWS: Select only parent of selected track
   Foreign_OnCommand("_SWS_SELPARENTS")

   -- Script ICIO set color gradient to children tracks starting from parent color
   Foreign_OnCommand("_RSbf2bd246be433097ca27eb29844c243b636a3747")

   reaper.SetOnlyTrackSelected(new_track, false)
end

reaper.Undo_BeginBlock()

nb_selected_tracks = reaper.CountSelectedTracks(0)
if nb_selected_tracks > 0 then
   last_track = reaper.GetSelectedTrack(0, nb_selected_tracks - 1)
   reaper.Main_OnCommand(40001, 0) -- Track: Insert new track
else
   reaper.InsertTrackAtIndex(reaper.GetNumTracks(), false)
end

-- update folder colour if necessary
new_track = reaper.GetLastTouchedTrack()
new_track_has_parent = reaper.GetTrackDepth(new_track) > 0 -- reaper.GetParentTrack(new_track) and true
if new_track_has_parent then update_folder_color(new_track) end

reaper.Undo_EndBlock("Script: Track Inserted", 0)
