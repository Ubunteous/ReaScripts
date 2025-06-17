local libpath = reaper.GetResourcePath()..'/Scripts/mine/Track/Go to track DWIM.lua'
dofile(libpath)

local nbTracks = reaper.CountTracks(0)
local current_track = reaper.GetLastTouchedTrack()
local currentPanel = getPanelType()

if checkIfMotionPossible(nbTracks, current_track, currentPanel) == false then return end

local idx_current_track = reaper.GetMediaTrackInfo_Value(current_track, "IP_TRACKNUMBER")
local idx_first_visible_track = getFirstVisibleTrack(nbTracks, currentPanel)
local idx_last_visible_track = getLastVisibleTrack(nbTracks, currentPanel)

if idx_current_track == idx_first_visible_track then
   reaper.SetOnlyTrackSelected(reaper.GetTrack(0, idx_last_visible_track-1), true)
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

-- Track: Vertical scroll selected tracks into view
reaper.Main_OnCommand(40913, 0)
