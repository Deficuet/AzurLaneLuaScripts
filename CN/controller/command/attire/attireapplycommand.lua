slot0 = class("AttireApplyCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	slot2 = slot1:getBody()

	if not getProxy(AttireProxy):getAttireFrame(slot2.type, slot2.id) then
		return
	end

	slot6 = getProxy(PlayerProxy)
	slot7 = slot6:getData()
	slot8 = pg.ConnectionMgr.GetInstance()

	slot8:Send(11005, {
		id = slot3,
		type = slot4
	}, 11006, function (slot0)
		if slot0.result == 0 then
			uv0:updateAttireFrame(uv1, uv2)
			uv3:updatePlayer(uv0)
			uv4:sendNotification(GAME.ATTIRE_APPLY_DONE)
		else
			print(slot0.result)
		end
	end)
end

return slot0
