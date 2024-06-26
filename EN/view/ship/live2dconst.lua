slot0 = class("Live2dConst")
slot0.UnLoadL2dPating = nil

slot0.SaveL2dIdle = function(slot0, slot1, slot2)
	PlayerPrefs.SetInt(uv0.GetL2dIdleSaveName(slot0, slot1), slot2)
end

slot0.SaveL2dAction = function(slot0, slot1, slot2)
	PlayerPrefs.SetInt(uv0.GetL2dActionSaveName(slot0, slot1), slot2)
end

slot0.GetL2dIdleSaveName = function(slot0, slot1)
	return "l2d_" .. tostring(slot0) .. "_" .. tostring(slot1) .. "_idle_index"
end

slot0.GetL2dActionSaveName = function(slot0, slot1)
	return "l2d_" .. tostring(slot0) .. "_" .. tostring(slot1) .. "_action_id"
end

slot0.GetL2dSaveData = function(slot0, slot1)
	return PlayerPrefs.GetInt(uv0.GetL2dIdleSaveName(slot0, slot1)), PlayerPrefs.GetInt(uv0.GetL2dActionSaveName(slot0, slot1))
end

slot0.SaveDragData = function(slot0, slot1, slot2, slot3)
	PlayerPrefs.SetFloat(uv0.GetDragSaveName(slot0, slot1, slot2), slot3)
end

slot0.GetDragData = function(slot0, slot1, slot2)
	return PlayerPrefs.GetFloat(uv0.GetDragSaveName(slot0, slot1, slot2))
end

slot0.GetDragSaveName = function(slot0, slot1, slot2)
	return "l2d_drag_" .. tostring(slot0) .. "_" .. tostring(slot1) .. "_" .. tostring(slot2) .. "_target"
end

slot0.SetDragActionIndex = function(slot0, slot1, slot2, slot3)
	PlayerPrefs.SetInt(uv0.GetDragActionIndexName(slot0, slot1, slot2), slot3)
end

slot0.GetDragActionIndex = function(slot0, slot1, slot2)
	if not PlayerPrefs.GetInt(uv0.GetDragActionIndexName(slot0, slot1, slot2)) or slot4 <= 0 then
		slot4 = 1
	end

	return slot4
end

slot0.GetDragActionIndexName = function(slot0, slot1, slot2)
	return "l2d_drag_" .. tostring(slot0) .. "_" .. tostring(slot1) .. "_" .. tostring(slot2) .. "_action_index"
end

slot0.ClearLive2dSave = function(slot0, slot1)
	if not slot0 or not slot1 then
		warning("skinId 或 shipId 不能为空")

		return
	end

	if not pg.ship_skin_template[slot0] then
		warning("找不到skinId" .. tostring(slot0) .. " 清理失败")

		return
	end

	if pg.ship_skin_template[slot0].ship_l2d_id and #slot2 > 0 then
		Live2dConst.SaveL2dIdle(slot0, slot1, 0)

		slot6 = 0

		Live2dConst.SaveL2dAction(slot0, slot1, slot6)

		for slot6, slot7 in ipairs(slot2) do
			if pg.ship_l2d[slot7] then
				Live2dConst.SaveDragData(slot7, slot0, slot1, pg.ship_l2d[slot7].start_value or 0)
				Live2dConst.SetDragActionIndex(slot7, slot0, slot1, 1)
			else
				warning(tostring(slot7) .. "不存在，不清理该dragid")
			end
		end
	end

	pg.TipsMgr.GetInstance():ShowTips(i18n("live2d_reset_desc"))
end

return slot0
