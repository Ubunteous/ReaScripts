local track = reaper.GetLastTouchedTrack()

if track == nil then
   -- Insert virtual instrument on new track...
   reaper.Main_OnCommand(40701, 0)
else
   -- Track: View FX chain for current/last touched track
   reaper.Main_OnCommand(40291, 0)
end
