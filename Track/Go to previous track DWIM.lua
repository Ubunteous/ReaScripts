function msg(str) reaper.ShowConsoleMsg(tostring(str)) end

local nbTracks = reaper.CountTracks(0)

if nbTracks == 0 then
   return
end

local currentPanel

-- View: Toggle mixer visible
if reaper.GetToggleCommandState(40078) == 1 then
   currentPanel = "B_SHOWINMIXER"
else
   currentPanel = "B_SHOWINTCP"
end

local current_track = reaper.GetLastTouchedTrack()

if reaper.GetMediaTrackInfo_Value(current_track, currentPanel) == 0 then
   msg("Can't move from invisible track")
   return
end

local idx_current_track = reaper.GetMediaTrackInfo_Value(current_track, "IP_TRACKNUMBER")
local idx_first_visible_track
local idx_last_visible_track

for i = 0, nbTracks-1 do
   local track_checked = reaper.GetTrack(0, i)
   if reaper.GetMediaTrackInfo_Value(track_checked, currentPanel) == 1 then
	  idx_first_visible_track = reaper.GetMediaTrackInfo_Value(track_checked, "IP_TRACKNUMBER")
	  break
   end
end

for i = nbTracks-1, 0, -1 do
   local track_checked = reaper.GetTrack(0, i)
   if reaper.GetMediaTrackInfo_Value(track_checked, currentPanel) == 1 then
	  idx_last_visible_track = reaper.GetMediaTrackInfo_Value(track_checked, "IP_TRACKNUMBER")
	  break
   end
end

if idx_current_track == idx_first_visible_track then
   reaper.SetOnlyTrackSelected(reaper.GetTrack(0, idx_last_visible_track-1), true)

   -- hack to move view to top
   -- Track: Go to previous track
   reaper.Main_OnCommand(40286, 0)
   -- Track: Go to next track
   reaper.Main_OnCommand(40285, 0)
else
   -- go to previous visible track in current panel
   for i = idx_current_track-2, 0, -1 do
	  local track_checked = reaper.GetTrack(0, i)
	  if reaper.GetMediaTrackInfo_Value(track_checked, currentPanel) == 1 then
		 reaper.SetOnlyTrackSelected(track_checked, true)
		 break
	  end
   end
end
