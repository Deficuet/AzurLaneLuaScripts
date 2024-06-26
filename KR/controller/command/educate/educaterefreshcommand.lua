slot0 = class("EducateRefreshCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	slot3 = slot1:getBody() and slot2.callback

	pg.ConnectionMgr.GetInstance():Send(27047, {
		type = 1
	}, 27048, function (slot0)
		if slot0.result == 0 then
			getProxy(EducateProxy):Refresh(function ()
				uv0:sendNotification(GAME.EDUCATE_REFRESH_DONE)
			end)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate refresh error: ", slot0.result))
		end
	end)
end

return slot0
