--No.66 覇鍵甲虫マスター・キー・ビートル
---@param c Card
function c76067258.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),4,2)
	c:EnableReviveLimit()
	--target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76067258,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c76067258.cost)
	e1:SetTarget(c76067258.target)
	e1:SetOperation(c76067258.operation)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_TARGET)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--desrep
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c76067258.reptg)
	c:RegisterEffect(e3)
end
aux.xyz_number[76067258]=66
function c76067258.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c76067258.filter(c,ec)
	return not ec:IsHasCardTarget(c)
end
function c76067258.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc~=c and c76067258.filter(chkc,c) end
	if chk==0 then return Duel.IsExistingTarget(c76067258.filter,tp,LOCATION_ONFIELD,0,1,c,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c76067258.filter,tp,LOCATION_ONFIELD,0,1,1,c,c)
end
function c76067258.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e)
		and not tc:IsImmuneToEffect(e) then
		c:SetCardTarget(tc)
		tc:RegisterFlagEffect(76067258,RESET_EVENT+RESETS_STANDARD,0,0)
	end
end
function c76067258.repfilter(c,tp)
	return c:IsControler(tp) and c:GetFlagEffect(76067258)~=0
end
function c76067258.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetCardTarget():IsExists(c76067258.repfilter,1,nil,tp)
		and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=c:GetCardTarget():FilterSelect(tp,c76067258.repfilter,1,1,nil,tp)
		Duel.SendtoGrave(g,REASON_EFFECT)
		return true
	else return false end
end
