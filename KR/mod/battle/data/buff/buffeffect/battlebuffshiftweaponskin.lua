ys = ys or {}
slot0 = ys
slot0.Battle.BattleBuffShiftWeaponSkin = class("BattleBuffShiftWeaponSkin", slot0.Battle.BattleBuffEffect)
slot0.Battle.BattleBuffShiftWeaponSkin.__name = "BattleBuffShiftWeaponSkin"
slot1 = slot0.Battle.BattleBuffShiftWeaponSkin

slot1.Ctor = function(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)
end

slot1.SetArgs = function(slot0, slot1, slot2)
	slot0._weaponIndex = slot0._tempData.arg_list.index
	slot0._skinID = slot0._tempData.arg_list.skin_id
end

slot1.onAttach = function(slot0, slot1, slot2)
	slot0:shiftWeaponSkin(slot1)
end

slot1.onRemove = function(slot0, slot1, slot2)
end

slot1.shiftWeaponSkin = function(slot0, slot1)
	slot2 = slot1:GetAllWeapon()

	for slot6, slot7 in ipairs(slot0._indexRequire) do
		for slot11, slot12 in ipairs(slot2) do
			if slot12:GetEquipmentIndex() == slot7 then
				slot12:SetSkinData(slot0._skinID)
			end
		end
	end
end
