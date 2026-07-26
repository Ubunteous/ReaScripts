local r = reaper

-- function msg(m)
--    r.ShowConsoleMsg(tostring(m))
-- end

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

vars = {
   -- actions
   "SECTION: actions",
   "cueitems",
   "itemtexthide",

   -- Envelope Manager
   "SECTION: Envelope Manager",
   "envmgropts",

   -- help menu
   "SECTION: help menu",
   "help",

   -- misc
   "SECTION: misc",
   "edit_fontsize",
   "g_config_project", -- should not be accessed as double
   "g_markerlist_updcnt",

   "ide_colors",
   "ide_font_face",
   "inprojmidi_wildcards",

   "itemnotes",
   "lastthemefn5",
   "maxspeakgain",

   "metronome_flags",
   "mvu_rmsgain",
   "mvu_rmsmode",

   "mvu_rmsoffs2",
   "mvu_rmsred",
   "mvu_rmssize",

   "preroll",
   "prerollmeas",
   "quantflag",

   "quantolms",
   "quantolms2",
   "quantsize2",

   "screenset_as_views",
   "screenset_as_win",
   "screenset_autosave",

   "showctinmix",
   "showmaintrack",
   "specpeak_alpha",

   "specpeak_bv",
   "specpeak_ftp",
   "specpeak_hueh",

   "specpeak_huel",
   "specpeak_lo",
   "specpeak_na",

   -- midi
   "SECTION: midi",
   "scnotes",
   "scoreminnotelen",
   "scorequant",

   -- PREFERENCES
   "SECTION: PREFERENCES",

   -- appearance
   "SECTION: appearance",
   "custommenu",
   "env_pt_scale",
   "env_pt_scale2",

   "envlanes",
   "griddot",
   "gridinbg",

   "gridinbg2",
   "guidelines2",
   "itemvolmode",

   "maxitemlanes",
   "nativedrawtext",
   "peaks_minheight",

   "playcursormode",
   "rulerlabelspacing",
   "rulerlayout",

   "showlastundo",
   "showpeaksbuild",
   "textflags",

   "timeseledge",
   "tooltipdelay",
   "tooltips",

   "trackgapmax",
   "trackitemgap",
   "vgrid",

   -- appearance media
   "SECTION: appearance media",
   "applyfxtail",
   "copyimpmedia",

   -- audio
   "SECTION: audio",
   "allstereopairs",
   "audiocloseinactive",
   "audioclosestop",

   "errnowarn",
   "hwfadex",
   "metronome_defout",

   "optimizesilence",
   "pdcautobypassms",
   "useinnc",

   -- automation
   "SECTION: automation",
   "autoreturntime",
   "autoreturntime_action",
   "env_autoadd",

   "env_options",
   "envtrimadjmode",
   "envwritepasschg",

   "pooledenvtranstime",

   -- backups
   "SECTION: backups",
   "autosavebackuplimit",
   "autosaveint",
   "autosavemode",

   "savebackuplimit",
   "saveopts",

   -- buffering
   "SECTION: buffering",
   "audioasync",
   "autonbworkerthreads",
   "disk_peakmmap2",

   "disk_peaks_mmapkb",
   "disk_peaks_ramkb",
   "disk_rdblksex",

   "disk_rdmodeex",
   "disk_rdsizeex",
   "disk_wrblks",

   "disk_wrblks2",
   "disk_wrmode",
   "disk_wrsize",

   "prebufperb",
   "renderaheadlen",
   "renderaheadlen2",

   "syncsmpmax2",
   "syncsmpuse",
   "threadpr",

   "workbehvr",
   "workbuffxuims",
   "workbufmsex",

   "workrender",
   "workthreads",

   -- compatibility
   "SECTION: compatibility",
   "fxdenorm",
   "fxenvinterp",
   "vstbr64",

   -- context menu
   "SECTION: context menu",
   "mixerflag",
   "mixeruiflag",
   "multiprojopt",

   -- control/osc/web
   "SECTION: control/osc/web",
   "csurfrate",

   -- device
   "SECTION: device",
   "audiothreadpr",

   -- editing Behavior
   "SECTION: editing Behavior",
   "areasel",
   "itemclickmovecurs",
   "itemranks",

   "ripplelockmode",
   "tabtotransflag",
   "transientsensitivity",
   "transientthreshold",

   -- edting Behavior
   "SECTION: edting Behavior",
   "locklooptotime",

   -- envelope Display
   "SECTION: envelope Display",
   "env_deffoc",
   "env_ol_minh",
   "env_reduce",

   "envclicksegmode",
   "envtranstime",
   "pitchenvrange",

   "pooledenvs",
   "tempoenvmax",
   "tempoenvmin",

   -- fades/Crossfades
   "SECTION: fades/Crossfades",
   "itemfade_minheight",
   "itemfade_minwidth",
   "itemfadehandle_maxwidth",

   "itemicons",

   -- general
   "SECTION: general",
   "actionmenu",
   "alwaysallowkb",
   "autoclosetrackwnds",

   "bigwndframes",
   "cpuallowed",
   "loadlastproj",

   "maxrecent",
   "restrictcpu",
   "saveundostatesproj",

   "uiscale",
   "undomask",
   "undomaxmem",

   "verchk",
   "warnmaxram64",
   "windowflags",

   "workset_max",
   "workset_min",
   "workset_use",


   -- import
   "SECTION: import",
   "bpmprojadj",

   -- item Fade Defaults
   "SECTION: item Fade Defaults",
   "deffadelen",
   "deffadeshape",
   "defsplitxfadelen",

   "defxfadeshape",
   "splitautoxfade",
   "splitmaxpix",

   "stretchmarkerfade",

   -- item Loop Defaults
   "SECTION: item Loop Defaults",
   "loopnewitems",

   -- keyboard/Multitouch
   "SECTION: keyboard/Multitouch",
   "kbd_override_len",
   "kbd_usealt",
   "multitouch",

   "multitouch_ignore_ms",
   "multitouch_ignorewheel_ms",
   "multitouch_rotate_gear",

   "multitouch_swipe_gear",
   "multitouch_zoom_gear",

   -- lv2
   "SECTION: lv2",
   "lv2_opts",

   -- loop Recording
   "SECTION: loop Recording",
   "recaddatloop",

   -- midi Devices
   "SECTION: midi Devices",
   "midiins",
   "midiins_cs",
   "midiouts",

   "midiouts_clock",
   "midiouts_clock_nospp",
   "midiouts_llmode",

   "midiouts_noreset",
   "midioutthread",
   "midisendflags",

   -- midi Editor
   "SECTION: midi Editor",
   "midiccdensity",
   "midiccdensity",
   "midiccenv",

   "midiccinterp",
   "mididefcolormap",
   "midieditor",

   "midivu",

   -- midi Settings
   "SECTION: midi Settings",
   "midicctouchtimeout",
   "rbn",

   -- midi
   "SECTION: midi",
   "midioctoffs",
   "miditicksperbeat",
   "opencopyprompt",

   "trimmidionsplit",

   -- media Item Positioning
   "SECTION: media Item Positioning",
   "itemlane_minheight",

   -- media
   "SECTION: media",
   "altpeaks",
   "insertmtrack",
   "itemfxtail",

   "itemicons_minheight",
   "itemlabel_hideheight",
   "itemlabel_minheight",

   "labelitems2",
   "miscopts",
   "offlineinact",

   "peakcachegenmode",
   "peakcachegenrs",
   "reccfg",

   "relativeedges",
   "showpeaks",

   -- misc
   "SECTION: misc",
   "bouncecfg",
   "templateditcursor",
   "wiring_options",

   -- mouse Modifiers
   "SECTION: mouse Modifiers",
   "handzoom",
   "itemlowerhalf_minheight",
   "loopclickmode",

   "mousewheelmode",
   "scnameedit",
   "trackselonmouse",

   -- mute/Solo
   "SECTION: mute/Solo",
   "automute",
   "automuteflags",
   "automuteval",

   "mutefadems10",
   "norunmute",
   "solodimdb10",

   "soloip",

   -- options Menu
   "SECTION: options Menu",
   "aot",
   "envattach",
   "itemsnap",

   "maxsnaptrack",
   "snapextrad",
   "snapextraden",

   "solodimen",
   "takelanes",

   -- paths
   "SECTION: paths",
   "altpeaksopathlist",
   "altpeakspath",
   "defrenderpath",

   "defsavepath",

   -- peaks/Waveforms
   "SECTION: peaks/Waveforms",
   "midipeaks",
   "peaksedges",
   "sampleedges",

   "selitem_tintalpha",
   "unselitem_tintalpha",

   -- playback
   "SECTION: playback",
   "loopstopfx",
   "maxplayoffsrate",
   "runafterstop",

   "runallonstop",
   "stopendofloop",
   "stopprojlen",

   "viewadvance",

   -- plug-Ins
   "SECTION: plug-Ins",
   "fxfloat_focus",
   "fxresize",

   -- plug-ins
   "SECTION: plug-ins",
   "maxrecentfx",

   -- project
   "SECTION: project",
   "newprojdo",
   "pmfol",
   "rfprojfirst",

   -- rewire/DX
   "SECTION: rewire/DX",
   "rewireslave",
   "rewireslavedelay",

   -- reamote
   "SECTION: reamote",
   "reamote_maxblock",
   "reamote_maxlat_render",
   "reamote_maxpkt",

   "reamote_smplfmt",
   "use_reamote",

   -- reascript
   "SECTION: reascript",
   "edit_flags",
   "edit_sug",
   "reascript",

   "reascripttimeout",
   "reascriptwatchms",

   -- recording
   "SECTION: recording",
   "adjrecmanlat",

   -- recording
   "SECTION: recording",
   "adjreclat",
   "adjrecmanlatin",
   "diskcheck",

   "diskcheckmb",
   "manuallat",
   "manuallatin",

   "maxrecsize",
   "maxrecsize_use",
   "peakrecbm",

   "promptendrec",
   "recfile_wildcards",
   "recopts",

   "recupdatems",
   "showrecitems",
   "zoomshowarm",

   -- render to File
   "SECTION: render to File",
   "rendermetadataflags",
   "renderpeaks",
   "renderqdelay",

   -- rendering
   "SECTION: rendering",
   "renderbsnew	rendertail",

   -- rewire/DX
   "SECTION: rewire/DX",
   "disabledxscan",
   "usedxplugs",
   "userewire",

   -- scrub/Jog
   "SECTION: scrub/Jog",
   "scrubloopend",
   "scrubloopstart",
   "scrubmode",

   "scrubrelgain",

   -- scrubg/Jog
   "SECTION: scrubg/Jog",
   "scrubgain",

   -- seeking
   "SECTION: seeking",
   "itemeditpr",
   "loopselpr",
   "seekmodes",

   "smoothseek",
   "smoothseekmeas",

   -- snap/grid
   "SECTION: snap/grid",
   "relsnap",

   -- system
   "SECTION: system",
   "__fx_loadstate_ctx",
   "__metronome_ptr",
   "__numcpu",

   "__reascript_runcnt",

   -- track Control Panels
   "SECTION: track Control Panels",
   "groupdispmode",
   "pandispmode",
   "slidermaxv",

   "sliderminv",
   "slidershex",
   "tcpalign",

   "tinttcp",

   -- track Meters
   "SECTION: track Meters",
   "grvuscale",
   "nometers",
   "resetvuplay",

   "vuclipstick",
   "vudecay",
   "vumaxvol",

   "vuminvol",
   "vuupdfreq",

   -- track/Send Defaults
   "SECTION: track/Send Defaults",
   "defautomode",
   "defenvs",
   "defhwvol",

   "defsendflag",
   "defsendvol",
   "deftrackrecflags",

   "deftrackrecinput",
   "deftrackvol",
   "defvzoom",

   "newtflag",
   "volenvrange",

   -- transport
   "SECTION: transport",
   "transflags",

   -- vst
   "SECTION: vst",
   "ara",
   "vst_scan",
   "vstfullstate",

   -- video
   "SECTION: video",
   "bpminfnimport",

   -- video/REX/Misc
   "SECTION: video/REX/Misc",
   "acidimport",
   "reximport",
   "video_colorspace",

   "video_decprio",
   "video_defimglen",
   "video_delayms",

   -- view Menu
   "SECTION: view Menu",
   "fadeeditflags",
   "fadeeditlink",
   "fadeeditpostsel",

   "fadeeditpresel",

   -- zoom/Scroll/Offset
   "SECTION: zoom/Scroll/Offset",
   "envvzoomscale",
   "itemoverlap_offspct",
   "maxvzoom",

   "vscrollflag",
   "vscrollstep",
   "vscrollstep2",

   "vzoommode",
   "zoommode",

   -- PROJECT SETTINGS
   "SECTION: PROJECT SETTINGS",
   -- advanced
   "SECTION: advanced",
   "feedbackmode",
   "itemmixflag",
   "panlaw",

   "panlawflags",
   "panmode",
   "projmaxlen",

   "projmaxlenuse",
   "projsmpteahead",
   "projsmptefw_rec",

   "projsmpteinput",
   "projsmptemaxfree",
   "projsmpteoffs",

   "projsmpterate",
   "projsmpterateuseproj",
   "projsmpteresync",

   "projsmpteresync_rec",
   "projsmpteskip",
   "projsmptesync",

   "silenceflags",
   "silencethreshdb",

   -- context Menu
   "SECTION: context Menu",
   "mixrowflags",

   -- media
   "SECTION: media",
   "afxcfg",
   "projdefrecpath",
   "projrecforopencopy",

   -- misc
   "SECTION: misc",
   "vzoom2",
   "vzoom3",
   "zoom",

   -- notes
   "SECTION: notes",
   "opennotes",

   -- options Menu
   "SECTION: options Menu",
   "autoxfade",
   "loopgran",
   "loopgranlen",

   "pooledenvattach",
   "projgriddiv",
   "projgriddivsnap",

   "projgridframe",
   "projgridmin",
   "projgridsnapmin",

   "projgridswing",
   "projgroupover",
   "projtakelane",

   -- project Settings
   "SECTION: project Settings",
   "defpitchcfg",
   "defstretchmode",
   "itemtimelock",

   "playresamplemode",
   "projalignbeatsrate",
   "projbeatbase",

   "projbpm",
   "projintmix",
   "projmasternch",

   "projmeaslen",
   "projmeasoffs",
   "projmeasoffsruler",

   "projsrate",
   "projsrateuse",
   "projtimeoffs",

   "projtsdenom",
   "tempoenvtimelock",

   -- project
   "SECTION: project",
   "projrelpath",

   -- render to File
   "SECTION: render to File",
   "projrenderaddtoproj",
   "projrenderbrickwall",
   "projrenderdither",

   "projrenderfadein",
   "projrenderfadeinshape",
   "projrenderfadeout",

   "projrenderfadeoutshape",
   "projrenderlimit",
   "projrendernch",

   "projrendernorm",
   "projrendernormtgt",
   "projrenderpadend",

   "projrenderpadstart",
   "projrenderqdelay",
   "projrenderrateinternal",

   "projrenderresample",
   "projrendersrate",
   "projrenderstems",

   "projrendertrimend",
   "projrendertrimstart",
   "rendercfg",

   "renderclosewhendone",
   "rendertaillen",
   "rendertails",

   -- ruler Context Menu
   "SECTION: ruler Context Menu",
   "projtimemode",

   -- track context menu
   "SECTION: track context menu",
   "projtrackgroupdisabled",

   -- transport
   "SECTION: transport",
   "playrate",
   "projtimemode2",

   -- video
   "SECTION: video",
   "projfrbase",
   "projfrdrop",
   "projvidflags",

   "projvidh",
   "projvidw",

   -- misc
   "SECTION: misc",

   "audioprshift",
   "loop",
   "mastermutesolo",

   "projgroupsel",
   "projmasterpanlaw",
   "projmasterpanlawflags",

   "projmasterpanmode",
   "projmastervuflags",
   "projmetrobeatlen",

   "projmetroclick",
   "projmetrocountin",
   "projmetroen",

   "projmetrof1",
   "projmetrof2",
   "projmetropattern",

   "projmetrov1",
   "projmetrov2",
   "projpeaksgain",

   "projrecmode",
   "projripedit",
   "projripeditcfg",

   "projsellock",
   "projshowgrid",
   "psmaxv",

   "psminv",

   -- REAPER INI ONLY
   "SECTION: REAPER INI ONLY",
   -- reaper
   "SECTION: reaper",
   "REAPER->autoclosekeymap",
   "REAPER->pspage_last",

   -- reaper_video
   "SECTION: reaper_video",
   "reaper_video->fx_mode",
   "reaper_video->misc_flags",
   "reaper_video->playback_cache",

   "reaper_video->smp",
   "reaper_video->vdprefetch_srcs",
   "reaper_video->vdprefetch_threads",

   "reaper_video->visible",

   -- TRANSPORT
   "SECTION: TRANSPORT",
   "hwoutfx_bypass",

	-- UNKNOWN
   "SECTION: UNKNOWN",

   "ctrlcopyitem",
	"disk_rdmodeexmac",
	"itemdblclk",

	"itemprops",
	"itemprops_timemode",
	"loudgraph_alpha",

	"loudpeak_alpha",
	"mousemovemod",
	"nativedrawtext2",

	"newfnopt",
	"osxnomiddlemancocoa",
	"projmidieditor",

	"projrenderpadin",
	"projrenderpadout",
	"projrendertrimthreshin",

	"projrendertrimthreshout",
	"rendermastertracksub",
	"renderprvwvol",

	"rightclickemulate",
	"selitemtop",
	"smmaxsz",

	"smmaxsz_pct",
	"tempoenvsnap",
	"titlebarreghide",

	"tsmarker",
	"vstbr32",
	"vstfolder_settings",

	-- USER INTERFACE
	"SECTION: USER INTERFACE",
	"fullscreenrectb",
	"fullscreenrectl",
	"fullscreenrectr",

	"fullscreenrectt",
	"isfullscreen",
}

file = io.open(os.getenv("HOME") .. "/Desktop/reaper_variables.txt", "w+")
file:write("List of variables:\n")
for k, v in pairs(vars) do
   -- msg(v)

   if (string.starts(v, "SECTION")) then
	  file:write("\n" .. v .. "\n-----\n")
   else
	  retval, buf = reaper.get_config_var_string(v)
	  file:write(v .. " - " .. tostring(retval) .. " - " .. buf .. "\n")
   end
end
file:close()
