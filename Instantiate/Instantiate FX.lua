function instantiateFX(FX)
   -- Insert a plugin in the last track selected
   -- Create a new track if necessary
   
   -- get the last touched track
   -- track = reaper.GetLastTouchedTrack()

   -- get the last track among currently selected
   nb_selected_tracks = reaper.CountSelectedTracks(0)
   track = reaper.GetSelectedTrack(0, nb_selected_tracks - 1)

   if not track then
      nb_tracks = reaper.CountTracks(0)
      reaper.InsertTrackAtIndex(nb_tracks, false)
      track = reaper.GetTrack(0, nb_tracks)
   end

   reaper.TrackFX_AddByName(track, FX, false, -1) -- example: "CLAP:Hive"
end
