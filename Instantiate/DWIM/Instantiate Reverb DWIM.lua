local ScriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
dofile(ScriptPath .. '../Instantiate FX.lua')
dofile(ScriptPath .. './Instantiate DWIM.lua')

--------------------
-- [ INVOCATION ] --
--------------------

local plugin = ""
local track_type = ""

local track = select_single_track()

local compression = {
   ["Master"] = {
	  ["Uhbik"] = "CLAP:Uhbik Ambience",
	  -- ["Single"] = "",
	  -- ["Simple"] = "",
	  -- ["Complex"] = ""
   },
   ["Buss"] = {
	  ["Uhbik"] = "CLAP:Uhbik Ambience",
	  -- ["Single"] = "",
	  -- ["Simple"] = "",
	  -- ["Complex"] = ""
   },
   ["Track"] = {
	  ["Uhbik"] = "CLAP:Uhbik Ambience",
	  -- ["Single"] = "",
	  -- ["Simple"] = "",
	  -- ["Complex"] = ""
   }
}

complexity = Translate_Complexity(complexity, "FX")

if track then
   if is_master(track) then
	  track_type = "Master"
   elseif is_buss(track) then
	  track_type = "Buss"
   else
	  track_type = "Track"
   end

   insertFX(compression[track_type][complexity])
   ShowLastTrackFX(track)
end
