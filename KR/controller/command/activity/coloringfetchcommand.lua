slot0 = class("ColoringFetchCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	slot4 = pg.ConnectionMgr.GetInstance()

	slot4:Send(26008, {
		act_id = slot1:getBody().activityId
	}, 26001, function (slot0)
		getProxy(ColoringProxy):netUpdateData(slot0)
		uv0:sendNotification(GAME.COLORING_FETCH_DONE)
	end)
end

return slot0
