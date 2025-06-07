local libpath = reaper.GetResourcePath()..'/Scripts/mine/Mode/ModeColour.lua'
dofile(libpath)

startOverrideID = GetCurrentOverride()
OverrideWithColour("toggle_alt15")
ActAfterDelay()
