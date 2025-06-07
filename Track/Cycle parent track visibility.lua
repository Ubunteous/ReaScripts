local track = reaper.GetLastTouchedTrack()
function msg(str) reaper.ShowConsoleMsg(tostring(str)) end
function SWS_OnCommand(str) return reaper.Main_OnCommand(reaper.NamedCommandLookup(str), 0) end

if track == nil then
   return
end

------------------------------------
--  OPTION 1: get the top parent  --
------------------------------------

-- local _, flags = reaper.GetTrackState(track) -- &1 if folder
-- local parent = track
-- while reaper.GetParentTrack(parent) do
--    parent = reaper.GetParentTrack(parent)
-- end

-- if parent == track and not (flags &1) then
--    return
-- end

------------------------------------
--  OPTION 2: get current parent  --
------------------------------------

-- Folder depth change, 0=normal, 1=track is a folder parent
isParent = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH") == 1
local parent
if isParent then
   parent = track
else
   parent = reaper.GetParentTrack(track)
end

------------
--  REST  --
------------

if parent == nil then return end
reaper.SetOnlyTrackSelected(parent)

-- folder collapsed state: 0=normal, 1=collapsed, 2=fully collapsed
   if reaper.GetMediaTrackInfo_Value(parent, "I_FOLDERCOMPACT") == 2 then
	  -- SWS: Set selected folder(s) collapsed
   SWS_OnCommand("_SWS_UNCOLLAPSE")
else
   -- SWS: Set selected folder(s) uncollapsed
   SWS_OnCommand("_SWS_COLLAPSE")
end

-- opiniated choice. Makes consecutive calls keep the same children track selected
reaper.SetOnlyTrackSelected(track)
