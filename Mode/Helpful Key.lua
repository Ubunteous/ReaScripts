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

local modifiers_translate = {
   [0] = 1,
   [4] = 9,
   [8] = 5,
   [12] = 13,
   [16] = 17,
   [20] = 25,
}

function msg(str) reaper.ShowConsoleMsg(str) end

function GetAsciiPressed(state)
   -- nums: 48, 57
   -- alpha: 65, 90

   -- test
   -- for i = 65, 90 do
   -- 	  if state:byte(i) ~= nil and i ~= 72 then
   -- 		 if state:byte(i) == 1 then reaper.ShowConsoleMsg("==> ") end
   -- 		 msg(tostring(state:byte(i)).."\n")
   -- 	  end
   -- end

   -- don't start too low as some early ascii chars are intercepted by mistake
   for i = 65, 90 do
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

function ShowKeyBindings(keyPressed, modifiersPressed)
   if keyPressed ~= -1 and modifiersPressed ~= nil then
	  local command = "awk '$2 == " .. modifiersPressed .. "&& $3 == " .. keyPressed ..
		 ' {printf "+ ", $0; for(i=7;i<=NF;i++) printf "%s%s", $i, (i<NF ? OFS : ""); print ""} \' '
		 .. reaper.GetResourcePath() .. '/reaper-kb.ini'

	  local output = ExecuteCommand(command)
	  msg("Bindings:\n".. output)

	  if (output == nil or output == "") then
		 msg("Error. No match in reaper-kb.ini for:\n" .. command)
	  end
   else
	  msg("Error. Unknown modifier or key press not in [0-9] nor [A-Z] ("..keyPressed.." and "..modifiersPressed..")")
   end
end

local state = reaper.JS_VKeys_GetState(0)
local keyPressed = GetAsciiPressed(state)
local modifiers = reaper.JS_Mouse_GetState(tonumber("00011100", 2)) -- alt, shift, ctrl
local modifiersPressed = modifiers_translate[modifiers]

ShowKeyBindings(keyPressed, modifiersPressed)
