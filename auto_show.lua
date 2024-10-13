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

function isMainWindowFocused()
   -- verification necessary so that we do not get docks popping up when we are browsing menus
   HWND_WindowFocus = reaper.JS_Window_GetFocus()
   parent_WindowFocus = reaper.JS_Window_GetParent(HWND_WindowFocus)
   match = ".*REAPER.*" -- perhaps ".*REAPER.*)" would be better

   for _, window in ipairs({ HWND_WindowFocus, parent_WindowFocus }) do
      if window then
	 window_name = reaper.JS_Window_GetTitle(window)
	 -- reaper.ShowConsoleMsg("\n Window: " .. tostring(window_name) .. "(" .. tostring(window) .. ") ")

	 if string.match(window_name, match) then
	    return true
	 end
      end
   end

   return nil
end

function updateMixer()
   x, y = reaper.GetMousePosition()
   state = reaper.GetToggleCommandState(40078)
   
   window_height = GetClientBounds(reaper.GetMainHwnd()) -- full = v(70, 1076)
   trigger_height, mixer_height, vertical_correction = getKeyPos(window_height)

   if isMainWindowFocused() ~= true then
      -- intentional behaviour: "pause" dock state if mouse outside main window
      reaper.defer(updateMixer)
      return nil
   end
   
   if state == 0 and y > trigger_height and window_height > 500 then
      reaper.Main_OnCommand(40078, 0)
      reaper.JS_Mouse_SetPosition(x, y - vertical_correction)
   elseif state == 1 and y <= mixer_height then
      reaper.Main_OnCommand(40078, 0)
   end

   -- for tests only
   -- if reaper.time_precise() - startclocktime >= script_duration then return end
   
   reaper.defer(updateMixer)
end

SetCommandState(1)
updateMixer()
reaper.atexit(SetCommandState)
