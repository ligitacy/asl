state("defiance") {
	int x : 				0x14d4d8;
	int y : 				0x14d4dc;
	string15 cell : 		0x330bc4;
	int bossHp :			0x20182c,	0x194;
}

startup {
	vars.startZone = "sholdla";
	vars.startX = -3621.2f;
	vars.startY = -1271.6f;
	vars.leniency = 1.0f;
	vars.moved = (start, now) => ((start + leniency < now) || (start - leniency > now));
	vars.splits = {
		"eldergodla",
		"cemetaryla",
		"CITADEL10A",
		"CITADEL14A",
		"SNOW_PILLARS10A",
		"pillars9a",
		"CIT_EARLY1A",
		"citadel6A"
	};
	vars.currentSplit = 0;

	vars.start = false;

	settings.Add("split0", true, "Enter the Underworld");
	settings.Add("split1", true, "Escape done");
	settings.Add("split2", true, "Light forge warpgate");
	settings.Add("split3", true, "Dark forge warpgate");
	settings.Add("split4", true, "Chapter 4 done");
	settings.Add("split5", true, "Kain pillars done");
	settings.Add("split6", true, "Raz pillars done");
	settings.Add("split7", true, "Final boss start");
	settings.Add("bossdead", true, "Final boss dead");
}

update {
	vars.start = 	( (current.cell == vars.startZone) &&
						( 
							(vars.moved(vars.startX, current.x) && !vars.moved(vars.startX, old.x)) ||
							(vars.moved(vars.startY, current.y) && !vars.moved(vars.startY, old.y))
						)
					);
	//above: start the timer if we're in the start zone, and we newly moved in either the x or y direction

	if (timer.CurrentPhase == TimerPhase.NotRunning || vars.start) {
		vars.currentSplit = 0;
	}
}

split {
	if (vars.currentSplit < vars.splits.Length) {
		if ((current.cell == vars.splits[vars.currentSplit]) &&
			(current.cell != old.cell)) {
			return settings["split"+(vars.currentSplit++)];
		}
	} else {
		return (current.bossHp == 0) && (current.bossHp != old.bossHp);
	}
}

reset {
	return vars.start;
}

start {
	return vars.start;
}