state("Fable Anniversary") {
	int questsCompleted : 0x322FD00, 0x6C, 0x44, 0x14, 0xc4;
	int isLoading : 0x322139C, 0x1DC, 0x130;
}

startup {
	vars.quests = new string[] {
		"",
		"Guild Training/Childhood PACKAGE DEAL",
		"Wasp Menace/Beetles PACKAGE DEAL",
		"Talk to Maze in Bowerstone South",
		"Orchard Farm",
		"Trader Escort",
		"Talk to Maze in Oakvale",
		"Find the Bandit Seeress",
		"Talk to Maze in the Guild",
		"Find the Archaeologist",
		"White Balverine",
		"Arena",
		"Talk to Theresa at the Gray House",
		"Rescue the Archaeologist",
		"Graveyard Path",
		"Imprisoned!",
		"Prison Escape",
		"Gateway to Hook Coast (Book in Maze's Tower)",
		"Return to Hook Coast (Kill Maze)",
		"Try to Stop Jack of Blades",
		"Battle Jack of Blades",
		"Prophets of the Fire Heart",
		"Ship of the Drowned",
		"Necropolis",
		"Talk to Scythe in Snowspire",
		"Collecting an Arena Soul",
		"Collecting a Heroine's Soul",
		"Collecting the Oldest Soul",
		"Souls of Heroes (Open the Bronze Gate)",
		"The Final Battle"
	};
	for (int i = 1; i <= 29; i++) {
		settings.Add("split"+i, true, vars.quests[i]);
	}
	vars.inLoad = false;
}

isLoading {
	return current.isLoading > 0;
}

split {
	return old.questsCompleted < current.questsCompleted && settings["split"+current.questsCompleted];
}