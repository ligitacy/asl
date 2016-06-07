state("KidGame") {
	bool playable: 0x3C44CF8;
}

isLoading {
	return !current.playable;
}
