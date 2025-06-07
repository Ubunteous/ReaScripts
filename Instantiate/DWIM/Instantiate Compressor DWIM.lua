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
	  ["Uhbik"] = "CLAP:Uhbik Compressor",
	  ["Single"] = "VST:TrackComp",
	  ["Simple"] = "VST:TDR Kotelnikov GE",
	  ["Complex"] = "VST:TDR Molot GE"
   },
   ["Buss"] = {
	  ["Uhbik"] = "CLAP:Uhbik Compressor",
	  ["Single"] = "VST:TrackComp",
	  ["Simple"] = "VST:MJUC",
	  ["Complex"] = "CLAP:Presswerk"
   },
   ["Track"] = {
	  ["Uhbik"] = "CLAP:Uhbik Compressor",
	  ["Single"] = "VST:TrackComp",
	  ["Simple"] = "VST:TrackComp",
	  ["Complex"] = "VST:DC8C"
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
