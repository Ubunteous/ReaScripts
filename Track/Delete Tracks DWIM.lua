-- function msg(str) reaper.ShowConsoleMsg(str) end

local nbSelectedTracks = reaper.CountSelectedTracks()
if nbSelectedTracks == 0 then return end

local nbTracks = reaper.CountTracks()
local currentTrack = reaper.GetSelectedTrack(0, nbSelectedTracks-1)
local currentTrack_idx = reaper.GetMediaTrackInfo_Value(currentTrack, 'IP_TRACKNUMBER')

if nbTracks == nbSelectedTracks then
   currentTrack = nil
elseif currentTrack_idx < nbTracks then
   currentTrack = reaper.GetTrack(0, currentTrack_idx)
else
   for track_idx = currentTrack_idx-1, 0, -1 do
      currentTrack = reaper.GetTrack(0, track_idx)
	  if not reaper.IsTrackSelected(currentTrack) then
		 break
	  end
   end
end

-- Track: Remove tracks
reaper.Main_OnCommand(40005, 0)

if currentTrack ~= nil then
   reaper.SetOnlyTrackSelected(currentTrack)
end
