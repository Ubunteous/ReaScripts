function instantiateFX(FX)
   -- Insert a plugin in the last track selected (or a new Onega)

   nb_selected_tracks = reaper.CountSelectedTracks(0)

   if nb_selected_tracks > 0 then
      -- only insert on last track among selected
      -- track = reaper.GetSelectedTrack(0, nb_selected_tracks - 1)

      -- insert on every track selected
      for nth_track = 0, nb_selected_tracks - 1 do
	 track = reaper.GetSelectedTrack(0, nth_track)
	 reaper.TrackFX_AddByName(track, FX, false, -1)
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

   reaper.TrackFX_AddByName(track, FX, false, -1) -- example: "CLAP:Hive"
end
