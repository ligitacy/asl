state("KidGame") {
	bool loading : 0x3C44CF8;
}

isLoading {
	return current.loading;
}
