local ScriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
dofile(ScriptPath .. '../Instantiate FX.lua')
dofile(ScriptPath .. './Instantiate DWIM.lua')

--------------------
-- [ INVOCATION ] --
--------------------

local plugin = ""
local track_type = ""

local track = select_single_track()

local synth = {
   ["Simple"] = "CLAPi:TAL BassLine 101",
   ["Mid"] = "VSTi:The Legend",
   ["Complex"] = "CLAPi:A.C.E."
}

complexity = Translate_Complexity(complexity, "Generator")

if track then
   insertFX(synth[complexity])
   reaper.TrackFX_Show(track, 0, 1)
end
