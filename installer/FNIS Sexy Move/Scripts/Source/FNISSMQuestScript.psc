Scriptname FNISSMQuestScript extends Quest Conditional

; -------------------------------------------------------------------------------------------------
; Properties
; -------------------------------------------------------------------------------------------------

int Property FNISaaCRC Auto
int Property FNISs3ModID Auto		; Animations for 360 pack
int Property FNISs3MtBase Auto		; -1: 360 pack not installed
int Property FNISs3MtxBase Auto
int Property FNISsmModID Auto		; Standard animations
int Property FNISsmMtBase Auto
int Property FNISsmMtxBase Auto
Quest Property FNISSMQuest2 Auto
Quest Property MQ101 Auto

; Configuration parameters (default here, updated by FNISSMConfigMenue)
Bool Property isConfigChangedNPC Auto
Bool Property SM360 = true Auto
Bool Property SMarmor Auto
Bool Property SMdialog Auto Conditional
Bool Property SMnocoin Auto
Bool Property SMoff Auto
Bool[] Property SMno Auto
Int Property iSMplayer = 4 Auto
Int Property iSMweight = 1 Auto
Int Property SMnoTotal Auto
Int Property StartUpStatus Auto Conditional	; 0: OnInit/OnPlayerLoadGame 1: StartUp executed OK -1: StartUp with errors

; update values
bool Property isCellLoaded Auto	; check cell
int Property AliasCount Auto	; alias fill count


; -------------------------------------------------------------------------------------------------
; Variables
; -------------------------------------------------------------------------------------------------

bool SMQuest2Started
int iOff = 0					; count how often FNIS SM is turned off
int iUpdate = 0					; count the updates until next search for un-esmified females


; move distribution (number and percentages)
int nAnims			; no of used animations (excluding the default animation)
int[] AnimIndex		; used Animations
int[] pAll			; percentage distribution (all females)
int[] pArmor		; pd (armored females)
int[] pOld			; pd (old females)


; -------------------------------------------------------------------------------------------------
; Events
; -------------------------------------------------------------------------------------------------

Event OnInit()
	; Execution Delay.
	Utility.Wait(14.0)

	If !self.isRunning()		; if quest isn't started, despite being "start game enabled"
		self.Start()
		return
	endIf

	if !RequirementsAreMet()
		StartUpStatus = -1
		return
	endif

	StartUpStatus = 1
	SMno          = new bool[10]
	SMno[1]       = True
	SMnoTotal     = 1
	AnimIndex     = new int[10]
	pAll          = new int[10]
	pArmor        = new int[10]
	pOld          = new int[10]

	Debug.Notification("FNIS SexyMove started.")

	FNISsmModID = FNIS_aa.GetAAModID("fsm", "FNIS Sexy Move", true)
	FNISsmMtBase = FNIS_aa.GetGroupBaseValue(FNISsmModID, FNIS_aa._mt(), "FNIS Sexy Move", true)
	FNISsmMtxBase = FNIS_aa.GetGroupBaseValue(FNISsmModID, FNIS_aa._mtx(), "FNIS Sexy Move", true)
	FNISs3ModID = FNIS_aa.GetAAModID("fs3", "FNIS Sexy Move (360)", true)

	if (FNISs3ModID >= 0)		; 360 pack installed
		FNISs3MtBase = FNIS_aa.GetGroupBaseValue(FNISs3ModID, FNIS_aa._mt(), "FNIS Sexy Move(360)", true)
		FNISs3MtxBase = FNIS_aa.GetGroupBaseValue(FNISs3ModID, FNIS_aa._mtx(), "FNIS Sexy Move(360)", true)
	endif

	FNISaaCRC = FNIS_aa.GetInstallationCRC()
	RegisterForSingleUpdate(2.0)
	InitializeNPC()

	Utility.Wait(1)

	; Apply initial animation state.
	If (Game.GetPlayer().GetLeveledActorBase().GetSex() == 1)
		int camState = Game.GetCameraState()
		Game.ForceThirdPerson()
		bool bOk
		if (iSMPlayer == 0)
			bOk = FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mt", 0, 0, "FNIS Sexy Move", true)
			bOk = bOk && FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mtx", 0, 0, "FNIS Sexy Move", true)
		else
			if SM360
				bOk = FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mt", FNISs3MtBase, iSMPlayer - 1, "FNIS Sexy Move(360)", true)
				bOk = bOk && FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mtx", FNISs3MtxBase, iSMPlayer - 1, "FNIS Sexy Move(360)", true)
			else
				bOk = FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mt", FNISsmMtBase, iSMPlayer - 1, "FNIS Sexy Move", true)
				bOk = bOk && FNIS_aa.SetAnimGroup(Game.GetPlayer(), "_mtx", FNISsmMtxBase, iSMPlayer - 1, "FNIS Sexy Move", true)
			endif
		endif
		if !bOk
			Debug.Trace("FNISSM - ERROR cannot set player animvar for group _mt/_mtx")
		endif

		If camState == 0
			Game.ForceFirstPerson()
		endIf
	endIf
EndEvent


Event OnUpdate()
	if SMQuest2Started
		FNISSMQuest2.Stop()
		SMQuest2Started = false
	endIf

	if (FNISsmMtBase == 0)
		; Something bad has happend (SM 1.x still running, FNIS not generated): don't continue.
		Debug.Notification("FNIS Sexy Move stopped working (clean save needed).")
		return
	endif

	; Check for females by starting Quest2.
	If !SMoff && !Game.GetPlayer().isInCombat() && (isCellLoaded || (iUpdate <= 0) || (AliasCount >= 5))
		; Re-initialize NPC animation parameters after configuration change.
		If isConfigChangedNPC
			InitializeNPC()
			isConfigChangedNPC = false
		endIf

		isCellLoaded = false
		iUpdate = 5
		AliasCount = 0
		bool bSucc = FNISSMQuest2.Start()
		SMQuest2Started = true
		RegisterForSingleUpdate(0.5)		; short update time (to stop or re-start quest2)
	else
		iUpdate -= 1
		RegisterForSingleUpdate(2.0)		; regular update time
	endIf

	If SMoff								; regular user notification if he has switched of esmifying
		iOff -= 1
		If iOff <= 0
			Debug.Notification("FNIS Sexy Move: NPC assignment switched off by user!")
			iOff = 50
		endIf
	endIf
endEvent


; -------------------------------------------------------------------------------------------------
; Functions
; -------------------------------------------------------------------------------------------------

; return a random animation idex according to NPC group and probability array
int Function getAnimIndex(int[] percentAr)
	int i = 1
	int ri = Utility.RandomInt(0,99)
	While i <= 9
		If percentAr[i] >= ri
			return i
		endIf
		i += 1
	endWhile
	return nAnims
endFunction


; no prior setting, no modder preset: determine a random animation
int Function getRandomAnimation(Actor akFemale)
	float AR = 0.0
	form fRace = akFemale.GetRace() as form
	Armor fArmor = akFemale.GetWornForm(0x00000004) as Armor
	If fArmor != none
		AR = fArmor.GetArmorRating()
	endIf
	If (fRace == Game.GetForm(0x00067cd8)) || (fRace == Game.GetForm(0x000a82ba))	;	(Vampire) Elder?
		return AnimIndex[getAnimIndex(pOld)]	; elder race
	ElseIf (AR > 1)
		return AnimIndex[getAnimIndex(pArmor)]	; armored NPC
	Else
		return AnimIndex[getAnimIndex(pAll)]	; all others
	endIf
endFunction


; initialize probability arrays for different NPC groups (elder, armored, rest) according to configuration
Function initializeNPC()
	string SpAll
	string SpArmor
	string SpOld
	int i

	; count activated walk animations
	nAnims = 0
	i = 1
	While i <= 9
		If !SMno[i]
			nAnims += 1
			AnimIndex[nAnims] = i
		endIf
		i += 1
	endWhile

	; initialize walk probability array (as string)
	If nAnims == 6
		SpAll   = "010,030,047,066,083,100,100,100,100"
		SpArmor = "030,060,080,100,100,100,100,100,100"
	ElseIf nAnims == 7
		SpAll   = "007,025,040,058,072,086,100,100,100"
		SpArmor = "025,050,075,090,100,100,100,100,100"
	ElseIf nAnims == 8
		SpAll   = "005,022,035,050,062,075,087,100,100"
		SpArmor = "020,040,065,075,090,100,100,100,100"
	Else	; If nAnims == 9
		SpAll   = "004,020,030,043,054,065,078,089,100"
		SpArmor = "020,040,055,070,085,095,100,100,100"
	endIf
	SpOld       = "060,090,100,100,100,100,100,100,100"

	; assign numeric probabilities, weighted according to configuration
	i = 1
	While i <= 9
		pAll[i] = StringUtil.Substring(SpAll, 4*i - 4, 3) as int
		If i < nAnims
			If (iSMweight == 0)
				pAll[i] = (pAll[i] * (1.0 + (1.0 * (nAnims - i) / nAnims ))) as int
			ElseIf ( iSMweight == 2)
				pAll[i] = (pAll[i] * (1.0 - (0.5 * (nAnims - i) / nAnims ))) as int
			endIf
		endIf
		If SMarmor
			pArmor[i] = StringUtil.Substring(SpArmor, 4 * i - 4, 3) as int
		Else
			pArmor[i] = pAll[i]
		endIf
		pOld[i] = StringUtil.Substring(SpOld, 4 * i - 4, 3) as int
		i += 1
	endWhile
endFunction


bool Function RequirementsAreMet()
	bool isGenerated = FNIS.isGenerated()
	string VersionToString = FNIS.VersionToString()
	bool isVersionOK = (FNIS.VersionCompare( 6, 0, 0 ) >= 0)
	bool isFNISesp = (Game.GetModByName("FNIS.esp") < 255)
	bool isSKSE = (SKSE.GetVersionRelease() > 0)
	if ! (isGenerated && isVersionOK && isSKSE && isFNISesp)
		string out = "FNIS Sexy Move stopped with ERROR(s):"
		if ! isVersionOK
			out = out + "\n- FNIS version " + VersionToString + " older than required."
		endif
		if ! isGenerated
			out = out + "\n- Last FNIS generation failed."
		endif
		if ! isFNISesp
			out = out + "\n- FNIS.esp not activated."
		endif
		if ! isSKSE
			out = out + "\n- SKSE not started."
		endif
		Debug.Messagebox(out)
		Debug.Trace(out)
		return false
	endif
	return true
endFunction
