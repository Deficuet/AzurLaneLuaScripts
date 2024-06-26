slot0 = class("ChangeMedalDisplayCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	slot3 = slot1:getBody().medalList
	slot6 = getProxy(PlayerProxy):getData().displayTrophyList
	slot7 = 0

	while slot7 < 5 do
		if slot3[slot7] ~= slot6[slot7] then
			break
		end

		if slot7 == 5 then
			return
		end

		slot7 = slot7 + 1
	end

	slot8 = {}

	for slot12, slot13 in ipairs(slot3) do
		table.insert(slot8, slot13)
	end

	slot9 = pg.ConnectionMgr.GetInstance()

	slot9:Send(17401, {
		fixed_const = 1,
		medal_id = slot8
	}, 17402, function (slot0)
		if slot0.result == 0 then
			uv0:updatePlayerMedalDisplay(uv1)
			pg.TipsMgr.GetInstance():ShowTips(i18n("change_display_medal_success"))
			uv2:sendNotification(GAME.CHANGE_PLAYER_MEDAL_DISPLAY_DONE)
		end
	end)
end

return slot0
