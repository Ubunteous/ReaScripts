function msg(s)
   if not s then
	  return
   end

   if type(s) == 'boolean' then
	  if s then
		 s = 'true'
	  else
		 s = 'false'
	  end
   end
   reaper.ShowConsoleMsg(s..'\n')
end

-- function getMonitorDimensions()
--    _, _, screen_right, screen_bottom = reaper.JS_Window_MonitorFromRect(0, 0, 0, 0, false)
--    return screen_right, screen_bottom
-- end

function getClientHeight(hwnd)
   -- the client refers to reaper's main window
   local ret, left, top, right, bottom = reaper.JS_Window_GetClientRect(hwnd)
   return right-left, bottom-top
end

function ShowNotification(message)
   local char = gfx.getchar()

   local height, width = getClientHeight(reaper.GetMainHwnd())
   gfx.init(message, 400, 100, 0, width // 1.25, height // 5)

   local elapsed = reaper.time_precise() - time_start
   if elapsed < 1 then
	  reaper.defer(ShowNotification)
   end

   gfx.setfont(1, "Arial", 44)
   local x, y = 180, 20
   local w, h = 50, 50

   local str_w, str_h = gfx.measurestr(message)
   local txt_x = x + (w - str_w) / 2
   local txt_y = y + (h - str_h) / 2

   gfx.x = txt_x
   gfx.y = txt_y
   gfx.set(0.25, 0.5, 0.25, 1)

   gfx.drawstr("My Window")
   gfx.update()
end

time_start = reaper.time_precise()
ShowNotification("My Window")
