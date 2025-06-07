local ScriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
dofile(ScriptPath .. '../Instantiate FX.lua')
dofile(ScriptPath .. './Instantiate DWIM.lua')

--------------------
-- [ INVOCATION ] --
--------------------

local plugin = ""
local track_type = ""

local track = select_single_track()

local distortion = {
   ["Uhbik"] = "CLAP:Uhbik Runciter",
   ["Single"] = "VST:SDRR",
   ["Master"] = "VST:SDRR",
   ["Buss"] = "VST:apShaper",
   ["Track"] = "CLAP:Satin"
}

if track then
   if is_master(track) then
	  track_type = "Master"
   elseif is_buss(track) then
	  track_type = "Buss"
   else
	  track_type = "Track"
   end

   insertFX(distortion[track_type])
   ShowLastTrackFX(track)
end
