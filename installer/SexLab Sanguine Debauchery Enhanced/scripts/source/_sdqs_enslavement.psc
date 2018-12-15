Scriptname _SDQS_enslavement extends Quest Conditional
{ USED }
Import Utility

_SDQS_functions Property funct  Auto
_SDQS_fcts_constraints Property fctConstraints  Auto
_SDQS_fcts_inventory Property fctInventory  Auto
_SDQS_fcts_outfit Property fctOutfit  Auto
_SDQS_fcts_factions Property fctFactions  Auto
_SDQS_fcts_slavery Property fctSlavery  Auto

DialogueFollowerScript Property companionDialogue  Auto

Quest Property _SDQP_enslavement  Auto

GlobalVariable Property _SDGVP_enslaved  Auto  
GlobalVariable Property _SDGVP_positions  Auto  
GlobalVariable Property _SDGVP_demerits  Auto  
GlobalVariable Property _SDGVP_demerits_join  Auto  
GlobalVariable Property _SDGVP_gametime  Auto  
GlobalVariable Property _SDGVP_buyout  Auto Conditional
GlobalVariable Property _SDGVP_buyoutEarned  Auto Conditional
GlobalVariable[] Property _SDGVP_config  Auto  
GlobalVariable Property _SDGVP_stats_enslaved  Auto  
GlobalVariable Property _SDGVP_state_joined  Auto  
GlobalVariable Property _SDKP_trust_hands Auto
GlobalVariable Property _SDKP_trust_feet Auto
GlobalVariable Property _SDGV_leash_length Auto
GlobalVariable Property _SDGVP_punishments  Auto  
GlobalVariable Property _SDGVP_snp_busy Auto
GlobalVariable Property GameHour Auto

SexLabFramework Property SexLab  Auto  


ReferenceAlias Property _SDRAP_master  Auto
ReferenceAlias Property _SDRAP_slave  Auto
ReferenceAlias Property _SDRAP_bindings Auto
ReferenceAlias Property _SDRAP_shackles Auto
ReferenceAlias Property _SDRAP_collar Auto
ReferenceAlias Property _SDRAP_key Auto
ReferenceAlias Property _SDRAP_crop Auto

FormList Property _SDFLP_allied  Auto
FormList Property _SDFLP_slaver  Auto
FormList Property _SDFLP_punish_items  Auto
FormList Property _SDFLP_ignore_items  Auto
FormList Property _SDFLP_sex_items  Auto
FormList Property _SDFLP_master_items  Auto

Keyword Property _SDKP_sex  Auto  
Keyword Property _SDKP_wrists  Auto  
Keyword Property _SDKP_ankles  Auto  
Keyword Property ActorTypeNPC  Auto  
Keyword Property _SDKP_enslave  Auto

Quest Property WEBountyCollectorQST  Auto
Faction Property _SDFP_bountyhunter  Auto

Faction Property _SDFP_spriggan  Auto  
Spell Property _SDSP_spriggan_heal  Auto
ActorBase Property _SDABP_sprigganhost  Auto
Actor Property _SDAP_sanguine  Auto  

GlobalVariable Property _SDGVP_state_housekeeping  Auto  



Faction Property _SDFP_slaverCrimeFaction  Auto 
GlobalVariable Property _SDGVP_config_verboseMerits  Auto
GlobalVariable Property _SDGVP_trust_hands  Auto  
GlobalVariable Property _SDGVP_trust_feet  Auto  
ReferenceAlias[] Property _SDRAP_companions Auto
Armor Property _SDA_bindings  Auto  

ReferenceAlias Property _SDRAP_playerStorage  Auto  
ReferenceAlias Property _SDAP_clothing  Auto  


Bool Property bEscapedSlave = False Auto Conditional
Bool Property bSearchForSlave = False Auto Conditional
Bool Property bJoinedFaction = False Auto Conditional
Bool Property bQuestActive = False Auto Conditional
Bool Property bOriginallyEnemies = False Auto Conditional
Float Property fTimeEnslaved = 0.0 Auto Conditional
Int Property uiPunishmentsEarned = 0 Auto Conditional
Float fPunishmentsLength = 0.0  
Int Property uiLastDemerits = 0 Auto Conditional
Int Property uiHighestDemerits = 0 Auto Conditional
Int Property uiLowestDemerits = 0 Auto Conditional
Float Property ufMedianDemerits = 0.0 Auto Conditional
Float Property ufBindingsHealth = 10.0 Auto Conditional

Float fRFSU = 0.5
Float fRFSUGT = 3.0
Float fEnslavementStart = 0.0
Float kneelingDistance
Int trust

Float fFadeOutTime = 30.0

Actor kMaster
Actor kSlave

Int iGold = 0
Int iDemerits

Faction kCrimeFaction

; ObjectReference akRef1 = master
; ObjectReference akRef2 = slave
Event OnStoryScript(Keyword akKeyword, Location akLocation, ObjectReference akRef1, ObjectReference akRef2, int aiValue1, int aiValue2 )
	; ObjectReference shackles = _SDRAP_shackles.GetReference() as ObjectReference
	; ObjectReference bindings = _SDRAP_bindings.GetReference() as ObjectReference
	; ObjectReference collar = _SDRAP_collar.GetReference() as ObjectReference

	kMaster = akRef1 as Actor
	kSlave = akRef2 as Actor

	Debug.Trace("[SD] Receiving enslavement story.")
 	Debug.Trace("_SDQS_enslavement:: bQuestActive == " + bQuestActive)

	If ( !bQuestActive )
		Debug.Trace("[SD] Starting enslavement story.")
		bQuestActive = True		

		; _SDGVP_demerits.SetValueInt( aiValue1 )

		; ---------------------------------------------------------------------------
		EnslavePlayer(kMaster, kSlave, _SDGVP_config[3].GetValue() as Bool)
		; ---------------------------------------------------------------------------


		SetObjectiveDisplayed( 0 )
		if (StorageUtil.GetIntValue(kMaster, "_SD_iMasterIsCreature")==0)
			SetObjectiveDisplayed( 1 )
			; SetObjectiveDisplayed( 2 )
			SetObjectiveDisplayed( 6 )
		EndIf

		; If ( Self )
		;	RegisterForSingleUpdate( fRFSU )
		;	RegisterForSingleUpdateGameTime( fRFSUGT )
		; EndIf
	ElseIf ( _SDGVP_config[0].GetValue() )
;		kSlave.GetActorBase().SetEssential( False )
		Debug.Trace("[SD] Aborting enslavement story - already active.")
	EndIf

EndEvent
 

ObjectReference Function GetSlave()
	Return kSlave as ObjectReference
EndFunction

ObjectReference Function GetMaster()
	Return kMaster as ObjectReference
EndFunction

Function EnslavePlayer(Actor akMaster, Actor akSlave, Bool bHardcoreMode = False)
	ObjectReference kRags = _SDAP_clothing.GetReference() as  ObjectReference 
	ActorBase akActorBase  

	_SDGVP_buyout.SetValue( (_SDGVP_buyout.GetValue() as Int)  - 100 + Utility.RandomInt(0,500) )
	_SDGVP_demerits_join.SetValue(  - 20 - 10 * (4 - (kMaster.GetAV("morality") as Int) ) )
	_SDGV_leash_length.SetValue(400)
	_SDGVP_stats_enslaved.Mod( 1.0 )
	_SDGVP_enslaved.SetValue(1)	   

	fEnslavementStart = GetCurrentGameTime()

	kMaster = akMaster
	kSlave = akSlave

	kCrimeFaction = kMaster.GetCrimeFaction()
	akActorBase = kMaster.GetLeveledActorBase() as ActorBase

	SendModEvent("dhlp-Suspend")
	SendModEvent("da_PacifyNearbyEnemies","Restore")

	StorageUtil.SetIntValue(kSlave, "_SD_iEnslavementInitSequenceOn",1)

	Debug.Trace("[SD] You submit to a new owner.")
	if (StorageUtil.GetIntValue(kMaster, "_SD_iForcedSlavery")==0)
		Debug.Notification("You submit to a new owner.")
	Else
		Debug.Notification("Your new owner defeated you.")
	Endif

	; Drop current weapon - Do this first to prevent camera stuck in combat mode
	if(kSlave.IsWeaponDrawn())
		kSlave.SheatheWeapon()
		Utility.Wait(1.0)
	endif

	fctConstraints.actorCombatShutdown( kSlave )
	; fctConstraints.togglePlayerControlsOff( )

	; a new slave into a slaver faction
	; If ( aiValue2 == 1 )
		; transfer of ownership
	fctFactions.syncActorFactionsByRace( kMaster, kSlave, _SDFLP_allied ) 
	fctFactions.syncActorFactions( kMaster, kSlave, _SDFLP_allied )

	; Force enslavement of followers - Sync factions

	; Else
	;	bOriginallyEnemies = fctFactions.allyToActor( kMaster, kSlave, _SDFLP_slaver, _SDFLP_allied )
	; EndIf

	fctSlavery.StartSlavery( kMaster, kSlave)

	Debug.Trace("[SD] Your new owner strips you naked.")
	Debug.Notification("Your new owner strips you naked.")

	SexLab.StripActor( kSlave, DoAnimate= false)

	Debug.Trace("[SD] Your owner inspects you carefully.")
	Debug.Notification("Your owner inspects you carefully.")

	kMaster.AllowPCDialogue( True )
	kMaster.RestoreAV("health", kMaster.GetBaseAV("health") )
	kSlave.RestoreAV("health", kSlave.GetBaseAV("health") )

	kMaster.SetAV("Aggression", 1)
	kMaster.SetAV("Confidence", 3)

	if (kMaster.GetRelationshipRank(kSlave)<0)
		kMaster.SetRelationshipRank(kSlave, -4 )
	Else
		kMaster.SetRelationshipRank(kSlave, 0 )
	EndIf

	If ( bHardcoreMode )
		StorageUtil.GetIntValue(kSlave, "_SD_iEnableClothingEquip", 1)
	EndIf
	
	If ( kCrimeFaction && !kMaster.IsInFaction( _SDFP_bountyhunter ) )
		iGold = kCrimeFaction.GetCrimeGold()
		iDemerits += Math.Ceiling( Math.abs(iGold) / 100 )
		kCrimeFaction.PlayerPayCrimeGold( True, False )
	EndIf

	; Utility.Wait(2.0)

	; Debug.SendAnimationEvent( kSlave, "IdleForceDefaultState" )

	; Debug.Trace("_SDQS_enslavement:: start sex 0 == " + aiValue1)
	; If ( aiValue1 == 0 && !kMaster.GetCurrentScene() && !kSlave.GetCurrentScene() )
		; Send story scene - Sex
		; _SDKP_sex.SendStoryEvent( akRef1 = kMaster, akRef2 = kSlave, aiValue1 = 0, aiValue2 = RandomInt( 0, _SDGVP_positions.GetValueInt() ) )

	; EndIf

	; Waking up
	; Game.FadeOutGame(false, true, 2.0, 10)
	; Game.ForceThirdPerson()

	; Debug.SendAnimationEvent(kSlave, "IdleForceDefaultState")

	; Remove current collar if already equipped
	if ((fctOutfit.isCollarEquipped(kSlave)) || (fctOutfit.isCuffsEquipped(kSlave))) && (StorageUtil.GetIntValue(kSlave, "_SD_iSlaveryBindingsOn")==1)
		fctOutfit.clearDevicesForEnslavement()
	EndIf

	; fctOutfit.toggleActorClothing (  kSlave,  bStrip = True,  bDrop = False )

	; Transfer of inventory
	; If ( aiValue2 == 0 )
	If ( bHardcoreMode )
		StorageUtil.SetIntValue(kSlave, "_SD_iSlaveryLimitNudity", 1)
		fctInventory.limitedRemoveAllItems ( kSlave, _SDRAP_playerStorage.GetReference(), True, _SDFLP_ignore_items )

		If ( kSlave.GetItemCount( kRags ) == 0 )
			; kSlave.AddItem( kRags, 1, True)
			kMaster.AddItem( kRags, 1, True)
		Else
			kSlave.RemoveItem( kRags, 1, False, kMaster)
		EndIf
		kSlave.EquipItem( kRags.GetBaseObject() ) ;Inte
	Else
		; Testing use of limitedRemove for all cases to allow for detection of Devious Devices, SoS underwear and other exceptions
		; fctInventory.limitedRemoveAllItems ( kSlave, kMaster, True )
		; kSlave.RemoveAllItems(akTransferTo = kMaster, abKeepOwnership = True)

		; Disabled for now
		; Try a different approach to prevent issues with Devious Items being forcibly removed just as they are added

		; SexLab.ActorLib.StripActor( SexLab.PlayerRef, DoAnimate= false)

		StorageUtil.SetIntValue(kSlave, "_SD_iSlaveryLimitNudity", 0)
		kSlave.RemoveAllItems(akTransferTo = _SDRAP_playerStorage.GetReference(), abKeepOwnership = True)

	EndIf
	; EndIf

	Debug.Trace("[SD] You are chained and collared.")
	Debug.Notification("You are chained and collared.")

	StorageUtil.FormListClear( kSlave, "_SD_lActivePunishmentDevices" )

	if (!fctOutfit.isCollarEquipped(kSlave)) && (StorageUtil.GetIntValue(kSlave, "_SD_iSlaveryCollarOn") == 1)
		fctOutfit.equipDeviceByString ( "Collar" )
		fctOutfit.lockDeviceByString( kSlave,  "Collar")
	EndIf

	if (StorageUtil.GetIntValue(kMaster, "_SD_iForcedSlavery") == 1)
		if (!fctOutfit.isArmbinderEquipped(kSlave)) && (StorageUtil.GetIntValue(kSlave, "_SD_iSlaveryBindingsOn")==1)
			; fctOutfit.equipDeviceByString ( "Armbinder" )
			PunishSlave(kMaster, kSlave, "WristRestraint")
		EndIf
		if (!fctOutfit.isShacklesEquipped(kSlave)) && (StorageUtil.GetIntValue(kSlave, "_SD_iSlaveryBindingsOn")==1)
			; fctOutfit.equipDeviceByString ( "LegCuffs" )
			PunishSlave(kMaster, kSlave, "LegCuffs")
		EndIf
	Endif

	; if  (Utility.RandomInt(0,100)>( 100 - 10 * (4 - (kMaster.GetAV("morality") as Int) ) ))
	;	PunishSlave( kMaster,  kSlave, "Gag")
	; EndIf

	; Test slaver tattoo
	Debug.Trace("[SD] You are marked as your owner's property.")
	Debug.Notification("You are marked as your owner's property.")
	fctOutfit.sendSlaveTatModEvent(kMaster, "SD+","Slavers Hand (back)" )

	StorageUtil.SetIntValue(kSlave, "_SD_iEnslavementInitSequenceOn",0)

	fctConstraints.UpdateStanceOverrides(bForceRefresh=True) 

	if (StorageUtil.GetIntValue(kMaster, "_SD_iForcedSlavery") == 1)
		GameHour.Mod(Utility.RandomInt(1,6))
	endif

	; fctSlavery.DisplaySlaveryLevel(  kMaster, kSlave)
	kMaster.SendModEvent("PCSubStatus")
	kMaster.SendModEvent("SLDRefreshNPCDialogues")

	; ScanSlavePunishment(kSlave)
	UpdateSlaveState(kMaster,kSlave)
EndFunction

Function TransferSlave(Actor akOldMaster, Actor akNewMaster, Actor akSlave)
	ObjectReference keyRef = _SDRAP_key.GetReference() as  ObjectReference 
	ObjectReference cropRef = _SDRAP_crop.GetReference() as  ObjectReference 
	ObjectReference oldMasterRef = akOldMaster as ObjectReference

	fctSlavery.StopSlavery( akOldMaster, akSlave)
	fctFactions.clearSlaveFactions( akSlave )

	_SDRAP_master.ForceRefTo(akNewMaster as ObjectReference)

	EnslavePlayer(akNewMaster, akSlave, _SDGVP_config[3].GetValue() as Bool)

	; Find a way to add missing key / crop for transfer from creature to human master
	if (keyRef != None)
		oldMasterRef.RemoveItem(keyRef as Form, 1, true, akNewMaster as ObjectReference)
	EndIf
	if (cropRef != None)
		oldMasterRef.RemoveItem(cropRef as Form, 1, true, akNewMaster as ObjectReference)
	Endif
EndFunction

; Auto State enslaved
;	Event OnUpdate()
;		While ( !Game.GetPlayer().Is3DLoaded() )
;		EndWhile

;		If ( Self.IsRunning() )
;			RegisterForSingleUpdate( fRFSU )
;		EndIf
;	EndEvent

; EndState

Function UpdateSlaveState(Actor akMaster, Actor akSlave)
	Int valueCount = StorageUtil.FormListCount(akSlave, "_SD_lActivePunishmentDevices")
	int i = 0
	Form fThisDevice
	String sDeviceName 
	Float fPunishmentDuration  
	Float fPunishmentStartGameTime
	float fPunishmentRemainingtime

	If (akSlave == Game.GetPlayer()) && (!akSlave.IsInCombat()) && (StorageUtil.GetIntValue(akSlave, "_SD_iSlaveryPunishmentOn") == 1) && ( (_SDGVP_snp_busy.GetValue() as Int)<0 )

	 	; Debug.Notification("[_sdqs_enslavement] Update punishment list")
	 	Debug.Trace("[_sdqs_enslavement] Update punishment list")

		fTimeEnslaved = GetCurrentGameTime() - fEnslavementStart
		
		If ( _SDGVP_demerits.GetValueInt() < uiLowestDemerits )
			uiLowestDemerits = _SDGVP_demerits.GetValueInt()
		EndIf
		If ( _SDGVP_demerits.GetValueInt() > uiHighestDemerits )
			uiHighestDemerits = _SDGVP_demerits.GetValueInt()
		EndIf
		ufMedianDemerits = ( uiHighestDemerits + uiLowestDemerits ) / 2

		while(i < valueCount)
			
			fThisDevice = StorageUtil.FormListGet(akSlave, "_SD_lActivePunishmentDevices", i)
			sDeviceName = StorageUtil.GetStringValue(fThisDevice, "_SD_sPunishmentName")
			fPunishmentStartGameTime = StorageUtil.GetFloatValue(fThisDevice, "_SD_fPunishmentGameTime")
			fPunishmentDuration = StorageUtil.GetFloatValue(fThisDevice, "_SD_fPunishmentDuration")
			fPunishmentRemainingtime = fPunishmentDuration - (_SDGVP_gametime.GetValue() - fPunishmentStartGameTime)

			If (fPunishmentDuration > 0)
				; Debug.Trace("[SD]   Punishment time:" + fPunishmentRemainingtime  )

				; Debug.Trace("[SD] _SD_fPunishmentGameTime:" + fPunishmentStartGameTime)
				; Debug.Trace("[SD]   fPunishmentDuration:" + fPunishmentDuration)
				; Debug.Trace("[SD]   _SDGVP_gametime:" + _SDGVP_gametime.GetValue())

				Debug.Trace("[_sdqs_enslavement]		Device [" + i + "] = " + sDeviceName + " - Remaining time: " + fPunishmentRemainingtime)

				If ( fPunishmentRemainingtime <= 0 ) 

					RewardSlave(  akMaster,   akSlave, sDeviceName)
					Debug.Trace("[_sdqs_enslavement]			Clear punishment duration")
				Else
					; Debug.Trace("Your punishment is not over yet.")
				EndIf				
			EndIf

			if (fPunishmentDuration <= 0.0) && (fctOutfit.isDeviceEquippedString(  akSlave, sDeviceName ))
				; Timer ran out and device still equiped
				ClearSinglePunishmentDevice( akSlave, sDeviceName )

			Elseif (fPunishmentDuration > 0.0) && (!fctOutfit.isDeviceEquippedString(  akSlave, sDeviceName ))
				; Timer still running and device not equiped
				EquipSinglePunishmentDevice( akSlave, sDeviceName )
			Endif

			i += 1
		endwhile

		; Variables for inter-mod compatibility now that DD doesn't support ZAP keywords any more
		If (fctOutfit.isCollarEquipped(kSlave)) && (StorageUtil.GetIntValue(akSlave, "_SD_iDeviousCollarOn") == 0)
			StorageUtil.SetIntValue(akSlave, "_SD_iDeviousCollarOn", 1)
		EndIf

		If (fctOutfit.isGagEquipped(kSlave)) && (StorageUtil.GetIntValue(akSlave, "_SD_iDeviousGagOn") == 0)
			StorageUtil.SetIntValue(akSlave, "_SD_iDeviousGagOn", 1)
		EndIf

	Else
		If (akSlave != Game.GetPlayer())
			Debug.Trace("[_sdqs_enslavement] Update punishment list: Target is not the player")
		endif
	EndIf


EndFunction

Bool Function PunishSlave(Actor akMaster, Actor akSlave, String sDevice)
	Bool punishmentAdded = False
	Keyword kwDeviceKeyword = fctOutfit.getDeviousKeywordByString(sDevice)

	If (akSlave == Game.GetPlayer()) && (StorageUtil.GetIntValue(akSlave, "_SD_iSlaveryPunishmentOn") == 1)
		float fMasterDistance = (akSlave as ObjectReference).GetDistance(akMaster as ObjectReference)

		If (fMasterDistance <= StorageUtil.GetIntValue(kSlave, "_SD_iLeashLength")) && (kwDeviceKeyword!=None)
			; Debug.Notification("[SD] Slave Punishment")

			if (!fctOutfit.isDeviceEquippedString(kSlave,sDevice))  
				; AddSlavePunishment( akSlave, sDevice)
				QueueSlavePunishment(akSlave, sDevice, 1.0 + Utility.RandomFloat(1.0, 23.0))
				punishmentAdded = True

			Else
				Debug.Trace("[_sdqs_enslavement] Punish slave: Nothing to add. Device already equipped - " + sDevice)
			EndIf

		ElseIf (fMasterDistance > StorageUtil.GetIntValue(kSlave, "_SD_iLeashLength"))
			Debug.Notification("Your owner is too far to punish you.")
		EndIf
	Else
		Debug.Trace("[_sdqs_enslavement] Punish slave: Target is not the player")
	EndIf

	Return 	punishmentAdded 
EndFunction

Bool Function RewardSlave(Actor akMaster, Actor akSlave, String sDevice)
	Bool punishmentRemoved = False
	Keyword kwDeviceKeyword = fctOutfit.getDeviousKeywordByString(sDevice)

	If (akSlave == Game.GetPlayer()) && (StorageUtil.GetIntValue(akSlave, "_SD_iSlaveryPunishmentOn") == 1)
		float fMasterDistance = (akSlave as ObjectReference).GetDistance(akMaster as ObjectReference)

		If (fMasterDistance <= StorageUtil.GetIntValue(kSlave, "_SD_iLeashLength"))
			; Debug.Notification("[SD] Slave Reward")

			if (fctOutfit.isDeviceEquippedString(kSlave,sDevice))  
				Debug.Trace("[_sdqs_enslavement] Reward slave: Trying to remove - " + sDevice)
				; RemoveSlavePunishment( akSlave, sDevice)
				ClearSlavePunishment(akSlave, sDevice, false)

				punishmentRemoved = True

			Else
				Debug.Trace("[_sdqs_enslavement] Reward slave: Nothing to remove. Device missing - " + sDevice)

			EndIf

		ElseIf (fMasterDistance > StorageUtil.GetIntValue(kSlave, "_SD_iLeashLength"))
			Debug.Notification("Your owner is too far to remove your punishment.")
		EndIf
	Else
		Debug.Trace("[_sdqs_enslavement] Reward slave: Target is not the player")
	EndIf

	Return punishmentRemoved 
EndFunction

Function QueueSlavePunishment(Actor kActor , String sDevice, Float fPunishmentLength = 1.0)
	Keyword kwDeviceKeyword = fctOutfit.getDeviousKeywordByString(sDevice)

	If ((kwDeviceKeyword) && (kActor == Game.GetPlayer()) && (!kActor.IsInCombat()) && (StorageUtil.GetIntValue(kActor, "_SD_iSlaveryPunishmentOn") == 1)  && (!fctOutfit.isDeviceEquippedString(  kActor,  sDevice  )) )
		if (StorageUtil.FormListFind( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form) <0)
			StorageUtil.FormListAdd( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )
		endif

		StorageUtil.SetFloatValue(kwDeviceKeyword as Form, "_SD_fPunishmentGameTime", _SDGVP_gametime.GetValue())
		StorageUtil.SetFloatValue(kwDeviceKeyword as Form, "_SD_fPunishmentDuration", 0.075 * fPunishmentLength)
		StorageUtil.SetStringValue(kwDeviceKeyword as Form, "_SD_sPunishmentName", sDevice)

		Debug.Notification("[_sdqs_enslavement] Queue punishment: Adding " + sDevice)
		Debug.Trace("[_sdqs_enslavement] Queue punishment: Adding " + sDevice)
		Debug.Trace("[_sdqs_enslavement] Punishment received: " + sDevice )
		Debug.Trace("[_sdqs_enslavement] Punishment earned: " + uiPunishmentsEarned )
		Debug.Trace("[_sdqs_enslavement] Punishment length: " + fPunishmentsLength )

		_SDFP_slaverCrimeFaction.PlayerPayCrimeGold( True, False )

		fctOutfit.addPunishmentDevice(sDevice)

		; check if not in list first!!!!
		uiPunishmentsEarned = uiPunishmentsEarned + 1


	Else
		If (!kwDeviceKeyword) 
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Device keyword not found ")
		Endif
		If (kActor == Game.GetPlayer())
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Target is not the player - not supported yet ")
		Endif
		If (!kActor.IsInCombat())
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Actor in combat - ignoring")
		EndIf
		If (StorageUtil.GetIntValue(kActor, "_SD_iSlaveryPunishmentOn") != 1)
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Punishment not allowed with this master ")
		Endif
		If (fctOutfit.isDeviceEquippedString(  kActor,  sDevice  ))
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Punishment already equipped -  "+ sDevice)
		Endif
	EndIf

EndFunction

Function ClearSlavePunishment(Actor kActor , String sDevice, Bool bClearNow = false)
	Keyword kwDeviceKeyword = fctOutfit.getDeviousKeywordByString(sDevice)

	If ((kwDeviceKeyword) && (kActor == Game.GetPlayer()) && (!kActor.IsInCombat()) && (StorageUtil.GetIntValue(kActor, "_SD_iSlaveryPunishmentOn") == 1) && (fctOutfit.isDeviceEquippedString(  kActor,  sDevice  )) )

		Float fPunishmentStartGameTime = StorageUtil.GetFloatValue(kwDeviceKeyword as Form, "_SD_fPunishmentGameTime")
		Float fPunishmentDuration = StorageUtil.GetFloatValue(kwDeviceKeyword as Form, "_SD_fPunishmentDuration")
		float fMasterDistance = (kActor as ObjectReference).GetDistance(kMaster as ObjectReference)
		float fPunishmentRemainingtime = fPunishmentDuration - (_SDGVP_gametime.GetValue() - fPunishmentStartGameTime)

		If ((bClearNow) || ((fPunishmentDuration >= 0) && ( fPunishmentRemainingtime <= 0 ) && (fMasterDistance <= StorageUtil.GetIntValue(kActor, "_SD_iLeashLength"))))

			; Additional time added to remove next punishment item
			StorageUtil.SetFloatValue(kwDeviceKeyword as Form, "_SD_fPunishmentGameTime", _SDGVP_gametime.GetValue())
			StorageUtil.SetFloatValue(kwDeviceKeyword as Form, "_SD_fPunishmentDuration", 0.0)

			Debug.Notification("[_sdqs_enslavement] Clear Punishment:  Remove " + sDevice ) 
			Debug.Trace("[_sdqs_enslavement] Clear Punishment:  Remove " + sDevice ) 
			Debug.Trace("[_sdqs_enslavement] Clear Punishment Now: " + bClearNow ) 

			fctOutfit.removePunishmentDevice(sDevice)
			; StorageUtil.FormListRemove( kActor, "_SD_lActivePunishmentDevices", kwDeviceKeyword as Form )

		ElseIf (fPunishmentDuration >= 0) && ( fPunishmentRemainingtime <= 0 ) && (fMasterDistance > StorageUtil.GetIntValue(kActor, "_SD_iLeashLength"))
			Debug.Trace("[_sdqs_enslavement] Clear Punishment - Your owner is too far to remove your punishment.")
			Debug.Trace("[_sdqs_enslavement] fPunishmentStartGameTime: " + fPunishmentStartGameTime )
			Debug.Trace("[_sdqs_enslavement] fPunishmentDuration: " + fPunishmentDuration )
			Debug.Trace("[_sdqs_enslavement] fPunishmentRemainingtime: " + fPunishmentRemainingtime )

		Else
			Debug.Trace("[_sdqs_enslavement] Clear punishment - Punishment is not over yet.")
			Debug.Trace("[_sdqs_enslavement] fPunishmentStartGameTime: " + fPunishmentStartGameTime )
			Debug.Trace("[_sdqs_enslavement] fPunishmentDuration: " + fPunishmentDuration )
			Debug.Trace("[_sdqs_enslavement] fPunishmentRemainingtime: " + fPunishmentRemainingtime )
		endif

	Else
		If (!kwDeviceKeyword) 
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Device keyword not found ")
		Endif
		If (kActor == Game.GetPlayer())
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Target is not the player - not supported yet ")
		Endif
		If (!kActor.IsInCombat())
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Actor in combat - ignoring")
		EndIf
		If (StorageUtil.GetIntValue(kActor, "_SD_iSlaveryPunishmentOn") != 1)
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Punishment not allowed with this master ")
		Endif
		If (!fctOutfit.isDeviceEquippedString(  kActor,  sDevice  ))
			Debug.Trace("[_sdqs_enslavement] Queue punishment: Punishment already cleared -  "+ sDevice)
		Endif
	EndIf

EndFunction

Function EquipSinglePunishmentDevice(Actor kActor, String sDeviceName )
	Debug.Trace("[_sdqs_enslavement]	     Device equipped - update punishment status")
	fctOutfit.addPunishmentDevice(sDeviceName)
EndFunction

Function ClearSinglePunishmentDevice(Actor kActor, String sDeviceName )
	If (!fctOutfit.isDeviceEquippedString(  kActor,  sDeviceName ))
		Debug.Trace("[_sdqs_enslavement]	     Device not equipped - resetting duration - " + sDeviceName)
		StorageUtil.SetFloatValue(fctOutfit.getDeviousKeywordByString(sDeviceName) as Form, "_SD_fPunishmentDuration", 0.0)
	Else
		Debug.Trace("[_sdqs_enslavement]	     Device equipped - update punishment status")
		ClearSlavePunishment( kActor ,  sDeviceName, false)
	Endif
EndFunction

Function UpdateSlaveFollowerState(Actor akSlave)
	Int idx = 0
	Actor nthActor

	; For now, follower slavery is simple: always bound, always kneeling at rest and close to master
	; We will have to make this part more elaborate in a future version

	; Housekeeping - equip cuffs
	While idx < _SDRAP_companions.Length
		nthActor = _SDRAP_companions[idx].GetReference() as Actor
		If ( nthActor )
			; int index = StorageUtil.FormListFind(Game.GetPlayer(), "_SD_lEnslavedFollower", nthActor)
			; if (index < 0)
				; Debug.Notification("Not found!")
			; 	StorageUtil.FormListAdd( Game.GetPlayer(), "_SD_lEnslavedFollower", nthActor)
			; endif

			If (StorageUtil.GetIntValue(nthActor, "_SD_iHandsFreeSex") == 0) && ( nthActor.GetDistance( kMaster ) < kneelingDistance ) &&  !fctOutfit.isYokeEquipped( nthActor) &&  !fctOutfit.isArmbinderEquipped( nthActor)
				; nthActor.EquipItem(  _SDA_bindings , True, True )
				; nthActor.SendModEvent("SDEquipDevice","Armbinder:zap")
				fctOutfit.equipDeviceNPCByString (nthActor, sDeviceString = "Armbinder", sDeviceTags = "zap" )

			EndIf

			; Force follower to kneel down
			If (StorageUtil.GetIntValue(kSlave, "_SD_iDisableFollowerAutoKneeling") == 0) && (StorageUtil.GetIntValue(nthActor, "_SD_iHandsFreeSex") == 0)  && (SexLab.ValidateActor( nthActor ) > 0)
				trust = StorageUtil.GetIntValue(kMaster, "_SD_iTrust")  
				kneelingDistance = funct.floatWithinRange( 500.0 - ((trust as Float) * 5.0), 100.0, 2000.0 )

				If ( ( nthActor.GetDistance( kMaster ) < kneelingDistance ) || ( nthActor.GetDistance( kSlave ) < kneelingDistance ) ) && ( nthActor.GetAnimationVariableFloat("Speed") == 0 ) && (StorageUtil.GetStringValue(kSlave, "_SD_sDefaultStanceFollower") != "Standing") && !nthActor.GetCurrentScene() &&  !fctOutfit.isYokeEquipped( nthActor)

					Debug.SendAnimationEvent(nthActor, "ZazAPC018")

				ElseIf !nthActor.GetCurrentScene() &&  !fctOutfit.isYokeEquipped( nthActor)

					Debug.SendAnimationEvent(nthActor, "OffsetBoundStandingStart")

				EndIf
			EndIf

			Faction DefeatDialogueBlockFaction = StorageUtil.GetFormValue( none, "_SD_SexLabDefeatDialogueBlockFaction") As Faction
			If (DefeatDialogueBlockFaction != None)
				If (nthActor.IsInFaction(DefeatDialogueBlockFaction))
			 		Debug.Trace("[_sdqs_enslavement] 		Debug - NPC is in Dialogue Blocking Faction from Defeat" )
			 		nthActor.RemoveFromFaction(DefeatDialogueBlockFaction)
				Else
			 		Debug.Trace("[_sdqs_enslavement] 		Debug - NPC is NOT in Dialogue Blocking Faction from Defeat" )
				Endif
			Endif
			nthActor.EvaluatePackage()

		EndIf
		idx += 1
	EndWhile

EndFunction

Actor Function GetNearbyEnslavedFollower(Actor akSlave)
	Int idx = 0
	Actor nthActor = None
	Actor thisActor = None

	; For now, follower slavery is simple: always bound, always kneeling at rest and close to master
	; We will have to make this part more elaborate in a future version

	; Housekeeping - equip cuffs
	While idx < _SDRAP_companions.Length
		nthActor = _SDRAP_companions[idx].GetReference() as Actor
		If ( nthActor )

			trust = StorageUtil.GetIntValue(kMaster, "_SD_iTrust")  
			kneelingDistance = funct.floatWithinRange( 500.0 - ((trust as Float) * 5.0), 100.0, 2000.0 )

			If ( ( nthActor.GetDistance( kMaster ) < kneelingDistance ) || ( nthActor.GetDistance( kSlave ) < kneelingDistance ) ) && !nthActor.GetCurrentScene() && (Utility.RandomInt(0,100)>60)

				thisActor = nthActor

			EndIf

		EndIf
		idx += 1
	EndWhile

	If (thisActor == None) && (nthActor != None)
		thisActor = nthActor
	EndIf

	Return thisActor
EndFunction

Function EquipSlaveRags(Actor akSlave)
	ObjectReference kRags = _SDAP_clothing.GetReference() as  ObjectReference 

	akSlave.AddItem( kRags, 1, True )
	akSlave.EquipItem( kRags, True, True )
EndFunction

