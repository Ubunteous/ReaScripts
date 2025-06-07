function SWS_OnCommand(str) return reaper.Main_OnCommand(reaper.NamedCommandLookup(str), 0) end

reaper.SetOnlyTrackSelected(reaper.GetLastTouchedTrack())

-- Xenakios/SWS: Select first items of selected tracks
SWS_OnCommand("_XENAKIOS_SELFIRSTITEMSOFTRACKS")

-- Xenakios/SWS: Select items to end of track
SWS_OnCommand("_XENAKIOS_SELITEMSTOENDOFTRACK")
