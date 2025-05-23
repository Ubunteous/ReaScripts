--------------------
-- [[ FUNCTION ]] --
--------------------

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

function get_last_child_in_folder(folder_track)
   local folder_track_number = reaper.GetMediaTrackInfo_Value(folder_track, 'IP_TRACKNUMBER')

   local last_child = reaper.GetTrack(0, folder_track_number)
   for nth_track = folder_track_number, reaper.CountTracks(0) - 1 do
      child_track = reaper.GetTrack(0, nth_track)

      parent_track = reaper.GetParentTrack(child_track)
      if parent_track == folder_track then
	 last_child = reaper.GetTrack(0, nth_track)
      elseif parent_track and reaper.GetParentTrack(parent_track) == folder_track then
	 -- continue
      else
	 break
      end
   end

   if last_child and reaper.GetMediaTrackInfo_Value(last_child, "I_FOLDERDEPTH") == 1 then
      get_last_child_in_folder(last_child)
   end

   reaper.SetOnlyTrackSelected(last_child, false)
   return reaper.GetMediaTrackInfo_Value(last_child, 'IP_TRACKNUMBER')
end

----------------
-- [[ CODE ]] --
----------------

reaper.Undo_BeginBlock()

nb_selected_tracks = reaper.CountSelectedTracks(0)
if nb_selected_tracks > 0 then
   last_track_in_selection = reaper.GetSelectedTrack(0, nb_selected_tracks - 1)

   local folder_depth = reaper.GetMediaTrackInfo_Value(last_track_in_selection, "I_FOLDERDEPTH")
   local folder_track_number = reaper.GetMediaTrackInfo_Value(last_track_in_selection, 'IP_TRACKNUMBER')
   if folder_depth == 1 and folder_track_number ~= reaper.GetNumTracks() then
      -- insert at folder bottom if folder selected
      last_child_idx = get_last_child_in_folder(last_track_in_selection)
      reaper.Main_OnCommand(40001, 0) -- Track: Insert new track
      reaper.ReorderSelectedTracks(last_child_idx, 2)
   else
      -- or insert after selection
      reaper.Main_OnCommand(40001, 0) -- Track: Insert new track
   end

   -- update folder colour if necessary
   new_track = reaper.GetLastTouchedTrack()
   new_track_has_parent = reaper.GetTrackDepth(new_track) == 1 -- reaper.GetParentTrack(new_track) and true
   if new_track_has_parent then update_folder_color(new_track) end
else
   -- or insert at the very end and select last track if nothing is selected
   reaper.Main_OnCommand(40702, 0)
end

-- Foreign_OnCommand("_XENAKIOS_RENAMETRAXDLG") -- Rename selected track

reaper.Undo_EndBlock("Script: Track Inserted", 0)
