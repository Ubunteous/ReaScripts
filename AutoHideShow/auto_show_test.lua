function isMainWindowFocused()
   -- verification necessary so that we do not get docks popping up when we are in another window
   -- does not work on pop up menus (as it does not distinguish them from reaper's main window)
   HWND_WindowFocus = reaper.JS_Window_GetFocus()
   parent_WindowFocus = reaper.JS_Window_GetParent(HWND_WindowFocus)
   match = ".*REAPER.*"

   for _, window in ipairs({ HWND_WindowFocus, parent_WindowFocus }) do
      if window then
	 window_name = reaper.JS_Window_GetTitle(window)
	 reaper.ShowConsoleMsg("\n Window: " .. tostring(window_name) .. "(" .. tostring(window) .. ") ")
	 
	 if string.match(window_name, match) then
	    reaper.ShowConsoleMsg("=> Main window found")
	    return true
	 else
	    reaper.ShowConsoleMsg("=> Not the main window")
	 end
      end
   end

   return nil
end

function getMousePos()
   x, y = reaper.GetMousePosition()
   reaper.ShowConsoleMsg("\nMouse pos: " .. "x=" .. x .. " y=" .. y)
end

function getDockInfo()
   -- all docks are called REAPER_dock. How to distinguish them to find the mixer?
   local hWnd_array = reaper.new_array({}, 100)
   reaper.JS_Window_ArrayFind("REAPER_dock", true, hWnd_array) -- side effect on array parameter
   dock = hWnd_array.table()

   reaper.ShowConsoleMsg("\nList of docks found:")
   
   for i = 1, #dock do
      local hwnd = reaper.JS_Window_HandleFromAddress(dock[i])
      local _, left, top, right, bottom = reaper.JS_Window_GetClientRect( hwnd )
      dock[i] = {hwnd = hwnd, l = left, t = top, r = right, b = bottom, w = (right-left), height = (bottom-top)}

      title = tostring(reaper.JS_Window_GetTitle(dock[i]["hwnd"]))
      class = tostring(reaper.JS_Window_GetClassName(dock[i]["hwnd"]))
      reaper.ShowConsoleMsg("\nDOCK: " .. title .. " from class " .. class  .. " and height " .. tostring(dock[i]["height"]))
   end
end

function getMonitorHeight()
   _, _, _, screen_bottom = reaper.JS_Window_MonitorFromRect(0, 0, 0, 0, false)
   reaper.ShowConsoleMsg("\nWindow size: " .. screen_bottom)
end

function getMixer()
   -- m = reaper.JS_Window_Find("Mixer (docked)", true)
   m = reaper.JS_Window_Find("Mixer", true)
   
   if m then
      reaper.ShowConsoleMsg("\nMixer is docked" .. tostring(m))
   else
      reaper.ShowConsoleMsg("\nMixer not found")
   end
end

getMixer()
-- isMainWindowFocused()
-- reaper.ShowConsoleMsg("\n")
-- getDockInfo()
-- reaper.ShowConsoleMsg("\n")
-- getMousePos()
-- reaper.ShowConsoleMsg("\n")
-- getMonitorHeight()
