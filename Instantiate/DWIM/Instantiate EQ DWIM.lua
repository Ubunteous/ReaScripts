local ScriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
dofile(ScriptPath .. '../Instantiate FX.lua')
dofile(ScriptPath .. './Instantiate DWIM.lua')

--------------------
-- [ INVOCATION ] --
--------------------

local plugin = ""
local track_type = ""

local track = select_single_track()

local eq = {
   ["Master"] = {
	  ["Uhbik"] = "CLAP:Uhbik EQ",
	  ["Single"] = "JS:ReEQ",
	  ["Simple"] = "VST:TDR SlickEQ GE",
	  ["Complex"] = "VST:apQualizr"
   },
   ["Buss"] = {
	  ["Uhbik"] = "CLAP:Uhbik EQ",
	  ["Single"] = "JS:ReEQ",
	  ["Simple"] = "VST:TDR Nova GE",
	  ["Complex"] = "VST:MDynamicEQ"
   },
   ["Track"] = {
	  ["Uhbik"] = "CLAP:Uhbik EQ",
	  ["Single"] = "JS:ReEQ",
	  ["Simple"] = "VST:TDR SlickEQ M GE",
	  ["Complex"] = "VST:Equilibrium"
   }
}

if track then
   if is_master(track) then
	  track_type = "Master"
   elseif is_buss(track) then
	  track_type = "Buss"
   else
	  track_type = "Track"
   end

   insertFX(eq[track_type][complexity])
   ShowLastTrackFX(track)
end
