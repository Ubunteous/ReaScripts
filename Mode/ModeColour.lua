-- catpuccin theme
-- local colours = {
--    red = 15566742,
--    rowewater = 16047062,
--    flamingo = 15779526,
--    pink = 16104934,
--    mauve = 13017334,
--    red = 15566742,
--    maroon = 15636896,
--    peach = 1604011814,
--    yellow = 15651999,
--    green = 10934933,
--    teal = 9164234,
--    sky = 9557987,
--    sapphire = 8242404,
--    blue = 9088500,
--    lavender = 12041720,
--    text = 13292533
-- }

local delay = 1
local time_start = reaper.time_precise()

local colours = {
   clear = 0,
   default = 0,
   -- recording = 9164234, -- teal
   -- alt1 = 15566742, -- red
   alt15 = 9557987, -- sky
   alt16 = 10934933, -- green
}

local alts = {
   clear = 24800,

   set_default = 24801,
   -- toggle_recording = 24802,
   -- toggle_alt1 = 24803,
   -- toggle_alt2 = 24804,
   -- toggle_alt3 = 24805,
   -- toggle_alt4 = 24806,
   -- toggle_alt5 = 24807,
   -- toggle_alt6 = 24808,
   -- toggle_alt7 = 24809,
   -- toggle_alt8 = 24810,
   -- toggle_alt9 = 24811,
   -- toggle_alt10 = 24812,
   -- toggle_alt11 = 24813,
   -- toggle_alt12 = 24814,
   -- toggle_alt13 = 24815,
   -- toggle_alt14 = 24816,
   toggle_alt15 = 24817,
   toggle_alt16 = 24818,

   momentary_default = 24851,
   -- momentary_recording = 24852,
   -- momentary_alt1 = 24853,
   -- momentary_alt2 = 24854,
   -- momentary_alt3 = 24855,
   -- momentary_alt4 = 24856,
   -- momentary_alt5 = 24857,
   -- momentary_alt6 = 24858,
   -- momentary_alt7 = 24859,
   -- momentary_alt8 = 24860,
   -- momentary_alt9 = 24861,
   -- momentary_alt10 = 24862,
   -- momentary_alt11 = 24863,
   -- momentary_alt12 = 24864,
   -- momentary_alt13 = 24865,
   -- momentary_alt14 = 24866,
   -- momentary_alt15 = 24867,
   momentary_alt16 = 24868,
}

local numericalAlts = {}
for key, value in pairs(alts) do
   numericalAlts[value] = key
end

function msg(str) reaper.ShowConsoleMsg(str) end

function GetCurrentOverride()
   for i = 24803, 24818 do
	  -- see Ex(alt-n, i) to choose alt
	  if reaper.GetToggleCommandState(i) == 1 then
		 -- msg("Alt-"..(i-24802).."\n")
		 return i
	  end
   end

   return 24801 -- default/clear
end

function KeepLastSplit(inputstr)
   local sep = '_'

   for field, s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
	  if s == "" then
		 return field
	  end
   end
end

function ResetColourAfterDelay()
   local elapsed = reaper.time_precise() - time_start
   if elapsed < delay then
	  reaper.defer(ResetColourAfterDelay)
	  -- new attempts for 5 seconds (add check if no input detected if necessary)
	  -- elseif attempts > 0 then
	  -- 	  attempts = attempts - 1
	  -- 	  time_start = reaper.time_precise()
	  -- 	  reaper.defer(ResetColourAfterDelay)
	  -- 	  reaper.Main_OnCommand(alts[global_alt], 0)
   else
	  reaper.SetThemeColor("col_tl_fg", -1, 0)
	  reaper.UpdateTimeline()
   end
end

function OverrideWithColour(alt)
   -- time_start = reaper.time_precise()
   -- attempts = 5
   -- global_alt = alt

   reaper.Main_OnCommand(alts[alt], 0)

   local alt_target = KeepLastSplit(alt)
   if alt_target ~= "clear" and alt_target ~= "default" then
	  reaper.SetThemeColor("col_tl_fg", colours[alt_target], 0)
	  reaper.UpdateTimeline()

	  -- for momentary actions
	  if alts[alt] > alts["momentary_default"] then
		 ResetColourAfterDelay()
	  end
   end
end

function Teardown()
   reaper.SetThemeColor("col_tl_fg", -1, 0)
   reaper.UpdateTimeline()

   if startOverrideID ~= nil then
	  -- reaper.Main_OnCommand(startOverrideID, 0)
	  OverrideWithColour(numericalAlts[startOverrideID])
   else
	  OverrideWithColour(numericalAlts[startOverrideID])
	  msg("Error: startOverrideID not set in script calling ModeColour")
   end
end

function ActAfterDelay()
   local elapsed = reaper.time_precise() - time_start
   if elapsed < delay then
	  reaper.defer(ActAfterDelay)
   else
	  Teardown()
   end
end
