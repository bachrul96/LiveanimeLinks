--E・HERO ネオス・ナイト (Anime)
--Elemental HERO Neos Knight (Anime)
function c511002031.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcMix(c,true,true,89943723,aux.FilterBoolFunctionEx(Card.IsRace,RACE_WARRIOR))
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(c511002031.valcheck)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c511002031.atkcon)
	e3:SetOperation(c511002031.atkop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--multiatk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
c511002031.listed_names={89943723,24094653}
c511002031.material_setcode={0x8,0x3008,0x9}
function c511002031.valcheck(e,c)
	local g=c:GetMaterial()
	local atk=-1
	local tc=g:GetFirst()
	if tc:IsCode(89943723) or tc:IsHasEffect(EFFECT_FUSION_SUBSTITUTE) then tc=g:GetNext() end
	if not tc:IsCode(89943723) then
		atk=tc:GetTextAttack()/2
	end
	e:SetLabel(atk)
end
function c511002031.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c511002031.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=e:GetLabelObject():GetLabel()
	if atk>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end