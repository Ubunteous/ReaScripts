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
   ["Simple"] = "CLAPi:TAL U-No-LX-V2",
   ["Mid"] = "CLAPI:TAL-Pha",
   ["Complex"] = "VSTi:Obsession"
}

complexity = Translate_Complexity(complexity, "Generator")

if track then
   insertFX(synth[complexity])
end
