state("Fable Anniversary") 
{
	//amount of quests
	int questsCompleted : 0x322FD00, 0x6C, 0x44, 0x14, 0xc4;
	//is loading zone tranfers (fade)
	bool isLoading : 0x322139C, 0x1DC, 0x130;
	//is loading save (fade)
	bool isLoadingSave: "Fable Anniversary.exe", 0x3230374, 0x08, 0x104;
	//is in loading screen(no fade) this is to fix an issue with high fps causing the timer to unpasue in loadings after loadwarps
	bool isInLoadinScreen: "Fable Anniversary.exe", 0x318911C;
	//prerendered movies
	bool isStarting: "Fable Anniversary.exe", 0x3232770;
	//x and z postion
	float startingX : "Fable Anniversary.exe", 0x322FD00, 0x6c, 0x44, 0x4, 0xc;
	float startingZ : "Fable Anniversary.exe", 0x322FD00, 0x6c, 0x44, 0x4, 0x10;
}

startup 
{
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
start 
{
	//checks players positions to see if you are at the start of the game
	if(current.startingX >= 3494 && current.startingX <= 3495 && current.startingZ >= 867 && current.startingZ <= 868)
	{
		//are you in a prerendered movie set as an int to only trigger once rather than though out the movie
		if(old.isStarting == false && current.isStarting == true)
		{
			return true;
		}
	}
}

isLoading 
{
	//checking to see if you are loading a zone transfer, loading a save, or are just in a loading screen
	return current.isLoading || current.isLoadingSave || current.isInLoadinScreen;
}

split 
{
	//dont split if you are loading a save
	if(!current.isLoadingSave){
		return old.questsCompleted < current.questsCompleted && settings["split"+current.questsCompleted];
	}
}
