scriptname CampTentShelterCollider extends ObjectReference

ObjectReference property ParentTent auto

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if ParentTent
		(ParentTent as _Camp_PlaceableObjectBase).ProcessOnHit(akAggressor, akSource, akProjectile, abBashAttack)
	endif
EndEvent

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	if ParentTent
		(ParentTent as _Camp_PlaceableObjectBase).ProcessMagicEffect(akCaster, akEffect)
	endif
EndEvent