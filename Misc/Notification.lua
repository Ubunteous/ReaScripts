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

local function Main()
   local char = gfx.getchar()

   local elapsed = reaper.time_precise() - time_start
   -- if char ~= 27 and char ~= -1 then
   if elapsed < 1 then
	  reaper.defer(Main)
   end

   gfx.setfont(1, "Arial", 44)
   local my_str = "This is a string"
   local x, y = 170, 20
   local w, h = 50, 50
   local r = 10

   -- gfx.roundrect(x, y, w, h, r, 1, 0)

   local str_w, str_h = gfx.measurestr(my_str)
   local txt_x = x + ((w - str_w) / 2)
   local txt_y = y + ((h - str_h) / 2)

   gfx.x = txt_x
   gfx.y = txt_y

   gfx.set(0.25, 0.5, 0.25, 1) -- text
   gfx.drawstr(my_str)
   -- gfx.set(0.25, 0, 0.25) -- bg

   gfx.update()
end


local height, width = getClientHeight(reaper.GetMainHwnd())
-- local mouse_x, mouse_y = reaper.GetMousePosition()

gfx.init("My Window", 400, 100, 0, width // 1.25, height // 5)
time_start = reaper.time_precise()
Main()

-- reaper.JS_Mouse_SetPosition(mouse_x, mouse_y)
