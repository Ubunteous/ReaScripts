function insertFXOnTrack(track, FX)
   result = reaper.TrackFX_AddByName(track, FX, false, -1)

   if result == -1 then
	  reaper.ShowConsoleMsg("Plugin " .. FX .. " not installed. Could not be inserted on track")
   end
end

function insertFX(FX)
   -- Insert a plugin in the last track selected (or a new Onega)
   reaper.Undo_BeginBlock()

   nb_selected_tracks = reaper.CountSelectedTracks(0)

   if nb_selected_tracks > 0 then
      -- only insert on last track among selected
      -- track = reaper.GetSelectedTrack(0, nb_selected_tracks - 1)

      -- insert on every track selected
      for nth_track = 0, nb_selected_tracks - 1 do
		 track = reaper.GetSelectedTrack(0, nth_track)
		 insertFXOnTrack(track, FX)
      end
      return 0
   else
      track = reaper.GetLastTouchedTrack()
   end
   
   if not track then
      nb_tracks = reaper.CountTracks(0)
      reaper.InsertTrackAtIndex(nb_tracks, false)
      track = reaper.GetTrack(0, nb_tracks)
   end

   msg("Track: " .. track)
   -- example: "CLAP:Hive"
   -- insertFXOnTrack(track, FX)
   
   reaper.Undo_EndBlock("Script: Instantiate " .. FX, 0)
end

function GetFileName()
   local source = debug.getinfo(2, "S").source
   source = source:match("[^/]*.lua$")
   return source:sub(13, #source - 4)
end

-- USE THIS SCRIPT BY CREATING A NEW FILE IN THE SAME DIR WITH THIS CONTENT:
-- local ScriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
-- dofile(ScriptPath .. 'Instantiate FX.lua')
-- instantiateFX("CLAP:Hive")
