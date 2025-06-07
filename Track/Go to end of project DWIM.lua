local initCursorPos = reaper.GetCursorPosition()

-- Transport: Go to end of project
reaper.Main_OnCommand(40043, 0)

local currCursorPos = reaper.GetCursorPosition()

if initCursorPos == currCursorPos then
   -- Item navigation: Select and move to previous item
   reaper.Main_OnCommand(40416, 0)
end
