local ScriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
dofile(ScriptPath .. '../Instantiate FX.lua')
dofile(ScriptPath .. './Instantiate DWIM.lua')

--------------------
-- [ INVOCATION ] --
--------------------

local plugin = ""
local track_type = ""

local track = select_single_track()

local visuals = {
   ["Master"] = {
	  ["Uhbik"] = "VST:TDR Prism",
	  ["Single"] = "VST:TDR Prism",
	  ["Simple"] = "VST:TDR Prism", -- or span
	  ["Complex"] = "VST:MMultiAnalyzer"
   },
   ["Buss"] = {
	  ["Uhbik"] = "VST:TDR Prism",
	  ["Single"] = "VST:TDR Prism",
	  ["Simple"] = "VST:VUMTdeluxe",
	  ["Complex"] = "VST:VUMTdeluxe"
   },
   ["Track"] = {
	  ["Uhbik"] = "VST:TDR Prism",
	  ["Single"] = "VST:TDR Prism",
	  ["Simple"] = "Youlean Loudness Meter 2",
	  ["Complex"] = "VST:MCompare"
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

   insertFX(visuals[track_type][complexity])
   ShowLastTrackFX(track)
end
