-- -------------------- --
--    [[ VARIABLES ]]   --
-- -------------------- --

-- for tests only
-- local script_duration = 3; local startclocktime = reaper.time_precise()

local start_time = os.time()
local last_time = start_time
local refresh_delay = .75 -- in seconds

-- -- you may want to adjust these values depending on your monitor size
-- local trigger_height_ratio = .9 -- position where the mixer appears
-- local mixer_height_ratio = .4 -- position where the mixer disappears
-- local vertical_correction_ratio = .33 -- bumps the mouse up

-- my bottom dock. this id may differ for other people
local mixer_id = 1

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

function SetCommandState(set)
   is_new_value, filename, sec, cmd, mode, resolution, val = reaper.get_action_context()
   reaper.SetToggleCommandState(sec, cmd, set or 0)
   -- reaper.RefreshToolbar2(sec, cmd)
end

function GetClientBounds(hwnd)
   ret, left, top, right, bottom = reaper.JS_Window_GetClientRect(hwnd)
   return bottom-top -- , top, bottom
end

function getMixerHeight()
   local hWnd_array = reaper.new_array({}, 100)
   reaper.JS_Window_ArrayFind("REAPER_dock", true, hWnd_array) -- side effect on hWnd_array
   dock = hWnd_array.table()
   
   if (#dock) == 0 then
      return 0
   end

   local hwnd = reaper.JS_Window_HandleFromAddress(dock[mixer_id])
   local _, _, top, _, bottom = reaper.JS_Window_GetClientRect(hwnd) 

   return bottom - top -- 515. but this value may change
end

-- function getHardcodedPos(window_height)
--    -- needs hardcoded values to update dock popup/hide state
--    trigger_height = math.floor(window_height * trigger_height_ratio) -- 900
--    mixer_height = math.floor(window_height * mixer_height_ratio) -- 425
--    vertical_correction = math.floor(window_height * vertical_correction_ratio) -- 350
--    return trigger_height, mixer_height, vertical_correction
-- end

function getKeyPos(window_height, mixer_height)
   -- corner case: use math.min() if the window is not fullscreen. I am maybe too cautious 
   trigger_height = math.min(math.floor(mixer_height * 1.5) + window_height * .1, window_height)
   vertical_correction = math.floor((window_height - mixer_height) / 2)
   return trigger_height, vertical_correction
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
   -- toggle the mixer's visibility
   if sleep(refresh_delay) then
      reaper.defer(updateMixer)
      return nil
   end

   mixer_height = getMixerHeight()

   if mixer_height == 0 then
      reaper.defer(updateMixer)
      reaper.ShowConsoleMsg("\nMixer height 0")
      return nil
   end

   x, y = reaper.GetMousePosition()
   window_height = GetClientBounds(reaper.GetMainHwnd()) -- full = v(70, 1076)
   state = reaper.GetToggleCommandState(40078)

   -- trigger_height, mixer_height, vertical_correction = getHardcodedPos(window_height)
   trigger_height, vertical_correction = getKeyPos(window_height, mixer_height)
   
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

-- -------------------- --
--    [[ MAIN FUNC ]]   --
-- -------------------- --

function main()
   SetCommandState(1)
   updateMixer()
   reaper.atexit(SetCommandState)
end

main()
