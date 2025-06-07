function msg(str) reaper.ShowConsoleMsg(str.."\n") end

function toggleBypassFXOnSelectedTrack()
   local TRACK = reaper.GetSelectedTrack(0, 0)
   if TRACK == nil then
	  return nil
   end

   local FXCount = reaper.TrackFX_GetCount(TRACK)
   if FXCount == 0 then
	  return nil
   end

   for i = 0, FXCount - 1 do
	  toggleBypassOnlyForFX(TRACK, i)
   end
end

function toggleBypassOnlyForFX(track, fxid)
   local _, FXName = reaper.TrackFX_GetFXName(track, fxid, '')
   local typeFX = FXName:match("(%S+)")

   if string.sub(typeFX, -2, -2) ~= "i" then
	  local bypass_state = reaper.TrackFX_GetEnabled(track, fxid)
	  reaper.TrackFX_SetEnabled(track, fxid, not bypass_state)
   end
end

function main()
   reaper.Undo_BeginBlock()
   toggleBypassFXOnSelectedTrack();
   reaper.Undo_EndBlock("Toggle bypass non-instrument FX", -1)
end

main()
