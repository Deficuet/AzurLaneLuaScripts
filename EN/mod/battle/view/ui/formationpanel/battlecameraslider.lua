ys = ys or {}
slot0 = ys
slot1 = slot0.Battle.BattleConfig
slot0.Battle.BattleCameraSlider = class("BattleCameraSlider")
slot2 = class("BattleCameraSlider")
slot0.Battle.BattleCameraSlider = slot2
slot2.__name = "BattleCameraSlider"

slot2.Ctor = function(slot0, slot1)
	slot0._go = slot1

	slot0:Init()
end

slot2.Init = function(slot0)
	SetActive(slot0._go, true)

	slot0._distY = 0
	slot0._distX = 0
	slot0._dirY = 0
	slot0._dirX = 0
	slot0._isPress = false
	slot1 = pg.CameraFixMgr.GetInstance()
	slot0._screenHeight = slot1.actualHeight
	slot0._screenWidth = slot1.actualWidth

	slot0._go:GetComponent("StickController"):SetStickFunc(function (slot0, slot1)
		uv0:updateStick(slot0, slot1)
	end)
end

slot2.updateStick = function(slot0, slot1, slot2)
	slot0._initX = false
	slot0._initY = false

	if slot2 == -1 then
		slot0._startX = nil
		slot0._startY = nil
		slot0._isPress = false
	else
		slot0._isPress = true
		slot3 = slot1.x
		slot4 = slot1.y

		if slot0._startX == nil then
			slot0._startX = slot3
			slot0._startY = slot4
			slot0._initX = true
			slot0._initY = true
		else
			if (slot3 - slot0._lastPosX) * slot0._dirX < 0 then
				slot0._startX = slot3
				slot0._initX = true
			end

			if slot5 ~= 0 then
				slot0._dirX = slot5
			end

			if (slot4 - slot0._lastPosY) * slot0._dirY < 0 then
				slot0._startY = slot4
				slot0._initY = true
			end

			if slot6 ~= 0 then
				slot0._dirY = slot6
			end
		end

		slot0._distX = (slot3 - slot0._startX) / slot0._screenWidth
		slot0._distY = (slot4 - slot0._startY) / slot0._screenHeight
	end

	slot0._lastPosX = slot1.x
	slot0._lastPosY = slot1.y
end

slot2.GetDistance = function(slot0)
	return slot0._distX, slot0._distY
end

slot2.IsFirstPress = function(slot0)
	return slot0._initX, slot0._initY
end

slot2.IsPress = function(slot0)
	return slot0._isPress
end
