local ScriptPath = ({reaper.get_action_context()})[2]:match('^.+[\\//]')
dofile(ScriptPath .. './Instantiate DWIM.lua')

function is_generator(track)
   if reaper.TrackFX_GetCount(track) == 0 and not is_buss(track) then
	  return true
   end

   -- otherwise, insert an FX
   return false
end

function Foreign_OnCommand(cmd_name)
   local cmd_id = reaper.NamedCommandLookup(cmd_name)
   reaper.Main_OnCommand(cmd_id, 0)
end

reaper.Undo_BeginBlock()

function SmartInsert()
   local track = select_single_track()
   local insert_generator = is_generator(track)

   if track then
	  if insert_generator then
		 -- insert instrument menu + tal sampler/drums
		 Foreign_OnCommand("_RS266f56e72233f9832712ba485d8dddad7292f9c5")
	  else
		 -- insert FX menu + reeq
		 Foreign_OnCommand("_RSa57a6af7934690db1f5d5385ca140d51149949c9")
	  end
   end
end

SmartInsert()

reaper.Undo_EndBlock("Script: Instantiate Generator or FX DWIM ", 0)
