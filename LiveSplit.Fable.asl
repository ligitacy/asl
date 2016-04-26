state("Fable")
{
	bool isLoading: 0x00FB8794, 0x8, 0x17C, 0x8, 0xC, 0x128;

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
	//if (current.isLoading) {
	//	print("Loading");
	//}
	return current.isLoading;
}

gameTime
{
}