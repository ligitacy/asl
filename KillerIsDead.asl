state("KidGame") {
	//playable is false when we're in a full loading screen or episode intro (including the few anime intros, like before e6)
	bool playable 			: 0x03C44CF8;
	//MissionData is a 0x38 byte struct in an array. We are interested in indexes 0 through 0x15 of that array. 0x38 * 0x16 is 1232 decimal
	byte1232 missionData 	: 0x03DB83B8, 0xC, 0x1A0, 0x48, 0x404, 0x34;
	
}

isLoading {
	//this doesn't work for streaming loads (like the load between Episode 3 and the Alice boss)
	//nor for loads that only show the bloodstain on the right
	//this only supports full loading screens, as well as the episode intro (which isn't a load but w/e)
	return !current.playable;	
}

startup {
	vars.structSize = 0x38; //size of each struct
	vars.easyOffset = 0x18; //offset of "cleared by difficulty" inside each struct

	vars.keyMissions = new int[] {0, 1, 2, 4, 5, 6, 9, 13, 14, 17, 20};	//positions of key missions inside global missiondata array
	//values found by decompilation with unreal engine explorer
	
	//add all episodes to settings
	for (int i = 0; i < vars.keyMissions.Length; i++) {
		settings.Add( ("e" + i), 
					true, 
					("Episode " + (i+1)) );
	}
	
	vars.nextMission = 0;
	
	vars.prevPhase = timer.CurrentPhase;	//initialize our phase reading - we need to do actions OnReset() which is not yet supported
	
	vars.framecount = 0; //DEBUG LINE
}

update {
	//reset next mission to 0 if the timer has stopped running.
	if (vars.prevPhase != timer.CurrentPhase && timer.CurrentPhase == TimerPhase.NotRunning) { //OnReset
		vars.nextMission = 0;
	}
	vars.prevPhase = timer.CurrentPhase;
	
	vars.framecount += 1;  //use in debug messages with % (arbitrary num) to stop spam

}

reset {
	if (current.missionData[0x14] != old.missionData[0x14] && current.missionData[0x14] == 0x02) {
		vars.nextMission = 0; //update wont run between resetting and starting, so do this here too
		return true;
	}
}

start {
	if (current.missionData[0x14] != old.missionData[0x14] && current.missionData[0x14] == 0x02) {
		return true;
	}
}

split {
	//skip missions that are not activated in settings.
	while (vars.nextMission <= vars.keyMissions.Length && !settings["e" + vars.nextMission]) {
		vars.nextMission += 1;
	}
	//this specifically happens once we hit episode 12.  We do not split episode 12 this way.
	if (vars.nextMission >= vars.keyMissions.Length) {
		return false; //something went wrong, shouldnt split
	}
	//which struct in the global MissionData array we want to target
	int structIndex = vars.keyMissions[vars.nextMission];
	//offset from missionData[0] where the mission clear data for the next mission is
	int offset = vars.structSize * structIndex + vars.easyOffset;
	//check each difficulty
	//though these are bools they are padded to four bytes, so we skip by four
	for (int dif = 0; dif <= 4; dif++) {
		//2nd condition prevents rapid splitting between starting new run and deletion of old save
		if (current.missionData[offset + dif*4] > 0 
			&& current.missionData[offset + dif*4] != old.missionData[offset + dif*4]) {
			vars.nextMission += 1; //look at the next mission from now on
			return true;
		}
	}
	return false;
}
