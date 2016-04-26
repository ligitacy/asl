state("Fable")
{
	bool isLoading: 0x00FB8794, 0x8, 0x17C, 0x8, 0xC, 0x128;
	uint gameProgress: 0xFBAE30;
	uint autosave1: 0xFB89C0;
	uint autosave2: 0xFB89E0;
	uint autosave3: 0xFB89E4;
}

startup
{
	settings.Add("autosave", true, "AUTOSAVE REMOVAL (BETA)");

	settings.Add("childhood", true, "Childhood");
	settings.Add("guildtraining", true, "Guild Training");
	settings.Add("waspqueen", true, "Wasp Queen");
	settings.Add("orchardfarm", true, "Protect/Attack Orchard Farm");
	settings.Add("traderescort", true, "Trader Escort");
	settings.Add("banditseeress", true, "Find the Bandit Seeress");
	settings.Add("arch1", true, "Find the Archaeologist");
	settings.Add("whitebalverine", true, "White Balverine");
	settings.Add("arena", true, "The Arena");
	settings.Add("arch2", true, "Rescue the Archaeologist");
	settings.Add("gypath", false, "Graveyard Path");
	settings.Add("imprisoned", true, "Imprisoned! Caught by Jack");
	settings.Add("prisonescape", true, "Prison Escape");
	settings.Add("hookcoast2", true, "Return to Hook Coast");
	settings.Add("stopjack", true, "Try to Stop Jack of Blades");
	settings.Add("killjack", true, "Kill Jack.  A poem by Tiny Tina.");
	settings.Add("fireheart", true, "Prophets of the Fire Heart");
	settings.Add("ship", true, "Ship of the Drowned");
	settings.Add("oracle", true, "Oracle of Snowspire");
	settings.Add("arenasoul", true, "Collecting an Arena Soul");
	settings.Add("heroinesoul", true, "Collecting a Heroine Soul");
	settings.Add("oldestsoul", true, "Collecting the Oldest Soul");
}

start
{
}

reset
{
}

split
{
	if (current.gameProgress != old.gameProgress) {
		switch (current.gameProgress) {
			case 0x1:
				return settings["childhood"];
			case 0x9:
				return settings["guildtraining"];
			case 0xC:
				return settings["waspqueen"];
			case 0x10:
				return settings["orchardfarm"];
			case 0x12:
				return settings["traderescort"];
		}
	}
}

isLoading
{
	var autosaving = false;
	if (settings["autosave"]) {
		autosaving = current.autosave1 > 0 
			|| current.autosave2 > 0
			|| current.autosave3 > 0;
	}
	return autosaving || current.isLoading;
}

gameTime
{
}