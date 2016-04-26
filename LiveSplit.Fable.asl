state("Fable")
{
	bool isLoading: 0x00FB8794, 0x8, 0x17C, 0x8, 0xC, 0x128;
	//uint gameProgress: 0xFBAE30;
	//uint autosave1: 0xFB89C0;
	//uint autosave2: 0xFB89E0;
	//uint autosave3: 0xFB89E4;
}

start
{
}

reset
{
}

split
{
}

isLoading
{
	/*
	bool autosaving = current.autosave1 > 0 
			|| current.autosave2 > 0
			|| current.autosave3 > 0;
	*/
	//return autosaving || current.isLoading;
	return current.isLoading;
}

gameTime
{
}
