state("Fable")
{
	bool isLoading: 0x00FB8794, 0x8, 0x17C, 0x8, 0xC, 0x128;
	uint gameProgress: 0xFBAE30;
	uint autosave1: 0xFB89C0;
	uint autosave2: 0xFB89E0;
	uint autosave3: 0xFB89E4;
	uint isPortingOrFadingIn: 0x007D7148, 0xC;
	//Still looking for quests completed value.
}

startup
{
	settings.Add("autosave", true, "AUTOSAVE REMOVAL (BETA)");

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
	
	settings.Add("gypath", false, "Graveyard Path (NONFUNCTIONAL)");
	settings.Add("imprisoned", false, "Imprisoned! Caught by Jack (NONFUNCTIONAL)");
	
	settings.Add("split36", true, "Prison Escape");
	settings.Add("split39", true, "Return to Hook Coast");
	settings.Add("split43", true, "Try to Stop Jack of Blades");
	settings.Add("split47", true, "Kill Jack.  A poem by Tiny Tina.");
	settings.Add("split48", true, "Prophets of the Fire Heart");
	settings.Add("split51", true, "Ship of the Drowned");
	settings.Add("split52", true, "Oracle of Snowspire [Autosplit occurs when returning to Scythe]");
	
	settings.Add("soul25", false, "Collecting an Arena Soul (NONFUNCTIONAL)");
	settings.Add("soul26", false, "Collecting a Heroine Soul (NONFUNCTIONAL");
	settings.Add("soul27", false, "Collecting the Oldest Soul (NONFUNCTIONAL)");
	
	settings.Add("split53", true, "The Souls of Heroes");
}

split
{
	if (current.gameProgress != old.gameProgress) {
		return settings["split"+current.gameProgress];
	} else if (current.gameProgress == 0x23) {	//Between Rescue Arch and end of Prison
		//GY Path: 
		//Split when quest completed stat increases (find value before and after) B/A 13/14
		
		
		//Imprisoned
		//Same dealio as above.
	} else if (current.gameProgress == 0x52) {
		//Split between 24/25 (Thunder), 25/26 (Briar), and 26/27 (GM) quests completed.
		//if current.questsCompleted != old.questsCompleted return settings["soul"+current.questsCompleted];
	} else if (current.gameProgress == 0x53) {
		//Split between 27/28 quests completed.
		//return current.questsCompleted == 28 && old.questsCompleted == 27
	}
	return false;
}

isLoading
{
	var autosaving = (current.autosave1 > 0 
			|| current.autosave2 > 0
			|| current.autosave3 > 0)
			&& settings["autosave"];
	var loading = current.isLoading && !current.isPortingOrFadingIn;
	return autosaving || current.isLoading;
}