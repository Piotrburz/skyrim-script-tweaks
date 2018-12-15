scriptname SLH_QST_ConfigMenu extends SKI_ConfigBase

; SCRIPT VERSION ----------------------------------------------------------------------------------
;
; NOTE:
; This is an example to show you how to update scripts after they have been deployed.
;
; History
;
; 1 - Initial version
; 2 - Added color option
; 3 - Added keymap option

int function GetVersion()
	return 3 ; Default version
endFunction

;--------------------------------------
ReferenceAlias Property PlayerAlias  Auto  

GlobalVariable      Property GV_breastValue 			Auto
GlobalVariable      Property GV_buttValue 				Auto
GlobalVariable      Property GV_bellyValue 				Auto
GlobalVariable      Property GV_schlongValue 			Auto
GlobalVariable      Property GV_weightValue 			Auto

GlobalVariable      Property GV_breastSwellMod 			Auto
GlobalVariable      Property GV_bellySwellMod 			Auto
GlobalVariable      Property GV_schlongSwellMod 		Auto
GlobalVariable      Property GV_buttSwellMod 			Auto
GlobalVariable      Property GV_weightSwellMod 			Auto

GlobalVariable      Property GV_breastMax 				Auto
GlobalVariable      Property GV_buttMax 				Auto
GlobalVariable      Property GV_bellyMax 				Auto
GlobalVariable      Property GV_schlongMax 				Auto
GlobalVariable      Property GV_weightMax 				Auto

GlobalVariable      Property GV_breastMin				Auto
GlobalVariable      Property GV_buttMin 				Auto
GlobalVariable      Property GV_bellyMin 				Auto
GlobalVariable      Property GV_schlongMin 				Auto
GlobalVariable      Property GV_weightMin 				Auto

; -----
GlobalVariable      Property GV_armorMod 				Auto
GlobalVariable      Property GV_clothMod	 			Auto

GlobalVariable      Property GV_startingLibido 			Auto
GlobalVariable      Property GV_sexActivityThreshold 	Auto
GlobalVariable      Property GV_sexActivityBuffer		Auto
GlobalVariable      Property GV_baseSwellFactor 		Auto
GlobalVariable      Property GV_baseShrinkFactor 		Auto

GlobalVariable      Property GV_useNodes 				Auto
GlobalVariable      Property GV_useBreastNode 			Auto
GlobalVariable      Property GV_useButtNode 			Auto
GlobalVariable      Property GV_useBellyNode 			Auto
GlobalVariable      Property GV_useSchlongNode 			Auto

GlobalVariable      Property GV_useWeight 				Auto
GlobalVariable      Property GV_useColors 				Auto
GlobalVariable      Property GV_useHairColors 			Auto
GlobalVariable      Property GV_redShiftColor  			Auto
GlobalVariable      Property GV_redShiftColorMod 		Auto
GlobalVariable      Property GV_blueShiftColor 			Auto
GlobalVariable      Property GV_blueShiftColorMod 		Auto

GlobalVariable      Property GV_allowTG 				Auto
GlobalVariable      Property GV_allowHRT 				Auto
GlobalVariable      Property GV_allowBimbo 		 		Auto
GlobalVariable      Property GV_allowBimboRace	 		Auto
GlobalVariable      Property GV_allowSuccubus 			Auto
GlobalVariable      Property GV_setshapeToggle 			Auto
GlobalVariable      Property GV_resetToggle 			Auto
GlobalVariable      Property GV_origWeight	 			Auto 

GlobalVariable      Property GV_forcedRefresh 			Auto

GlobalVariable      Property GV_showStatus 				Auto
GlobalVariable      Property GV_commentsFrequency		Auto

GlobalVariable      Property GV_changeOverrideToggle	Auto
GlobalVariable      Property GV_shapeUpdateOnCellChange	Auto
GlobalVariable      Property GV_shapeUpdateAfterSex		Auto
GlobalVariable      Property GV_shapeUpdateOnTimer		Auto
GlobalVariable      Property GV_enableNiNodeUpdate		Auto
GlobalVariable      Property GV_enableNiNodeOverride	Auto

GlobalVariable      Property GV_allowExhibitionist		Auto
GlobalVariable      Property GV_allowSelfSpells			Auto
GlobalVariable      Property GV_bimboClumsinessMod      Auto

GlobalVariable      Property GV_hornyBegON     			Auto
GlobalVariable      Property GV_hornyBegArousal      	Auto
GlobalVariable      Property GV_bimboClumsinessDrop    	Auto

SLH_QST_HormoneGrowth 	Property SLH_Control auto

; String                   Property NINODE_SCHLONG	 	= "NPC Genitals01 [Gen01]" AutoReadOnly
String                   Property NINODE_SCHLONG	 	= "NPC GenitalsBase [GenBase]" AutoReadOnly
String                   Property NINODE_LEFT_BREAST    = "NPC L Breast" AutoReadOnly
String                   Property NINODE_LEFT_BREAST01  = "NPC L Breast01" AutoReadOnly
String                   Property NINODE_LEFT_BUTT      = "NPC L Butt" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST   = "NPC R Breast" AutoReadOnly
String                   Property NINODE_RIGHT_BREAST01 = "NPC R Breast01" AutoReadOnly
String                   Property NINODE_RIGHT_BUTT     = "NPC R Butt" AutoReadOnly
String                   Property NINODE_SKIRT02        = "SkirtBBone02" AutoReadOnly
String                   Property NINODE_SKIRT03        = "SkirtBBone03" AutoReadOnly
String                   Property NINODE_BELLY          = "NPC Belly" AutoReadOnly
Float                    Property NINODE_MAX_SCALE      = 2.0 AutoReadOnly
Float                    Property NINODE_MIN_SCALE      = 0.1 AutoReadOnly

; NiOverride version data
int Property NIOVERRIDE_VERSION = 4 AutoReadOnly
int Property NIOVERRIDE_SCRIPT_VERSION = 4 AutoReadOnly

; XPMSE version data
float Property XPMSE_VERSION = 3.0 AutoReadOnly
float Property XPMSELIB_VERSION = 3.0 AutoReadOnly


; PRIVATE VARIABLES -------------------------------------------------------------------------------

; --- Version 1 ---

; State


int			_startingLibido			= 30
int			_sexActivityThreshold	= 2
int			_sexActivityBuffer		= 3
float 		_baseSwellFactor 		= 10.0
float 		_baseShrinkFactor 		= 5.0

float 		_bellySwellMod 			= 1.0; 0.1 
float 		_breastSwellMod 		= 1.0; 0.3
float 		_buttSwellMod 			= 1.0; 0.2
float 		_schlongSwellMod 		= 1.0; 0.1 
float 		_weightSwellMod 		= 1.0; 0.1  

float 		_armorMod 				= 0.5; 0.1  
float 		_clothMod 				= 0.8; 0.1  
float 		_bimboClumsinessMod		= 1.0; 0.1  

bool 		_hornyBegON     		= false
float 		_hornyBegArousal      	= 60.0
float 		_hornyGrab      		= -1.0
bool 		_bimboClumsinessDrop    = true

float 		_breastMax      		= 4.0
float 		_bellyMax       		= 8.0
float 		_buttMax       			= 4.0
float 		_schlongMax       		= 4.0

float 		_breastMin      		= 0.8
float 		_bellyMin       		= 0.9
float 		_buttMin       			= 0.9
float 		_schlongMin       		= 0.5

bool		_useNodes				= true
bool		_useBreastNode			= true
bool		_useButtNode			= true
bool		_useBellyNode			= true
bool		_useSchlongNode			= true
bool		_useWeight				= true
bool		_useColors				= false
bool		_useHairColors			= false
bool		_changeOverrideToggle	= true
bool		_shapeUpdateOnCellChange = true
bool		_shapeUpdateAfterSex 	= true
bool		_shapeUpdateOnTimer 	= true
bool		_enableNiNodeUpdate 	= false
bool		_enableNiNodeOverride	= true
int			_redShiftColor 			= 0
float		_redShiftColorMod 		= 1.0
int			_blueShiftColor 		= 0
float		_blueShiftColorMod 		= 1.0

bool		_allowExhibitionist		= false
bool		_allowSelfSpells		= false

bool		_allowTG				= false
bool		_allowHRT				= false
bool		_allowBimbo				= false
bool		_allowBimboRace			= false
bool		_allowSuccubus			= false

int			_setTG					= 0
int			_setHRT					= 0
int			_setBimbo				= 0
int			_setSuccubus			= 0

bool		_statusToggle			= false
bool		_setshapeToggle			= false
bool		_resetToggle			= false

bool		_showDebug				= false

bool		_showStatus 			= true
float		_commentsFrequency 		= 80.0

float 		_weightSetValue 		= 100.0
float 		_breastSetValue 		= 1.0
float 		_bellySetValue 			= 1.0
float 		_buttSetValue 			= 1.0
float 		_schlongSetValue		= 1.0

bool 		_refreshToggle 			= false
int 		_applyNodeBalancing     = 0


ObjectReference PlayerREF
Actor PlayerActor
ActorBase pActorBase 
Int PlayerGender

bool Function CheckXPMSERequirements(Actor akActor, bool isFemale)
	return XPMSELib.CheckXPMSEVersion(akActor, isFemale, XPMSE_VERSION, true) && XPMSELib.CheckXPMSELibVersion(XPMSELIB_VERSION) && SKSE.GetPluginVersion("NiOverride") >= NIOVERRIDE_VERSION && NiOverride.GetScriptVersion() >= NIOVERRIDE_SCRIPT_VERSION
EndFunction

; INITIALIZATION ----------------------------------------------------------------------------------

; @overrides SKI_ConfigBase
event OnConfigInit()
	Pages = new string[2]
	Pages[0] = "Customization"
	Pages[1] = "Add-ons"

endEvent

; @implements SKI_QuestBase
event OnVersionUpdate(int a_version)
	{Called when a version update of this script has been detected}

	; Version 2 specific updating code
	if (a_version >= 2 && CurrentVersion < 2)
	;	Debug.Trace(self + ": Updating script to version 2")
	;	_color = Utility.RandomInt(0x000000, 0xFFFFFF) ; Set a random color
	endIf

	; Version 3 specific updating code
	if (a_version >= 3 && CurrentVersion < 3)
	;	Debug.Trace(self + ": Updating script to version 3")
	;	_myKey = Input.GetMappedKey("Jump")
	endIf
endEvent


; EVENTS ------------------------------------------------------------------------------------------

; @implements SKI_ConfigBase
event OnPageReset(string a_page)
	{Called when a new page is selected, including the initial empty page}


	If (!StorageUtil.HasIntValue(none, "_SLH_iHormones"))
		SLH_Control.initHormones()
	EndIf

	; Load custom logo in DDS format
	if (a_page == "")
		; Image size 512x512
		; X offset = 376 - (height / 2) = 120
		; Y offset = 223 - (width / 2) = 0
		LoadCustomContent("SexLab_Hormones/logo.dds", 120, 0)
		return
	else
		UnloadCustomContent()
	endIf

	_startingLibido = GV_startingLibido.GetValue() as Int
	_sexActivityThreshold = GV_sexActivityThreshold.GetValue() as Int
	_sexActivityBuffer = GV_sexActivityBuffer.GetValue() as Int
	_baseSwellFactor = GV_baseSwellFactor.GetValue() as Float
	_baseShrinkFactor = GV_baseShrinkFactor.GetValue() as Float

	_breastSwellMod = GV_breastSwellMod.GetValue()   as Float
	_bellySwellMod = GV_bellySwellMod.GetValue()   as Float 
	_schlongSwellMod = GV_schlongSwellMod.GetValue()   as Float 
	_buttSwellMod = GV_buttSwellMod.GetValue()   as Float
	_weightSwellMod = GV_weightSwellMod.GetValue()    as Float    

	_armorMod = GV_armorMod.GetValue()    as Float  
	_clothMod = GV_clothMod.GetValue()    as Float   
	_bimboClumsinessMod = GV_bimboClumsinessMod.GetValue()    as Float   

	If (_hornyGrab==-1.0)
		StorageUtil.SetFloatValue(none, "_SLH_fHornyGrab", 30.0)
	Endif

	_hornyBegON  = GV_hornyBegON.GetValue()    as Int
	_hornyBegArousal  = GV_hornyBegArousal.GetValue()    as Float
	_hornyGrab  = StorageUtil.GetFloatValue(none, "_SLH_fHornyGrab")
	_bimboClumsinessDrop  = GV_bimboClumsinessDrop.GetValue()    as Int

	_breastMax = GV_breastMax.GetValue()  as Float
	_bellyMax = GV_bellyMax.GetValue()  as Float 
	_schlongMax = GV_schlongMax.GetValue()  as Float 
	_buttMax = GV_buttMax.GetValue()  as Float 

	_breastMin = GV_breastMin.GetValue()  as Float
	_bellyMin = GV_bellyMin.GetValue()  as Float 
	_schlongMin = GV_schlongMin.GetValue()  as Float 
	_buttMin = GV_buttMin.GetValue()  as Float 

	_weightSetValue 		= GV_weightValue.GetValue()
	_breastSetValue 		= GV_breastValue.GetValue()
	_bellySetValue 			= GV_bellyValue.GetValue()
	_buttSetValue 			= GV_buttValue.GetValue()
	_schlongSetValue		= GV_schlongValue.GetValue()

	_useNodes = GV_useNodes.GetValue()  as Int
 	_useBreastNode = GV_useBreastNode.GetValue()  as Int
	_useButtNode = GV_useButtNode.GetValue()  as Int
	_useBellyNode = GV_useBellyNode.GetValue()  as Int
	_useSchlongNode = GV_useSchlongNode.GetValue()  as Int
	_useWeight = GV_useWeight.GetValue()  as Int
	_useColors = GV_useColors.GetValue()  as Int
	_useHairColors = GV_useHairColors.GetValue()  as Int

	_showStatus = GV_showStatus.GetValue() as Bool
	_commentsFrequency = GV_commentsFrequency.GetValue() as Float

	_redShiftColor 			= GV_redShiftColor.GetValue() as Int
	_redShiftColorMod 		= GV_redShiftColorMod.GetValue() as Float
	_blueShiftColor 		= GV_blueShiftColor.GetValue() as Int
	_blueShiftColorMod 		= GV_blueShiftColorMod.GetValue() as Float

	_allowExhibitionist = GV_allowExhibitionist.GetValue()  as Int
	_allowSelfSpells = GV_allowSelfSpells.GetValue()  as Int

	_allowTG = GV_allowTG.GetValue()  as Int
	_allowHRT = GV_allowHRT.GetValue()  as Int
	_allowBimbo = GV_allowBimbo.GetValue()  as Int
	_allowBimboRace = GV_allowBimboRace.GetValue()  as Int
	_allowSuccubus = GV_allowSuccubus.GetValue()  as Int

	; _setTG = StorageUtil.GetIntValue(PlayerActor, "_SLH_iTG")
	; _setHRT = StorageUtil.GetIntValue(PlayerActor, "_SLH_iHRT")
	; _setBimbo = StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo")
	; _setSuccubus = StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus")

	_changeOverrideToggle = GV_changeOverrideToggle.GetValue()  as Int
	_shapeUpdateOnCellChange = GV_shapeUpdateOnCellChange.GetValue()  as Int
	_shapeUpdateAfterSex = GV_shapeUpdateAfterSex.GetValue()  as Int
	_shapeUpdateOnTimer = GV_shapeUpdateOnTimer.GetValue()  as Int
	_enableNiNodeUpdate = GV_enableNiNodeUpdate.GetValue()  as Int
	_enableNiNodeOverride = GV_enableNiNodeOverride.GetValue()  as Int

	_setshapeToggle = GV_setshapeToggle.GetValue()  as Int
	_resetToggle = GV_resetToggle.GetValue()  as Int
	_showDebug = StorageUtil.GetIntValue(none, "_SLH_debugTraceON")

	PlayerREF= PlayerAlias.GetReference()
	PlayerActor= PlayerAlias.GetReference() as Actor
	pActorBase = PlayerActor.GetActorBase()
	PlayerGender = pActorBase.GetSex() ; 0 = Male ; 1 = Female

	Bool bEnableLeftBreast  = NetImmerse.HasNode(PlayerActor, NINODE_LEFT_BREAST, false)
	Bool bEnableRightBreast = NetImmerse.HasNode(PlayerActor, NINODE_RIGHT_BREAST, false)
	Bool bEnableLeftButt    = NetImmerse.HasNode(PlayerActor, NINODE_LEFT_BUTT, false)
	Bool bEnableRightButt   = NetImmerse.HasNode(PlayerActor, NINODE_RIGHT_BUTT, false)
	Bool bEnableBelly       = NetImmerse.HasNode(PlayerActor, NINODE_BELLY, false)
	Bool bEnableSchlong     = NetImmerse.HasNode(PlayerActor, NINODE_SCHLONG, false)

	Bool bBreastEnabled     = ( bEnableLeftBreast && bEnableRightBreast as bool )
	Bool bButtEnabled       = ( bEnableLeftButt && bEnableRightButt  as bool )
	Bool bBellyEnabled      = ( bEnableBelly  as bool )
	Bool bSchlongEnabled    = ( bEnableSchlong as bool )


	If (a_page == "Customization")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Changes customization")
		AddSliderOptionST("STATE_LIBIDO","Starting libido", _startingLibido as Float) 
		AddSliderOptionST("STATE_SEX_TRIGGER","High Sex Activity trigger", _sexActivityThreshold as Float)		
		AddSliderOptionST("STATE_SEX_BUFFER","Low Sex Activity buffer", _sexActivityBuffer as Float)

		AddHeaderOption(" Weight")
		AddToggleOptionST("STATE_CHANGE_WEIGHT","Change Weight scale", _useWeight as Float)
		AddSliderOptionST("STATE_WEIGHT_SWELL","Weight swell mod", _weightSwellMod as Float,"{1}")

		AddHeaderOption(" Color")
		AddToggleOptionST("STATE_CHANGE_COLOR","Change skin color", _useColors as Float)
		AddToggleOptionST("STATE_CHANGE_HAIRCOLOR","Change hair color", _useHairColors as Float)

		AddColorOptionST("STATE_RED_COLOR_SHIFT","Red color shift", _redShiftColor as Int)
		AddSliderOptionST("STATE_RED_COLOR_SHIFT_MOD","Red color shift mod", _redShiftColorMod as Float,"{1}")

		AddColorOptionST("STATE_BLUE_COLOR_SHIFT","Blue color shift", _blueShiftColor as Int)
		AddSliderOptionST("STATE_BLUE_COLOR_SHIFT_MOD","Blue color shift mod", _blueShiftColorMod as Float,"{1}")

		SetCursorPosition(1)
		AddHeaderOption(" NetImmerse Nodes")
		AddToggleOptionST("STATE_CHANGE_NODES","Change NetImmerse Nodes", _useNodes as Float)
		AddSliderOptionST("STATE_SWELL_FACTOR","Base swell factor", _baseSwellFactor as Float,"{0} %")
		AddSliderOptionST("STATE_SHRINK_FACTOR","Base shrink factor", _baseShrinkFactor as Float,"{0} %")

		AddSliderOptionST("STATE_ARMOR_MOD","Armor shrink", _armorMod as Float,"{1}")
		AddSliderOptionST("STATE_CLOTH_MOD","Cloth shrink", _clothMod as Float,"{1}")

		If (bBreastEnabled)
			AddToggleOptionST("STATE_CHANGE_BREAST_NODE","Change Breast Node", _useBreastNode as Float)	
			AddSliderOptionST("STATE_BREAST_SWELL","Breast swell modifier", _breastSwellMod as Float,"{1}")
			AddSliderOptionST("STATE_BREAST_MIN","Breast swell min", _breastMin as Float,"{1}")
			AddSliderOptionST("STATE_BREAST_MAX","Breast swell max", _breastMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_BREAST_NODE","Change Breast Node", _useBreastNode as Float, OPTION_FLAG_DISABLED)	
			; AddSliderOptionST("STATE_BREAST_SWELL","Breast swell modifier", _breastSwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_BREAST_MAX","Breast swell max", _breastMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		If (bBellyEnabled)
			AddToggleOptionST("STATE_CHANGE_BELLY_NODE","Change Belly Node", _useBellyNode as Float)	
			AddSliderOptionST("STATE_BELLY_SWELL","Belly swell modifier", _bellySwellMod as Float,"{1}")
			AddSliderOptionST("STATE_BELLY_MIN","Belly swell min", _bellyMin as Float,"{1}")
			AddSliderOptionST("STATE_BELLY_MAX","Belly swell max", _bellyMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_BELLY_NODE","Change Belly Node", _useBellyNode as Float, OPTION_FLAG_DISABLED)	
			; AddSliderOptionST("STATE_BELLY_SWELL","Belly swell modifier", _bellySwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_BELLY_MAX","Belly swell max", _bellyMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		If (bButtEnabled)
			AddToggleOptionST("STATE_CHANGE_BUTT_NODE","Change Butt Node", _useButtNode as Float)		
			AddSliderOptionST("STATE_BUTT_SWELL","Butt swell modifier", _buttSwellMod as Float,"{1}")
			AddSliderOptionST("STATE_BUTT_MIN","Butt swell min", _buttMin as Float,"{1}")
			AddSliderOptionST("STATE_BUTT_MAX","Butt swell max", _buttMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_BUTT_NODE","Change Butt Node", _useButtNode as Float, OPTION_FLAG_DISABLED)		
			; AddSliderOptionST("STATE_BUTT_SWELL","Butt swell modifier", _buttSwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_BUTT_MAX","Butt swell max", _buttMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf

		If (bSchlongEnabled)
			AddToggleOptionST("STATE_CHANGE_SCHLONG_NODE","Change Schlong Node", _useSchlongNode as Float)
			AddSliderOptionST("STATE_SCHLONG_SWELL","Schlong swell modifier", _schlongSwellMod as Float,"{1}")
			AddSliderOptionST("STATE_SCHLONG_MIN","Schlong swell min", _schlongMin as Float,"{1}")
			AddSliderOptionST("STATE_SCHLONG_MAX","Schlong swell max", _schlongMax as Float,"{1}")
		else
			AddToggleOptionST("STATE_CHANGE_SCHLONG_NODE","Change Schlong Node", _useSchlongNode as Float, OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_SCHLONG_SWELL","Schlong swell modifier", _schlongSwellMod as Float,"{1}", OPTION_FLAG_DISABLED)
			; AddSliderOptionST("STATE_SCHLONG_MAX","Schlong swell max", _schlongMax as Float,"{1}", OPTION_FLAG_DISABLED)
		EndIf




	elseIf (a_page == "Add-ons")
		SetCursorFillMode(TOP_TO_BOTTOM)

		AddHeaderOption(" Optional curses")
		AddHeaderOption(" Succubus ")
		AddToggleOptionST("STATE_SUCCUBUS","Allow Succubus Curse", _allowSuccubus as Float)

		AddHeaderOption(" Sex Change ")
		AddToggleOptionST("STATE_SEX_CHANGE","Allow Sex Change Curse", _allowHRT as Float)
		AddToggleOptionST("STATE_SET_SEX_CHANGE","Set Sex Change Curse now", _setHRT as Float)
		AddToggleOptionST("STATE_TG","Allow Transgender Curse", _allowTG as Float)

		AddHeaderOption(" Bimbo ")
		AddToggleOptionST("STATE_BIMBO","Allow Bimbo Curse", _allowBimbo as Float)
		AddToggleOptionST("STATE_BIMBO_RACE","Bimbo Race", _allowBimboRace as Float)
		AddSliderOptionST("STATE_BIMBO_CLUMSINESS","Clumsiness factor", _bimboClumsinessMod as Float,"{1}")
		AddToggleOptionST("STATE_BIMBO_DROP","Drop items when aroused", _bimboClumsinessDrop  as Bool)

		AddHeaderOption(" General behaviors ")
		AddToggleOptionST("STATE_HORNY_BEG","Beg for sex", _hornyBegON   as Bool)
		AddSliderOptionST("STATE_BEG_TRIGGER","Beg arousal trigger", _hornyBegArousal  as Float,"{1}")
		AddSliderOptionST("STATE_GRAB_TRIGGER","Public sex attack", _hornyGrab  as Float,"{1}")

		AddHeaderOption(" Shape refresh controls")
		AddToggleOptionST("STATE_CHANGE_OVERRIDE","Shape change override", _changeOverrideToggle as Float)
		AddToggleOptionST("STATE_UPDATE_ON_CELL","Update on cell change", _shapeUpdateOnCellChange as Float)
		AddToggleOptionST("STATE_UPDATE_ON_SEX","Update after sex", _shapeUpdateAfterSex as Float)
		AddToggleOptionST("STATE_UPDATE_ON_TIMER","Update on timer", _shapeUpdateOnTimer as Float)
		AddToggleOptionST("STATE_ENABLE_NODE_UPDATE","Enable QueueNodeUpdate", _enableNiNodeUpdate as Float)

		If CheckXPMSERequirements(PlayerActor, PlayerGender as Bool)
			AddToggleOptionST("STATE_ENABLE_NODE_OVERRIDE","Enable NiOverride", _enableNiNodeOverride as Float)
		else
			AddToggleOptionST("STATE_ENABLE_NODE_OVERRIDE","Enable NiOverride", _enableNiNodeOverride as Float, OPTION_FLAG_DISABLED)
		endif

		AddEmptyOption()
		SetCursorPosition(1)
		AddHeaderOption(" Curses manual triggers ")
		AddToggleOptionST("STATE_SET_SUCCUBUS","Set Succubus Curse now", _setSuccubus as Float)
		AddToggleOptionST("STATE_SET_TG","Set Transgender Curse now", _setTG as Float)
		AddToggleOptionST("STATE_SET_BIMBO","Set Bimbo Curse now", _setBimbo as Float)

		AddHeaderOption(" Status")
		AddToggleOptionST("STATE_STATUS","Display current status", _statusToggle as Float)

		AddToggleOptionST("STATE_SHOW_STATUS","Show Status messages", _showStatus as Bool)
		AddSliderOptionST("STATE_COMMENTS_FREQUENCY","NPC Comments Frequency ", _commentsFrequency as Float,"{1} %")
		AddToggleOptionST("STATE_EXHIBITIONIST","Allow Exhibitionist", _allowExhibitionist as Float)
		AddToggleOptionST("STATE_SELF_SPELLS","Allow Self Spells", _allowSelfSpells as Float)

		AddHeaderOption(" Change shape values")
		AddSliderOptionST("STATE_WEIGHT_VALUE","Weight ", _weightSetValue as Float,"{1}")
		AddSliderOptionST("STATE_BREAST_VALUE","Breast", _breastSetValue as Float,"{1}")
		AddSliderOptionST("STATE_BELLY_VALUE","Belly", _bellySetValue as Float,"{1}")
		AddSliderOptionST("STATE_BUTT_VALUE","Butt", _buttSetValue as Float,"{1}")
		AddSliderOptionST("STATE_SCHLONG_VALUE","Schlong", _schlongSetValue as Float,"{1}")

		AddEmptyOption()
		AddToggleOptionST("STATE_REFRESH","Apply changes", _refreshToggle as Float)

		AddEmptyOption()
		AddToggleOptionST("STATE_BALANCE","NiO Node Balancing", _applyNodeBalancing  as Float)
		AddToggleOptionST("STATE_SETSHAPE","Set default shape", _setshapeToggle as Float)
		AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle as Float)
		AddToggleOptionST("STATE_DEBUG","Debug messages", _showDebug as Float)
	endIf
endEvent

; AddSliderOptionST("STATE_LIBIDO","Starting libido", _startingLibido)
state STATE_LIBIDO ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_startingLibido.GetValueInt() )
		SetSliderDialogDefaultValue( 30 )
		SetSliderDialogRange( -100, 100 )
		SetSliderDialogInterval( 10 )
	endEvent

	event OnSliderAcceptST(float value)
		int thisValue = value as int
		GV_startingLibido.SetValueInt( thisValue )
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_startingLibido.SetValueInt( 30 )
		SetSliderOptionValueST( 30 )
	endEvent

	event OnHighlightST()
		SetInfoText("Starting libido - controls initial sex drive of your character.")
	endEvent
endState
; AddSliderOptionST("STATE_SEX_TRIGGER","High Sex Activity trigger", _sexActivityThreshold)
state STATE_SEX_TRIGGER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_sexActivityThreshold.GetValueInt() )
		SetSliderDialogDefaultValue( 2 )
		SetSliderDialogRange( 2, 10 )
		SetSliderDialogInterval( 1 )
	endEvent

	event OnSliderAcceptST(float value)
		int thisValue = value as int
		GV_sexActivityThreshold.SetValueInt( thisValue )
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_sexActivityThreshold.SetValueInt( 2 )
		SetSliderOptionValueST( 2 )
	endEvent

	event OnHighlightST()
		SetInfoText("Number of sex acts required in a day to increase body changes.")
	endEvent
endState
; AddSliderOptionST("STATE_SEX_BUFFER","High Sex Activity buffer", _sexActivityBuffer)
state STATE_SEX_BUFFER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_sexActivityBuffer.GetValueInt() )
		SetSliderDialogDefaultValue( 7 )
		SetSliderDialogRange( 1, 10 )
		SetSliderDialogInterval( 1 )
	endEvent

	event OnSliderAcceptST(float value)
		int thisValue = value as int
		GV_sexActivityBuffer.SetValueInt( thisValue )
		SetSliderOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_sexActivityBuffer.SetValueInt( 7 )
		SetSliderOptionValueST( 7 )
	endEvent

	event OnHighlightST()
		SetInfoText("Number of days without sex before body changes decrease.")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_NODES","Change NetImmerse Nodes", _useNodes)
state STATE_CHANGE_NODES ; TOGGLE
	event OnSelectST()
		GV_useNodes.SetValueInt( Math.LogicalXor( 1, GV_useNodes.GetValueInt() ) )
		SetToggleOptionValueST( GV_useNodes.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useNodes.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allows changes to NetImmerse Nodes")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_BREAST_NODE","Change Breast Node", _useBreastNode as Float)	
state STATE_CHANGE_BREAST_NODE ; TOGGLE
	event OnSelectST()
		GV_useBreastNode.SetValueInt( Math.LogicalXor( 1, GV_useBreastNode.GetValueInt() ) )
		SetToggleOptionValueST( GV_useBreastNode.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useBreastNode.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allows Hormones to change breast nodes.")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_BUTT_NODE","Change Butt Node", _useButtNode as Float)		
state STATE_CHANGE_BUTT_NODE ; TOGGLE
	event OnSelectST()
		GV_useButtNode.SetValueInt( Math.LogicalXor( 1, GV_useButtNode.GetValueInt() ) )
		SetToggleOptionValueST( GV_useButtNode.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useButtNode.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allows Hormones to change butt nodes.")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_BELLY_NODE","Change Belly Node", _useBellyNode as Float)		
state STATE_CHANGE_BELLY_NODE ; TOGGLE
	event OnSelectST()
		GV_useBellyNode.SetValueInt( Math.LogicalXor( 1, GV_useBellyNode.GetValueInt() ) )
		SetToggleOptionValueST( GV_useBellyNode.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useBellyNode.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allows Hormones to change belly nodes.")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_SCHLONG_NODE","Change Schlong Node", _useSchlongNode as Float)
state STATE_CHANGE_SCHLONG_NODE ; TOGGLE
	event OnSelectST()
		GV_useSchlongNode.SetValueInt( Math.LogicalXor( 1, GV_useSchlongNode.GetValueInt() ) )
		SetToggleOptionValueST( GV_useSchlongNode.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useSchlongNode.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allows Hormones to change schlong nodes.")
	endEvent
endState

; AddSliderOptionST("STATE_SWELL_FACTOR","Base swell factor", _baseSwellFactor)
state STATE_SWELL_FACTOR ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_baseSwellFactor.GetValue() )
		SetSliderDialogDefaultValue( 10.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_baseSwellFactor.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue,"{0} %" )
	endEvent

	event OnDefaultST()
		GV_baseSwellFactor.SetValue( 10.0 )
		SetSliderOptionValueST( 10.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Base swell factor - Rate of growth applied to breasts, belly and butt (in % of current shape value).")
	endEvent
endState
; AddSliderOptionST("STATE_SHRINK_FACTOR","Base shrink factor", _baseShrinkFactor)
state STATE_SHRINK_FACTOR ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_baseShrinkFactor.GetValue() )
		SetSliderDialogDefaultValue( 5.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_baseShrinkFactor.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{0} %")
	endEvent

	event OnDefaultST()
		GV_baseShrinkFactor.SetValue( 5.0 )
		SetSliderOptionValueST( 5.0,"{0} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("Base shrink factor - Rate of reduction applied to breasts, belly and butt (in % of current shape value).")
	endEvent
endState
; AddSliderOptionST("STATE_ARMOR_MOD","Armor shrink", _armorMod)
state STATE_ARMOR_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_armorMod.GetValue() )
		SetSliderDialogDefaultValue( 0.5 )
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_armorMod.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{1}")

		refreshStorageFromGlobals() 
	endEvent

	event OnDefaultST()
		GV_armorMod.SetValue( 0.5 )
		SetSliderOptionValueST( 0.5,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Armor shrink factor - Amount of change applied when wearing an armor. Disabled when other mods are taking over shape updates (like pregnancy mods).")
	endEvent
endState
; AddSliderOptionST("STATE_CLOTH_MOD","Cloth shrink", _clothMod)
state STATE_CLOTH_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_clothMod.GetValue() )
		SetSliderDialogDefaultValue( 0.8 )
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_clothMod.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{1}")

		refreshStorageFromGlobals() 
	endEvent

	event OnDefaultST()
		GV_clothMod.SetValue( 0.8 )
		SetSliderOptionValueST( 0.8,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Armor shrink factor - Amount of change applied when wearing cloth. Disabled when other mods are taking over shape updates (like pregnancy mods).")
	endEvent
endState
; AddSliderOptionST("STATE_BREAST_SWELL","Breast swell modifier", _breastSwellMod)
state STATE_BREAST_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_breastSwellMod.GetValue()  )
		SetSliderDialogDefaultValue( 0.3 )
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_breastSwellMod.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_breastSwellMod.SetValue( 0.3 )
		SetSliderOptionValueST( 0.3, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Breast swell modifier - Amount of base change applied to breasts (1 being the full amount).")
	endEvent
endState
; AddSliderOptionST("STATE_BREAST_MAX","Breast swell max", _breastMax)
state STATE_BREAST_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_breastMax.GetValue() )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( GV_breastMin.GetValue(), 4.0 )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_breastMax.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_breastMax.SetValue( 2.0 )
		SetSliderOptionValueST( 2.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Maximum breast size multiplier allowed")
	endEvent
endState
; AddSliderOptionST("STATE_BREAST_MIN","Breast swell min", _breastMin)
state STATE_BREAST_MIN ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_breastMin.GetValue() )
		SetSliderDialogDefaultValue( 0.8 )
		SetSliderDialogRange( 0.1 , GV_breastMax.GetValue() )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_breastMin.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_breastMin.SetValue( 0.8 )
		SetSliderOptionValueST( 0.8, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Minimum breast size multiplier allowed")
	endEvent
endState
; AddSliderOptionST("STATE_BELLY_SWELL","Belly swell modifier", _bellySwellMod)
state STATE_BELLY_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bellySwellMod.GetValue()   )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value  
		GV_bellySwellMod.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_bellySwellMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Belly swell modifier - Amount of base change applied to belly (1 being the full amount).")
	endEvent
endState
; AddSliderOptionST("STATE_BELLY_MAX","Belly swell max", _bellyMax)
state STATE_BELLY_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bellyMax.GetValue() )
		SetSliderDialogDefaultValue( 1.2 )
		SetSliderDialogRange( GV_bellyMin.GetValue(), 10.0 )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value as float
		GV_bellyMax.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_bellyMax.SetValue( 1.2 )
		SetSliderOptionValueST( 1.2, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Maximum belly size multiplier allowed")
	endEvent
endState
; AddSliderOptionST("STATE_BELLY_MIN","Belly swell min", _bellyMin)
state STATE_BELLY_MIN ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bellyMin.GetValue() )
		SetSliderDialogDefaultValue( 0.8 )
		SetSliderDialogRange( 0.1 , GV_bellyMax.GetValue() )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_bellyMin.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_bellyMin.SetValue( 0.8 )
		SetSliderOptionValueST( 0.8, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Minimum belly size multiplier allowed")
	endEvent
endState
; AddSliderOptionST("STATE_BUTT_SWELL","Butt swell modifier", _buttSwellMod)
state STATE_BUTT_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_buttSwellMod.GetValue()  )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value
		GV_buttSwellMod.SetValue( thisValue   )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_buttSwellMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Butt swell modifier - Amount of base change applied to butt (1 being the full amount).")
	endEvent
endState
; AddSliderOptionST("STATE_BUTT_MAX",("Butt swell max", _buttMax)
state STATE_BUTT_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_buttMax.GetValue() )
		SetSliderDialogDefaultValue( 2.0 )
		SetSliderDialogRange( GV_buttMin.GetValue(), 4.0 )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value as float
		GV_buttMax.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_buttMax.SetValue( 2.0 )
		SetSliderOptionValueST( 2.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Maximum butt size multiplier allowed")
	endEvent
endState
; AddSliderOptionST("STATE_BUTT_MIN","Butt swell min", _buttMin)
state STATE_BUTT_MIN ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_buttMin.GetValue() )
		SetSliderDialogDefaultValue( 0.8 )
		SetSliderDialogRange( 0.1 , GV_buttMax.GetValue() )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_buttMin.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_buttMin.SetValue( 0.8 )
		SetSliderOptionValueST( 0.8, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Minimum butt size multiplier allowed")
	endEvent
endState
; AddSliderOptionST("STATE_SCHLONG_SWELL","Schlong swell modifier", _schlongSwellMod)
state STATE_SCHLONG_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_schlongSwellMod.GetValue()   )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value  
		GV_schlongSwellMod.SetValue( thisValue  )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_schlongSwellMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Schlong swell modifier - Amount of base change applied to schlong size (1 being the full amount).")
	endEvent
endState
; AddSliderOptionST("STATE_SCHLONG_MAX","Belly swell max", _bellyMax)
state STATE_SCHLONG_MAX ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_schlongMax.GetValue() )
		SetSliderDialogDefaultValue( 1.2 )
		SetSliderDialogRange( GV_schlongMin.GetValue(), 2.5 )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value as float
		GV_schlongMax.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_schlongMax.SetValue( 1.2 )
		SetSliderOptionValueST( 1.2, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Maximum schlong size multiplier allowed")
	endEvent
endState
; AddSliderOptionST("STATE_SCHLONG_MIN","Schlong swell min", _schlongMin)
state STATE_SCHLONG_MIN ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_schlongMin.GetValue() )
		SetSliderDialogDefaultValue( 0.5 )
		SetSliderDialogRange( 0.1 , GV_schlongMax.GetValue() )
		SetSliderDialogInterval( 0.2 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_schlongMin.SetValue( thisValue ) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals()

	endEvent

	event OnDefaultST()
		GV_schlongMin.SetValue( 0.5 )
		SetSliderOptionValueST( 0.5, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Minimum schlong size multiplier allowed")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_WEIGHT","Change Weight scale", _useWeight)
state STATE_CHANGE_WEIGHT ; TOGGLE
	event OnSelectST()
		GV_useWeight.SetValueInt( Math.LogicalXor( 1, GV_useWeight.GetValueInt() ) )
		SetToggleOptionValueST( GV_useWeight.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()

		if (GV_origWeight.GetValue()== -1)
			GV_origWeight.SetValue(pActorBase.GetWeight())
		EndIf

		GV_useWeight.SetValue( GV_origWeight.GetValue() )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow changes to Weight scale")
	endEvent
endState
; AddSliderOptionST("STATE_WEIGHT_SWELL","Weight swell mod", _weightSwellMod)
state STATE_WEIGHT_SWELL ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_weightSwellMod.GetValue() )
		SetSliderDialogDefaultValue( 1.0 ) ; Get starting weight as global variable
		SetSliderDialogRange( -2.0, 2.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_weightSwellMod.SetValue( thisValue )
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		GV_weightSwellMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0, "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Weight swell modifier - Amount of base change applied to weight (1 being the full amount)")
	endEvent
endState
; AddToggleOptionST("STATE_CHANGE_COLOR","Change colors", _useColors)
state STATE_CHANGE_COLOR ; TOGGLE
	event OnSelectST()
		GV_useColors.SetValueInt( Math.LogicalXor( 1, GV_useColors.GetValueInt() ) )
		SetToggleOptionValueST( GV_useColors.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useColors.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow change to skin color")
	endEvent
endState

; AddToggleOptionST("STATE_CHANGE_HairCOLOR","Change colors", _useHairColors)
state STATE_CHANGE_HAIRCOLOR ; TOGGLE
	event OnSelectST()
		GV_useHairColors.SetValueInt( Math.LogicalXor( 1, GV_useHairColors.GetValueInt() ) )
		SetToggleOptionValueST( GV_useHairColors.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_useHairColors.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow change to hair color")
	endEvent
endState

; AddColorOptionST("STATE_RED_COLOR_SHIFT","Red color shift", _redShiftColor as Int)
state STATE_RED_COLOR_SHIFT ; COLOR
	event OnColorOpenST()
		SetColorDialogStartColor( GV_redShiftColor.GetValue() as Int  )
		SetColorDialogDefaultColor( GV_redShiftColor.GetValue() as Int ) ; Get starting weight as global variable
	endEvent

	event OnColorAcceptST(int value)
		Int thisValue = value  
		GV_redShiftColor.SetValue( thisValue)   
		SetColorOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_redShiftColor.SetValue( 32 )
		SetColorOptionValueST( 32 )
	endEvent

	event OnHighlightST()
		SetInfoText("Red shift color - Color for 'red' shift from current color (blushing after sex)")
	endEvent
endState
; AddSliderOptionST("STATE_RED_COLOR_SHIFT_MOD","Red color shift mod", _redShiftColorMod as Float,"{1}")
state STATE_RED_COLOR_SHIFT_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_redShiftColorMod.GetValue()  )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_redShiftColorMod.SetValue( thisValue)   
		SetSliderOptionValueST( thisValue, "{1}" )
	endEvent

	event OnDefaultST()
		GV_redShiftColorMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0 , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Red shift color modifier - Amount of base change applied to shift to red color from current color (1 being the full amount)")
	endEvent
endState

; AddColorOptionST("STATE_BLUE_COLOR_SHIFT","Blue color shift", _blueShiftColor as Int)
state STATE_BLUE_COLOR_SHIFT ; COLOR
	event OnColorOpenST()
		SetColorDialogStartColor( GV_blueShiftColor.GetValue()  as Int )
		SetColorDialogDefaultColor( GV_blueShiftColor.GetValue()  as Int) ; Get starting weight as global variable
	endEvent

	event OnColorAcceptST(int value)
		Int thisValue = value 
		GV_blueShiftColor.SetValue( thisValue )   
		SetColorOptionValueST( thisValue )
	endEvent

	event OnDefaultST()
		GV_blueShiftColor.SetValue( 3 )
		SetColorOptionValueST( 3 )
	endEvent

	event OnHighlightST()
		SetInfoText("Blue shift color - Color for 'blue' shift from current color (sex withdrawal)")
	endEvent
endState

; AddSliderOptionST("STATE_BLUE_COLOR_SHIFT_MOD","Blue color shift mod", _blueShiftColorMod as Float,"{1}")
state STATE_BLUE_COLOR_SHIFT_MOD ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_blueShiftColorMod.GetValue()  )
		SetSliderDialogDefaultValue( 1.0 )  
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_blueShiftColorMod.SetValue( thisValue)   
		SetSliderOptionValueST( thisValue, "{1}" )
	endEvent

	event OnDefaultST()
		GV_blueShiftColorMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0 , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Blue shift color modifier - Amount of base change applied to shift to blue color from current color (1 being the full amount)")
	endEvent
endState

; AddSliderOptionST("STATE_WEIGHT_VALUE","Weight", _weightSetValue as Float,"{1}")
state STATE_WEIGHT_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_weightValue.GetValue()  )
		SetSliderDialogDefaultValue( GV_weightValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_weightMin.GetValue(), GV_weightMax.GetValue() )
		SetSliderDialogInterval( 10.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 

		float fOldWeight = StorageUtil.GetFloatValue(PlayerActor, "_SLH_fWeight")

		GV_weightValue.SetValue( thisValue) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight",  thisValue) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fManualWeightChange",  fOldWeight) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_weightValue.GetValue() , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Set Weight to this value.")
	endEvent
endState
; AddSliderOptionST("STATE_BREAST_VALUE","Breast", _breastSetValue as Float,"{1}")
state STATE_BREAST_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_breastValue.GetValue() )
		SetSliderDialogDefaultValue( GV_breastValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_breastMin.GetValue(), GV_breastMax.GetValue() )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_breastValue.SetValue(thisValue)
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  thisValue)
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_breastValue.GetValue(), "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Set Breasts nodes to this value.")
	endEvent
endState
; AddSliderOptionST("STATE_BELLY_VALUE","Belly", _bellySetValue as Float,"{1}")
state STATE_BELLY_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bellyValue.GetValue()  )
		SetSliderDialogDefaultValue( GV_bellyValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_bellyMin.GetValue(), GV_bellyMax.GetValue() )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_bellyValue.SetValue(thisValue) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly",  thisValue) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_bellyValue.GetValue(), "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Set Belly nodes to this value.")
	endEvent
endState
; AddSliderOptionST("STATE_BUTT_VALUE","Butt", _buttSetValue as Float,"{1}")
state STATE_BUTT_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_buttValue.GetValue()  )
		SetSliderDialogDefaultValue(  GV_buttValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_buttMin.GetValue(), GV_buttMax.GetValue() )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_buttValue.SetValue(thisValue)
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt",  thisValue) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_buttValue.GetValue() , "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Set Butt nodes to this value.")
	endEvent
endState
; AddSliderOptionST("STATE_SCHLONG_VALUE","Schlong", _schlongSetValue as Float,"{1}")
state STATE_SCHLONG_VALUE ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_schlongValue.GetValue()  )
		SetSliderDialogDefaultValue( GV_schlongValue.GetValue() ) ; Get starting weight as global variable
		SetSliderDialogRange( GV_schlongMin.GetValue(), GV_schlongMax.GetValue() )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_schlongValue.SetValue(thisValue) 
		StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlong",  thisValue) 
		SetSliderOptionValueST( thisValue, "{1}" )

		refreshStorageFromGlobals() 

	endEvent

	event OnDefaultST()
		SetSliderOptionValueST( GV_schlongValue.GetValue(), "{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Set Schlong nodes to this value.")
	endEvent
endState
; AddToggleOptionST("STATE_REFRESH","Apply changes", _refreshToggle as Float)
state STATE_REFRESH ; TOGGLE
	event OnSelectST()
		; SLH_Control._refreshBodyShape()

		refreshStorageFromGlobals() 
		
		Debug.MessageBox("Exit the menu and wait a few seconds")
	endEvent

	event OnDefaultST()
		; Simple button - no default state
	endEvent

	event OnHighlightST()
		SetInfoText("Apply these values to current Hormones settings.")
	endEvent
endState

; AddToggleOptionST("STATE_SUCCUBUS","Succubus mode", _allowSuccubus)
state STATE_SUCCUBUS ; TOGGLE
	event OnSelectST()
		GV_allowSuccubus.SetValueInt( Math.LogicalXor( 1, GV_allowSuccubus.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSuccubus", GV_allowSuccubus.GetValue() as Int)
		SetToggleOptionValueST( GV_allowSuccubus.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowSuccubus.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSuccubus", GV_allowSuccubus.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Succubus curse - Caused by exposure to Daedric influence.")
	endEvent
endState
state STATE_SET_SUCCUBUS ; TOGGLE
	event OnSelectST()
		_setSuccubus = Math.LogicalXor( 1, _setSuccubus ) 
		SetToggleOptionValueST( _setSuccubus as Bool )
		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus") == 0)
			PlayerActor.SendModEvent("SLHCastSuccubusCurse")
		else
			; Debug.MessageBox("Unfortunately.. there is no cure for a Succubus")
			PlayerActor.SendModEvent("SLHCureSuccubusCurse")
		EndIf
		ForcePageReset()
	endEvent

	event OnDefaultST() 
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iSuccubus") as Bool )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Toggle Succubus - Set or clear the succubus effect now (for player starts or rolepay)")
	endEvent
endState
; AddToggleOptionST("STATE_BIMBO","Sex Change Curse", _allowBimbo)
state STATE_BIMBO ; TOGGLE
	event OnSelectST()
		GV_allowBimbo.SetValueInt( Math.LogicalXor( 1, GV_allowBimbo.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimbo", GV_allowBimbo.GetValue() as Int)
		SetToggleOptionValueST( GV_allowBimbo.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowBimbo.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimbo", GV_allowBimbo.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Bimbo Curse - This curse could turn you into a mindless sex-starved blonde.")
	endEvent
endState
state STATE_SET_BIMBO ; TOGGLE
	event OnSelectST()
		_setBimbo = Math.LogicalXor( 1, _setBimbo ) 
		SetToggleOptionValueST( _setBimbo as Bool )
		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo") == 0)
			PlayerActor.SendModEvent("SLHCastBimboCurse")
		else
			PlayerActor.SendModEvent("SLHCureBimboCurse")
		endIf

		ForcePageReset()
	endEvent

	event OnDefaultST() 
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iBimbo") as Bool )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Toggle Bimbo - Set or clear the bimbo effect now (for player starts or rolepay)")
	endEvent
endState
; AddToggleOptionST("STATE_BIMBO","Sex Change Curse", _allowBimboRace)
state STATE_BIMBO_RACE ; TOGGLE
	event OnSelectST()
		GV_allowBimboRace.SetValueInt( Math.LogicalXor( 1, GV_allowBimboRace.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimboRace", GV_allowBimboRace.GetValue() as Int)
		SetToggleOptionValueST( GV_allowBimboRace.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowBimboRace.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowBimboRace", GV_allowBimboRace.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Bimbo Race - Use the custom Bimbo race for the transformation. If unselected, the current race of the player will be preserved.")
	endEvent
endState
; AddSliderOptionST("STATE_BIMBO_CLUMSINESS","Bimbo clumsiness factor", _bimboClumsinessMod)
state STATE_BIMBO_CLUMSINESS ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_bimboClumsinessMod.GetValue() )
		SetSliderDialogDefaultValue( 1.0 )
		SetSliderDialogRange( 0.0, 1.0 )
		SetSliderDialogInterval( 0.1 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_bimboClumsinessMod.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{1}") 
	endEvent

	event OnDefaultST()
		GV_bimboClumsinessMod.SetValue( 1.0 )
		SetSliderOptionValueST( 1.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Bimbo clumsiness factor - To throttle dropping weapons or stumbling to the ground from 0 (no effect) to 1.0 (default range of clumsiness)")
	endEvent
endState

; AddToggleOptionST("STATE_HORNY_BEG","Beg for sex", _hornyBegON   as Bool)
state STATE_HORNY_BEG ; TOGGLE
	event OnSelectST()
		GV_hornyBegON.SetValueInt( Math.LogicalXor( 1, GV_hornyBegON.GetValueInt() ) )
		SetToggleOptionValueST( GV_hornyBegON.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_hornyBegON.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Bimbo beg for sex when aroused. Begging topics will block all other dialogues until arousal falls below threshold.")
	endEvent
endState
; AddSliderOptionST("STATE_BEG_TRIGGER","Beg arousal trigger", _hornyBegArousal  as Float,"{1}")
state STATE_BEG_TRIGGER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_hornyBegArousal.GetValue() )
		SetSliderDialogDefaultValue( 60.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_hornyBegArousal.SetValue( thisValue )
		SetSliderOptionValueST( thisValue ,"{1}") 
	endEvent

	event OnDefaultST()
		GV_hornyBegArousal.SetValue( 60.0 )
		SetSliderOptionValueST( 60.0,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Arousal threshold to trigger forced begging topic for a Bimbo.")
	endEvent
endState
; AddSliderOptionST("STATE_GRAB_TRIGGER","Public sex attack", _hornyGrab  as Float,"{1}")
state STATE_GRAB_TRIGGER ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( _hornyGrab )
		SetSliderDialogDefaultValue( 30.0 )
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 1.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		_hornyGrab = thisValue 
		StorageUtil.SetFloatValue(none, "_SLH_fHornyGrab", _hornyGrab)
		SetSliderOptionValueST( thisValue ,"{1}") 
	endEvent

	event OnDefaultST()
		_hornyGrab = 30.0 
		StorageUtil.SetFloatValue(none, "_SLH_fHornyGrab", _hornyGrab)
		SetSliderOptionValueST( _hornyGrab,"{1}" )
	endEvent

	event OnHighlightST()
		SetInfoText("Chance of attack by onlooker if player has sex in public.")
	endEvent
endState
; AddToggleOptionST("STATE_BIMBO_DROP","Drop items when aroused", _bimboClumsinessDrop  as Bool)
state STATE_BIMBO_DROP ; TOGGLE
	event OnSelectST()
		GV_bimboClumsinessDrop.SetValueInt( Math.LogicalXor( 1, GV_bimboClumsinessDrop.GetValueInt() ) )
		SetToggleOptionValueST( GV_allowHRT.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_bimboClumsinessDrop.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("At high arousal values, Bimbo will be clumsy and drop equipped weapons in combat. This may cause dropped weapons to fall through the ground and be lost in some terrains.")
	endEvent
endState
; AddToggleOptionST("STATE_SEX_CHANGE","Sex Change Curse", _isHRT)
state STATE_SEX_CHANGE ; TOGGLE
	event OnSelectST()
		GV_allowHRT.SetValueInt( Math.LogicalXor( 1, GV_allowHRT.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowHRT", GV_allowHRT.GetValue() as Int)
		SetToggleOptionValueST( GV_allowHRT.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowHRT.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowHRT", GV_allowHRT.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Sex Change Curse - This curse could turn your gender upside down.")
	endEvent
endState
state STATE_SET_SEXCHANGE ; TOGGLE
	event OnSelectST()
		_setHRT = Math.LogicalXor( 1, _setHRT ) 
		SetToggleOptionValueST( _setHRT as Bool )
		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iHRT") == 0)
			PlayerActor.SendModEvent("SLHCastHRTCurse")
		else
			PlayerActor.SendModEvent("SLHCureHRTCurse")
		endIf
		ForcePageReset()
	endEvent

	event OnDefaultST() 
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iHRT") as Bool )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Toggle Sex Change - Set or clear the sex change effect now (for player starts or rolepay)")
	endEvent
endState
; AddToggleOptionST("STATE_TG","Allow Transgender", _isTG)
state STATE_TG ; TOGGLE
	event OnSelectST()
		GV_allowTG.SetValueInt( Math.LogicalXor( 1, GV_allowTG.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowTG", GV_allowTG.GetValue() as Int)
		SetToggleOptionValueST( GV_allowTG.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowTG.SetValueInt( 0 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowTG", GV_allowTG.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow Transgender - This option enables smoother transitions from male to female, with an intermediate state (female with male genitals).")
	endEvent
endState
state STATE_SET_TG ; TOGGLE
	event OnSelectST()
		_setTG = Math.LogicalXor( 1, _setTG ) 
		SetToggleOptionValueST( _setTG as Bool )
		If (StorageUtil.GetIntValue(PlayerActor, "_SLH_iTG") == 0)
			PlayerActor.SendModEvent("SLHCastTGCurse")
		else
			PlayerActor.SendModEvent("SLHCureTGCurse")
		endIf
		ForcePageReset()
	endEvent

	event OnDefaultST() 
		SetToggleOptionValueST( StorageUtil.GetIntValue(PlayerActor, "_SLH_iTG") as Bool )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Toggle Transgender - Set or clear the transgender effect now (for player starts or rolepay)")
	endEvent
endState

; AddToggleOptionST("STATE_EXHIBITIONIST","Allow Exhibitionist", _allowExhibitionist)
state STATE_EXHIBITIONIST ; TOGGLE
	event OnSelectST()
		GV_allowExhibitionist.SetValueInt( Math.LogicalXor( 1, GV_allowExhibitionist.GetValueInt() ) )
		SetToggleOptionValueST( GV_allowExhibitionist.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowExhibitionist.SetValueInt( 1 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow Exhibitionist - High levels of arousal will automatically make your character Exhibitionist in SexLab Arousal.")
	endEvent
endState
; AddToggleOptionST("STATE_SELF_SPELLS","Allow Self Spells", _allowSelfSpells)
state STATE_SELF_SPELLS ; TOGGLE
	event OnSelectST()
		GV_allowSelfSpells.SetValueInt( Math.LogicalXor( 1, GV_allowSelfSpells.GetValueInt() ) )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSelfSpells", GV_allowTG.GetValue() as Int)
		SetToggleOptionValueST( GV_allowSelfSpells.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_allowSelfSpells.SetValueInt( 1 )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_allowSelfSpells", GV_allowTG.GetValue() as Int)
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Allow Self Spells - Enable spells for Undress and Masturbation when loading your save game (quit and reload to see the change).")
	endEvent
endState
; AddToggleOptionST("STATE_STATUS","Display status", _statusToggle)
state STATE_STATUS ; TOGGLE
	event OnSelectST()
		SLH_Control.showStatus()
	endEvent

	event OnDefaultST()
		; Simple button - no default state
	endEvent

	event OnHighlightST()
		SetInfoText("Display full status for current hormone changes.")
	endEvent
endState

; AddToggleOptionST("STATE_SHOW_STATUS","Show Status messages", _showStatus as Bool)
state STATE_SHOW_STATUS ; TOGGLE
	event OnSelectST()
		GV_showStatus.SetValueInt( Math.LogicalXor( 1, GV_showStatus.GetValueInt() ) )
		SetToggleOptionValueST( GV_showStatus.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_showStatus.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Show Player Status messages - Display messages about the player's sexual status.")
	endEvent
endState

; AddSliderOptionST("STATE_COMMENTS_FREQUENCY","NPC Comments Frequency ", _commentsFrequency as Float,"{1}")
state STATE_COMMENTS_FREQUENCY ; SLIDER
	event OnSliderOpenST()
		SetSliderDialogStartValue( GV_commentsFrequency.GetValue()  )
		SetSliderDialogDefaultValue( 70.0 )  
		SetSliderDialogRange( 0.0, 100.0 )
		SetSliderDialogInterval( 10.0 )
	endEvent

	event OnSliderAcceptST(float value)
		float thisValue = value 
		GV_commentsFrequency.SetValue(thisValue)  

		SetSliderOptionValueST( thisValue, "{1} %" )
	endEvent

	event OnDefaultST()
		GV_commentsFrequency.SetValue(70.0)
		SetSliderOptionValueST( 70.0, "{1} %" )
	endEvent

	event OnHighlightST()
		SetInfoText("NPC Comments Frequency - Percent chance to see NPCs making comments about the Player's libido (sex reputation).")
	endEvent
endState

; AddToggleOptionST("STATE_CHANGE_OVERRIDE","Shape change override", _changeOverrideToggle)
state STATE_CHANGE_OVERRIDE ; TOGGLE
	event OnSelectST()
		GV_changeOverrideToggle.SetValueInt( Math.LogicalXor( 1, GV_changeOverrideToggle.GetValueInt() ) )
		SetToggleOptionValueST( GV_changeOverrideToggle.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_changeOverrideToggle.SetValueInt( 0 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Check to let Hormones refresh shape by itself. Unckech if you are using another shape modifying mod with its own refresh schedule (Pregnancy mods for example).")
	endEvent

endState

; AddToggleOptionST("STATE_UPDATE_ON_CELL","Update on cell change", _shapeUpdateOnCellChange as Float)
state STATE_UPDATE_ON_CELL ; TOGGLE
	event OnSelectST()
		GV_shapeUpdateOnCellChange.SetValueInt( Math.LogicalXor( 1, GV_shapeUpdateOnCellChange.GetValueInt() ) )
		SetToggleOptionValueST( GV_shapeUpdateOnCellChange.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_shapeUpdateOnCellChange.SetValueInt( 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Check to apply shape changes when player changes cell.")
	endEvent

endState
; AddToggleOptionST("STATE_UPDATE_ON_SEX","Update after sex", _shapeUpdateAfterSex as Float)
state STATE_UPDATE_ON_SEX ; TOGGLE
	event OnSelectST()
		GV_shapeUpdateAfterSex.SetValueInt( Math.LogicalXor( 1, GV_shapeUpdateAfterSex.GetValueInt() ) )
		SetToggleOptionValueST( GV_shapeUpdateAfterSex.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_shapeUpdateAfterSex.SetValueInt( 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Check to apply shape changes after sex.")
	endEvent

endState
; AddToggleOptionST("STATE_UPDATE_ON_TIMER","Update on timer", _shapeUpdateOnTimer as Float)
state STATE_UPDATE_ON_TIMER ; TOGGLE
	event OnSelectST()
		GV_shapeUpdateOnTimer.SetValueInt( Math.LogicalXor( 1, GV_shapeUpdateOnTimer.GetValueInt() ) )
		SetToggleOptionValueST( GV_shapeUpdateOnTimer.GetValueInt() as Bool )
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_shapeUpdateOnTimer.SetValueInt( 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Check to apply shape changes on a timer (once a day or after sleep).")
	endEvent

endState
; AddToggleOptionST("STATE_ENABLE_NODE_UPDATE","Enable node updates", _enableNiNodeUpdate as Float)
state STATE_ENABLE_NODE_UPDATE ; TOGGLE
	event OnSelectST()
		; NiOverride and QueueNodeUpdates are mutually exclusive
		GV_enableNiNodeUpdate.SetValueInt( Math.LogicalXor( 1, GV_enableNiNodeUpdate.GetValueInt() ) )
		GV_enableNiNodeOverride.SetValueInt( 0 )
		SetToggleOptionValueST( GV_enableNiNodeUpdate.GetValueInt() as Bool )
		refreshStorageFromGlobals()
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_enableNiNodeUpdate.SetValueInt( 0 )
		SetToggleOptionValueST( false )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Check to let Hormones apply node changes directly. Uncheck if you already have a mod making regular node changes (Bathing/Dirt mod for example) as too frequent changes can cause crashes.")
	endEvent

endState
; AddToggleOptionST("STATE_ENABLE_NODE_OVERRIDE","Enable node override", _enableNiNodeOverride as Float)
state STATE_ENABLE_NODE_OVERRIDE ; TOGGLE
	event OnSelectST()
		; NiOverride and QueueNodeUpdates are mutually exclusive
		GV_enableNiNodeOverride.SetValueInt( Math.LogicalXor( 1, GV_enableNiNodeOverride.GetValueInt() ) )
		GV_enableNiNodeUpdate.SetValueInt( 0)
		SetToggleOptionValueST( GV_enableNiNodeOverride.GetValueInt() as Bool )
		refreshStorageFromGlobals()
		ForcePageReset()
	endEvent

	event OnDefaultST()
		GV_enableNiNodeOverride.SetValueInt( 1 )
		SetToggleOptionValueST( true )
		ForcePageReset()
	endEvent

	event OnHighlightST()
		SetInfoText("Check to let Hormones use NiOverride. Useful if you are using other mods compatible with NiOverride to apply changes to the player's body.")
	endEvent

endState

; AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle)
state STATE_SETSHAPE ; TOGGLE
	event OnSelectST()
		; SLH_Control._resetHormonesState()
		; refreshStorageFromGlobals()
		PlayerActor.SendModEvent("SLHSetShape")

		Debug.MessageBox("Shape initialized - Exit the menu and wait a few seconds")
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Set shape - records default shape to current values of race, weight, shape and color. Use this option if you change race during the game (vampire or other transformations)")
	endEvent

endState

; AddToggleOptionST("STATE_DEBUG","Debug messages", _showDebug)
state STATE_DEBUG ; TOGGLE
	event OnSelectST()
		Int _showDebugInt = ( Math.LogicalXor( 1, _showDebug as Int ) )
		_showDebug = _showDebugInt as Bool
		StorageUtil.SetIntValue(none, "_SLH_debugTraceON", _showDebugInt)
		SetToggleOptionValueST( _showDebugInt )
		refreshStorageFromGlobals()
		ForcePageReset()
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Enable or disable debug messages in the Papyrus Log")
	endEvent

endState


; AddToggleOptionST("STATE_RESET","Reset changes", _resetToggle)
state STATE_RESET ; TOGGLE
	event OnSelectST()
		; SLH_Control._resetHormonesState()
		PlayerActor.SendModEvent("SLHResetShape")

		Debug.MessageBox("Shape reset - Exit the menu and wait a few seconds")
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Reset changes - Resets character to original weight, shape and color.")
	endEvent

endState


; AddToggleOptionST("STATE_BALANCE","Reset changes", _applyNodeBalancing  )
state STATE_BALANCE ; TOGGLE
	event OnSelectST()
		_applyNodeBalancing = Math.LogicalXor( 1, _applyNodeBalancing )
		StorageUtil.SetIntValue(PlayerActor, "_SLH_iNodeBalancing", _applyNodeBalancing)
		SLH_Control._nodeBalancing()
		ForcePageReset()
	endEvent

	event OnDefaultST()

	endEvent

	event OnHighlightST()
		SetInfoText("Automatically adjusts max size of NetImmerse Overrides used by several mods (NiO required).")
	endEvent

endState


float function fMin(float  a, float b)
	if (a<=b)
		return a
	else
		return b
	EndIf
EndFunction

float function fMax(float a, float b)
	if (a<=b)
		return b
	else
		return a
	EndIf
EndFunction

Function refreshStorageFromGlobals()
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreastSwellMod",  GV_breastSwellMod.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButtSwellMod",  GV_buttSwellMod.GetValue() as Float)  
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBellySwellMod",  GV_bellySwellMod.GetValue() as Float)  
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlongSwellMod",  GV_schlongSwellMod.GetValue() as Float)  
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeightSwellMod",  GV_weightSwellMod.GetValue() as Float)  

	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreastMax",  GV_breastMax.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButtMax",  GV_buttMax.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBellyMax",  GV_bellyMax.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlongMax",  GV_schlongMax.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeightMax",  GV_weightMax.GetValue() as Float) 

	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreastMin",  GV_breastMin.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButtMin",  GV_buttMin.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBellyMin",  GV_bellyMin.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlongMin",  GV_schlongMin.GetValue() as Float) 

	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBreast",  GV_breastValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fButt",  GV_buttValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fBelly",  GV_bellyValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fSchlong",  GV_schlongValue.GetValue() as Float) 
	StorageUtil.SetFloatValue(PlayerActor, "_SLH_fWeight",  GV_weightValue.GetValue() as Float) 

	PlayerActor.SendModEvent("SLHRefresh")

EndFunction





