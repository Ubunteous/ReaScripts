--------------------
-- [ VARIABLES ] --
--------------------

complexity = "Uhbik"
-- complexity = "Single"
-- complexity = "Simple"
-- complexity_tri = "Mid"
-- complexity = "Complex"

--------------------
-- [ FUNCTIONS ] --
--------------------

function msg(m)
   reaper.ShowConsoleMsg(tostring(m))
end

function get_track_name(track)
   local _, track_name = reaper.GetTrackName(track)
   return track_name
end

-- keep only one track
function select_single_track()
   nb_tracks =  reaper.CountSelectedTracks2(0, true)

   if nb_tracks == 0 then
	  if reaper.GetNumTracks() == 0 then
		 reaper.InsertTrackAtIndex(0, false)
	  end

	  local track = reaper.GetLastTouchedTrack()
	  
	  reaper.SetOnlyTrackSelected(track)
	  return track
   elseif nb_tracks == 1 then
	  return reaper.GetSelectedTrack2(0, 0, true)
   else
	  local track = reaper.GetLastTouchedTrack()
	  reaper.SetOnlyTrackSelected(track)
	  return track
   end
end

function is_master(track)
   -- local _, track_name = reaper.GetTrackName(track)
   -- return track_name == "MASTER"
   return reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER") == -1
end

function has_child(track)
   nb_tracks = reaper.GetNumTracks()
   local track_index = reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")

   if track_index == nb_tracks or is_master(track) then
	  return false
   end

   next_track = reaper.GetTrack(0, track_index)

   if reaper.GetTrackDepth(track) + 1 == reaper.GetTrackDepth(next_track) then
	  return true
   end

   return false
end

function is_buss(track)
   if is_master(track) then
	  return true
   end

   return reaper.GetTrackDepth(track) == 0 and has_child(track)
end


function Translate_Complexity(complexity, insertion_type)
   -- Generators
   if insertion_type == "Generator" and (complexity == "Single" or complexity == "Uhbik") then
	  return "Simple"
   end

   if insertion_type == "FX" and complexity == "Mid" then
	  return "Simple"
   end

   return complexity
end

function ShowLastTrackFX(track)
   reaper.TrackFX_Show(track, reaper.TrackFX_GetCount(track), 1)
end
