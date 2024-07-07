
#SingleInstance Force

global MaxPerfectTries := 20   ; In Seconds

global FishingPromptLocation := [1120, 984]
global PerfectPromptLocation := [1200, 976]

global PromptColors := [0x333333, 0x3B3B3B, 0xBCBCBC, 0xBCBCBB, 0xC3C3C3, 0xFFFFFF ]

f3::
{
	bait := ""
	while(!isInteger(bait)) {
		input := InputBox("The script is now running.`nPress F4 to stop the script.`n`nHow much bait do you want to try and use:", "Auto Fishing", "", 500)
		if(input.Result = "Cancel")
			bait := 0
		else
			bait := input.value
	}
	if(bait>=0)
		startFishing(bait)
}
f4::
{
	MsgBox("The script has been stopped.", "Auto Fishing", "Iconi T2")
	Reload
}

startFishing(bait:= 500){
	current := 0
	while(current < bait){
		current++
		ToolTip(Format("Looking for Fishing Prompt: {1}/{2}...", current, bait), 10, 10)
		if (watchForFishingPrompt()){
			ToolTip(Format("Fishing with bait: {1}/{2}...", current, bait), 10, 10)
			castLine()
			if (watchForPerfect())
				Send "{e}"
			else{
				ToolTip("Was unable to catch fish after 20 seconds.")
				Sleep(1000)
			}
		}
	}
	
	ToolTip(Format("Done Fishing with {1} bait(s).", bait), 10, 10)
}

watchForFishingPrompt(){
	global

	loop {
		Color := PixelGetColor(FishingPromptLocation[1], FishingPromptLocation[2])
		ToolTip(Format("Colour: {1}", Color), 10, 30, 2) ; DEBUG
		if (HasVal(PromptColors, Color))
			return true
		Sleep(1000)
	}
}

castLine(){
	Send "{e Down}"
	Sleep 750
	Send "{e Up}"
}

watchForPerfect(){
	global

	looping := true
	tries := 0
	loop MaxPerfectTries * 100 {
		Color := PixelGetColor(PerfectPromptLocation[1], PerfectPromptLocation[2])	
		ToolTip(Format("Colour: {1}", Color), 10, 30, 2) ; DEBUG
		if (HasVal(PromptColors, Color)) {
			return true
		}
		Sleep 10
	}
	return false
}

HasVal(haystack, needle) {
	for index, value in haystack
		if (value = needle)
			return true
	return false
}