local initCursorPos = reaper.GetCursorPosition()

-- Transport: Go to start of project
reaper.Main_OnCommand(40042, 0)

local currCursorPos = reaper.GetCursorPosition()

if initCursorPos == currCursorPos then
   -- Item navigation: Select and move to next item
   reaper.Main_OnCommand(40417, 0)
end
