Scriptname _SDAS_SummonedSpriggan extends Actor

Import Utility

ReferenceAlias Property _SDRAP_player  Auto  
Keyword Property _SDKP_spriggan  Auto 

Keyword Property _SDKP_sex  Auto 
GlobalVariable Property _SDGVP_positions  Auto  

Float fSummonTime
Float fRFSU = 2.0
Bool bDispel = False
Actor kPlayer


Event OnInit()
	bDispel = False
	fSummonTime = GetCurrentRealTime()
	kPlayer = Game.GetPlayer() ; _SDRAP_player.GetReference() as Actor

	If ( Self )
		RegisterForSingleUpdate( fRFSU )
	EndIf
EndEvent

Event OnUpdate()
	If ( !bDispel && !Self.IsInCombat() && GetCurrentRealTime() - fSummonTime >= 10.0 )
		bDispel = True
		fSummonTime = GetCurrentRealTime() + 30.0
		; If ( !( kPlayer.GetWornForm(0x00000004) as Armor ).HasKeyword(_SDKP_spriggan) )
		; If (_SD_spriggan_punishment.GetValue() >= 1 )
		; 	_SDKP_spriggan.SendStoryEvent(akRef1 = Self, akRef2 = kPlayer, aiValue1 = 0, aiValue2 = 0)
		; Else
			; need to summon a host in
			;_SDKP_sex.SendStoryEvent( akRef1 = Self, akRef2 = kPlayer, aiValue1 = 0, aiValue2 = RandomInt( 0, _SDGVP_positions.GetValueInt() ) )

		If (Utility.RandomInt(0,100)>50)
			Game.ForceThirdPerson()
			; Debug.SendAnimationEvent(kPlayer as ObjectReference, "bleedOutStart")

			Int IButton = _SD_rapeMenu.Show()

			If IButton == 0 ; Show the thing.
				StorageUtil.SetIntValue( kPlayer , "_SD_iSub", StorageUtil.GetIntValue( kPlayer, "_SD_iSub") + 1)
				; StorageUtil.SetFormValue( Game.getPlayer() , "_SD_TempAggressor", Self)
				Self.SendModEvent("PCSubSex")
			Else
				StorageUtil.SetIntValue(kPlayer, "_SD_iDom", StorageUtil.GetIntValue(kPlayer, "_SD_iDom") + 1)
				SendModEvent("PCSubStripped")
				SexLab.ActorLib.StripActor( kPlayer, DoAnimate= false)
			EndIf
		EndIf
	EndIf

	If ( bDispel && !Self.GetCurrentScene() && GetCurrentRealTime() - fSummonTime >= 10.0  ) && (SexLab.ValidateActor( Self) > 0) && (SexLab.ValidateActor( kPlayer ) > 0)
		Self.Kill()
		Return
	EndIf

	If ( Self )
		RegisterForSingleUpdate( fRFSU )
	EndIf
EndEvent

GlobalVariable Property _SD_spriggan_punishment  Auto  


SexLabFramework Property SexLab  Auto  
Message Property _SD_rapeMenu Auto