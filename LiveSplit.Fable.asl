state("Fable")
{
	bool isLoading: 	0x00FB8794, 0x8, 0x17C, 0x8, 0xC, 0x128;
	uint gameProgress: 	0xFBAE30;	//see https://goo.gl/7x4wKE for information
	uint autosave1: 	0xFB89C0;
	uint autosave2: 	0xFB89E0;
	uint autosave3: 	0xFB89E4;
	uint isPortingOrFadingIn: 0x007D7148, 0xC; //random values when porting in or fading
	uint renown:		0xFB8A1C, 0x8C, 0x10, 0x44, 0x14, 0x78;
	uint gold:		0xFB8A1C, 0x8C, 0x10, 0x44, 0x14, 0x3C;
	int alignment:		0xFB8A1C, 0x8C, 0x10, 0x44, 0x14, 0x28; //mystery struct holds all the answers
	//Still looking for quests completed value.
}

startup
{
	settings.Add("split1", true, "Childhood");
	settings.Add("split9", true, "Guild Training");
	settings.Add("split12", true, "Wasp Queen");
	settings.Add("split16", true, "Protect/Attack Orchard Farm");
	settings.Add("split18", true, "Trader Escort");
	settings.Add("split22", true, "Find the Bandit Seeress");
	settings.Add("split25", true, "Find the Archaeologist");
	settings.Add("split29", true, "White Balverine");
	settings.Add("split30", true, "The Arena");
	settings.Add("split35", true, "Rescue the Archaeologist");
	
	settings.Add("gypath", true, "Graveyard Path");
	settings.Add("imprisoned", false, "Imprisoned! Caught by Jack");
	
	settings.Add("split36", true, "Prison Escape");
	settings.Add("split39", true, "Return to Hook Coast");
	settings.Add("split43", true, "Try to Stop Jack of Blades");
	settings.Add("split47", true, "Kill Jack.  A poem by Tiny Tina.");
	settings.Add("split48", true, "Prophets of the Fire Heart");
	settings.Add("split51", true, "Ship of the Drowned");
	settings.Add("split52", true, "Oracle of Snowspire [Autosplit occurs when returning to Scythe]");
	
	settings.Add("soul1", true, "Collecting an Arena Soul");
	settings.Add("soul2", true, "Collecting a Heroine Soul");
	settings.Add("soul3", true, "Collecting the Oldest Soul");
	
	settings.Add("split53", false, "The Souls of Heroes");
	
	settings.Add("mask", true, "The Final Battle");
	
	vars.didPath = false;
	vars.didImprisoned = false;
	vars.didSouls = 0;
	vars.shouldStart = false;
}

update {
	//a bunch of conditions to detect we just started the game
	//specifically, a bunch of stuff zeroes out and we finish loading an autosave
	bool gpCheck = current.gameProgress == 0;
	bool goldCheck = current.gold == 0;
	bool alignmentCheck = current.alignment == 0;
	bool oldAutosave = (old.autosave1 > 0 
			|| old.autosave2 > 0
			|| old.autosave3 > 0);
	bool curAutosave = (current.autosave1 > 0 
			|| current.autosave2 > 0
			|| current.autosave3 > 0);
	bool autosaveCheck = oldAutosave && !curAutosave;
	
	bool reset = gpCheck && goldCheck && alignmentCheck && autosaveCheck;
	if (reset 
		|| (timer.CurrentPhase == TimerPhase.NotRunning)) {
		//reset, zero out some internal state
		vars.didPath = false;
		vars.didImprisoned = false;
		vars.didSouls = 0;
	} 
	if (reset) { //pass this information onto other blocks
		vars.shouldStart = true;
	} else {
		vars.shouldStart = false;
	}
}

reset {
	return vars.shouldStart;
}

start {
	return vars.shouldStart;
}

split
{
	if (current.gameProgress != old.gameProgress) {
		return settings["split"+current.gameProgress];
	} else if (current.gameProgress == 35) {	//Between Rescue Arch and end of Prison
		//GY Path: 
		//Split when renown increases a lot
		if (current.renown >= old.renown + 200 
				&& settings["gypath"]
				&& !vars.didPath) {
			vars.didPath = true;
			return true;
		}
		
		//Imprisoned
		//Split when gold decreases to zero
		if (current.gold != old.gold && current.gold == 0 
				&& !vars.didImprisoned
				&& settings["imprisoned"]) {
			vars.didImprisoned = true;
			return true;
		}
		
	} else if (current.gameProgress == 52) {
		//three souls
		if (current.renown >= old.renown + 1000) {
			vars.didSouls++;
			if (vars.didSouls <= 3 && settings["soul"+vars.didSouls])
				return true;
		}
	} else if (current.gameProgress == 53) {
		if (current.gold >= old.gold + 10000) {
			return settings["mask"];
		}
	}
	return false;
}

isLoading
{
	var autosaving = (current.autosave1 > 0 
			|| current.autosave2 > 0
			|| current.autosave3 > 0);
	var loading = current.isLoading && !(current.isPortingOrFadingIn > 0);
	return autosaving || current.isLoading;
}
