-- -------------------- --
--    [[ VARIABLES ]]   --
-- -------------------- --

-- for tests only
-- local script_duration = 3; local startclocktime = reaper.time_precise()

local start_time = os.time()
local last_time = start_time
local refresh_delay = .75 -- in seconds

-- my bottom dock. this id may differ for other people
-- local mixer_id = 1 -- this value changes sometimes. A hack in main() finds it automatically
local mixer_command_id = 40078

local CLOSED = 0
local OPENED = 1

-- -------------------- --
--    [[ FUNCTIONS ]]   --
-- -------------------- --

function sleep(n)
   -- return false if called before n seconds (to save cpu cycle)
   local new_time = os.time()

   if new_time - last_time >= n then
      last_time = new_time
      return false
   end

   return true
end

function setCommandState(set)
   -- on/off
   local is_new_value, filename, sec, cmd, mode, resolution, val = reaper.get_action_context()
   reaper.SetToggleCommandState(sec, cmd, set or 0)
   -- reaper.RefreshToolbar2(sec, cmd)
end

function getClientHeight(hwnd)
   -- the client refers to reaper's main window
   local ret, left, top, right, bottom = reaper.JS_Window_GetClientRect(hwnd)
   return bottom-top -- , top, bottom
end

function getMixerHeight()
   local hWnd_array = reaper.new_array({}, 100)
   reaper.JS_Window_ArrayFind("REAPER_dock", true, hWnd_array) -- side effect on hWnd_array
   local dock = hWnd_array.table()
   
   if #dock == 0 then
      return 0
   end

   local hwnd = reaper.JS_Window_HandleFromAddress(dock[mixer_id])
   local _, _, top, _, bottom = reaper.JS_Window_GetClientRect(hwnd) 

   return bottom - top -- 515. but this value may change
end

function getMonitorHeight()
   local _, _, _, monitor_bottom = reaper.JS_Window_MonitorFromRect(0, 0, 0, 0, false)
   return monitor_bottom -- 1080
end

function getKeyPos(window_height, mixer_height)
   -- y coordinates which change the mixer's visibility + a correction to bump the mouse up
   -- corner case: use math.min() if the window is not fullscreen. I am maybe too cautious
   local trigger_open_height = math.min(math.floor(mixer_height * 1.75) + window_height * .05, window_height)
   local trigger_close_height = math.floor(mixer_height - window_height * .075)
   local vertical_correction = math.floor((window_height - mixer_height) / 2)
   return trigger_open_height, trigger_close_height, vertical_correction
end

function isMainWindowFocused()
   -- verification necessary so that we do not get docks popping up when we are browsing menus
   local HWND_WindowFocus = reaper.JS_Window_GetFocus()
   local parent_WindowFocus = reaper.JS_Window_GetParent(HWND_WindowFocus)
   local match = ".*REAPER.*" -- perhaps ".*REAPER.*)" would be better

   for _, window in ipairs({ HWND_WindowFocus, parent_WindowFocus }) do
      if window then
	 local window_name = reaper.JS_Window_GetTitle(window)
	 -- reaper.ShowConsoleMsg("\n Window: " .. tostring(window_name) .. "(" .. tostring(window) .. ") ")

	 if string.match(window_name, match) then
	    return true
	 end
      end
   end

   return nil
end

function hack_get_mixer_id(mixer_command_id)
   -- hack: force the dock to appear once as JS_Window_ArrayFind fails otherwise on app startup
   if reaper.GetToggleCommandState(mixer_command_id) == CLOSED then
      reaper.Main_OnCommand(mixer_command_id, 0)
      reaper.Main_OnCommand(mixer_command_id, 0)
   end

   -- hack: the mixer dock is always the last of the list
   local hWnd_array = reaper.new_array({}, 100)
   reaper.JS_Window_ArrayFind("REAPER_dock", true, hWnd_array)
   mixer_id = #hWnd_array
   
   return mixer_id
end

function updateMixerVisibility()
   -- auto toggle the mixer's visibility
   if sleep(refresh_delay) then
      reaper.defer(updateMixerVisibility)
      return nil
   end
   
   if not isMainWindowFocused() then
      -- intentional behaviour: "pause" dock state if mouse outside main window
      reaper.defer(updateMixerVisibility)
      return nil
   end

   local mixer_height = getMixerHeight()
   local mixer_state = reaper.GetToggleCommandState(mixer_command_id)

   if mixer_height < monitor_height / 4 then
      -- the mixer is useless outside fullscreen. hide it
      if mixer_state == OPENED then
	 reaper.Main_OnCommand(mixer_command_id, 0)
      end

      -- reaper.ShowConsoleMsg("\nMixer height too small for monitor: " .. mixer_height .. " vs " .. monitor_height)
      reaper.defer(updateMixerVisibility)
      return nil
   end
   
   local mouse_x, mouse_y = reaper.GetMousePosition()
   local window_height = getClientHeight(reaper.GetMainHwnd()) -- full = v(70, 1076)
   local trigger_open_height, trigger_close_height, vertical_correction = getKeyPos(window_height, mixer_height)

   if mixer_state == CLOSED and mouse_y > trigger_open_height then
      reaper.Main_OnCommand(mixer_command_id, 0)
      reaper.JS_Mouse_SetPosition(mouse_x, mouse_y - vertical_correction)
   elseif mixer_state == OPENED and mouse_y <= trigger_close_height then
      reaper.Main_OnCommand(mixer_command_id, 0)
   end

   -- for tests only
   -- if reaper.time_precise() - startclocktime >= script_duration then return end
   
   reaper.defer(updateMixerVisibility)
end

function main()
   mixer_id = hack_get_mixer_id(mixer_command_id)
   reaper.ShowConsoleMsg("\n" .. tostring(mixer_id))
   setCommandState(1)
   monitor_height = getMonitorHeight() -- if I make it local, I will need to poll it frequently
   updateMixerVisibility()
   reaper.atexit(setCommandState)
end

main()
