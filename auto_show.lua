-- for tests only
-- script_duration = 3; startclocktime = reaper.time_precise()

-- you may want to adjust these values depending on your monitor size
-- they control the positions around which the mixer (dis)appears and bumps the mouse up
local trigger_height_ratio, mixer_height_ratio, vertical_correction_ratio = .9, .4, .33

function SetCommandState(set)
   is_new_value, filename, sec, cmd, mode, resolution, val = reaper.get_action_context()
   reaper.SetToggleCommandState(sec, cmd, set or 0)
   -- reaper.RefreshToolbar2(sec, cmd)
end

function GetClientBounds(hwnd)
   ret, left, top, right, bottom = reaper.JS_Window_GetClientRect(hwnd)
   return bottom-top -- , top, bottom
end

function getKeyPos(window_height)
   -- hardcoded values to update dock popup/hide state
   -- TODO: improve later by making them depend directly on the dock's dimensions
   trigger_height = math.floor(window_height * trigger_height_ratio) -- 900
   mixer_height = math.floor(window_height * mixer_height_ratio) -- 425
   vertical_correction = math.floor(window_height * vertical_correction_ratio) -- 350
   return trigger_height, mixer_height, vertical_correction
end

-- for tests only
-- if reaper.time_precise() - startclocktime >= script_duration then return end
