function msg(str) reaper.ShowConsoleMsg(str) end

mixerDock = reaper.JS_Window_Find("Mixer", false)

-- View: Show docker
reaper.Main_OnCommand(40279, 0)

-- View: Toggle mixer visible
if mixerDock == nil and reaper.GetToggleCommandState(40078) == 0 then
   -- View: Toggle mixer visible
   reaper.Main_OnCommand(40078, 0)
end

-- test visibility
-- title = reaper.JS_Window_GetTitle(mixerDock)
-- if reaper.JS_Window_IsVisible(mixerDock) then
