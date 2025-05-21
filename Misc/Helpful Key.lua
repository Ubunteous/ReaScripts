-- Modifiers in INI file
-- 1 NONE
-- 9 CTRL
-- 5 SHIFT
-- 13 CTRL+SHIFT
-- 17 ALT
-- 25 CTRL+ALT

-- Modifiers with reaper.JS_Mouse_GetState
-- 0 NONE
-- 4 CTRL
-- 8 SHIFT
-- 12 CTRL+SHIFT
-- 16 ALT
-- 20 CTRL+ALT

-- ASCII
-- Nums: 48-57
-- Alpha: 65-90

local state = reaper.JS_VKeys_GetState(0)
local modifiers = reaper.JS_Mouse_GetState(tonumber("00011100", 2)) -- alt, shift, ctrl

local modifiers_translate = {
   [0] = 1,
   [4] = 9,
   [8] = 5,
   [12] = 13,
   [16] = 17,
   [20] = 25,
}

function GetAsciiPressed()
   -- nums: 48, 57
   -- alpha: 65, 90
   
   -- don't start too low as some early ascii chars are intercepted by mistake
   for i = 32, 512 do
	  if state:byte(i) == 1 then
		 return i
	  end
   end

   -- nothing
   return -1
end

function ExecuteCommand(command)
   local handle = io.popen(command)
   local result = handle:read("*a")
   handle:close()
   return result
end

local keyPressed = GetAsciiPressed()
local modifiersPressed = modifiers_translate[modifiers]

if keyPressed ~= -1 and modifiersPressed ~= nil then
   local command = 'grep "^KEY ' .. modifiersPressed .. " " .. keyPressed .. '" '
	  .. reaper.GetResourcePath() .. '/reaper-kb.ini | awk \'{printf "+ ", $0; for(i=7;i<=NF;i++) printf "%s%s", $i, (i<NF ? OFS : ""); print ""}\''

   local output = ExecuteCommand(command)
   reaper.ShowConsoleMsg("Bindings:\n".. output)

   if (output == nil or output == "") then
	  reaper.ShowConsoleMsg("Error. No match in reaper-kb.ini for:\n" .. command)
   end
else
   reaper.ShowConsoleMsg("Error. Unknown modifier or key press not in [0-9] nor [A-Z]")
end
