function Main()
   local elapsed = reaper.time_precise() - time_start
   if elapsed < 1 then
	  reaper.defer(Main)
   else
	  reaper.SetThemeColor("col_tl_fg", -1, 0)
	  reaper.UpdateTimeline()
   end
end

time_start = reaper.time_precise()
reaper.SetThemeColor("col_tl_fg", 15566742, 0) -- red
reaper.UpdateTimeline()
Main()
