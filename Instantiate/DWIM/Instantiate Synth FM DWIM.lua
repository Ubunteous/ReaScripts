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
   ["Simple"] = "VSTi:The Mangle",
   ["Mid"] = "VSTi:Aparillo",
   ["Complex"] = "CLAPi:Bazille"
}

complexity = Translate_Complexity(complexity, "Generator")

if track then
   insertFX(synth[complexity])
end
