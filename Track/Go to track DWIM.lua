function msg(str) reaper.ShowConsoleMsg(tostring(str)) end

function getPanelType()
   -- View: Toggle mixer visible
   if reaper.GetToggleCommandState(40078) == 1 then
	  return "B_SHOWINMIXER"
   else
	  return "B_SHOWINTCP"
   end
end

function checkIfMotionPossible(nbTracks, current_track, currentPanel)
   if nbTracks == 0 then
	  return false
   end

   if current_track == nil then
	  return false -- do something smarter later
   end

   if reaper.GetMediaTrackInfo_Value(current_track, currentPanel) == 0 then
	  msg("Can't move from invisible track")
	  return false
   end

   return true
end

function selectLastTrack(nbTracks)
   if nbTracks ~= 0 then
	  reaper.SetOnlyTrackSelected(reaper.GetTrack(0, nbTracks-1))
   end
end

function getFirstVisibleTrack(nbTracks, currentPanel)
   for i = 0, nbTracks-1 do
	  local track_checked = reaper.GetTrack(0, i)
	  if reaper.GetMediaTrackInfo_Value(track_checked, currentPanel) == 1 then
		 return reaper.GetMediaTrackInfo_Value(track_checked, "IP_TRACKNUMBER")	  
	  end
   end
end

function getLastVisibleTrack(nbTracks, currentPanel)
   for i = nbTracks-1, 0, -1 do
	  local track_checked = reaper.GetTrack(0, i)
	  if reaper.GetMediaTrackInfo_Value(track_checked, currentPanel) == 1 then
		 return reaper.GetMediaTrackInfo_Value(track_checked, "IP_TRACKNUMBER")
	  end
   end
end
