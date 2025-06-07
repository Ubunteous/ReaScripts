local ScriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
dofile(ScriptPath .. '../Instantiate FX.lua')
dofile(ScriptPath .. './Instantiate DWIM.lua')

--------------------
-- [ INVOCATION ] --
--------------------

local plugin = ""
local track_type = ""

local track = select_single_track()

local dynamic = {
   ["Master"] = {
	  ["Uhbik"] = "CLAP:Uhbik Compressor",
	  ["Single"] = "VST:TrackLimit",
	  ["Simple"] = "VST:TrackLimit",
	  ["Complex"] = "VST:TrackDS"
   },
   ["Buss"] = {
	  ["Uhbik"] = "CLAP:Uhbik Compressor",
	  ["Simple"] = "VST:TrackGate",
	  ["Complex"] = "VST:Multiplicity"
   },
   ["Track"] = {
	  ["Uhbik"] = "CLAP:Uhbik Compressor",
	  ["Simple"] = "VST:TDR Limiter6 GE",
	  ["Complex"] = "VST:Limitless"
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

   insertFX(dynamic[track_type][complexity])
   ShowLastTrackFX(track)
end
