function main()
   -- Time selection: Remove (unselect) time selection and loop points
   reaper.Main_OnCommand(40020, 0)

   -- SWS: Unselect all items/tracks/env points (depending on focus)
   reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_UNSELALL"), 0)
end

main()
