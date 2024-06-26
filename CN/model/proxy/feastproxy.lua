slot0 = class("FeastProxy", import("model.proxy.NetProxy"))

slot0.register = function(slot0)
end

slot1 = function(slot0, slot1, slot2)
	if slot0:getRawData() ~= nil then
		slot2()

		return
	end

	slot0:sendNotification(GAME.GET_FEAST_DATA, {
		activityId = slot1.id,
		callback = slot2
	})
end

slot2 = function(slot0, slot1, slot2)
	slot4 = slot1:getConfig("config_data")[1] or 5

	if not slot0:getRawData():ShouldRandomShips() then
		slot2()

		return
	end

	slot0:sendNotification(GAME.FEAST_OP, {
		activityId = slot1.id,
		cmd = FeastDorm.OP_RANDOM_SHIPS,
		argList = _.map(slot0:RandomShips(slot3[3] or {}, slot4), function (slot0)
			return slot0.id
		end),
		callback = slot2
	})
end

slot0.RequestData = function(slot0, slot1)
	if not getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST) or slot2:isEnd() then
		slot1()

		return
	end

	seriesAsync({
		function (slot0)
			uv0(uv1, uv2, slot0)
		end,
		function (slot0)
			uv0(uv1, uv2, slot0)
		end
	}, slot1)
end

slot0.SetData = function(slot0, slot1)
	assert(isa(slot1, FeastDorm))

	slot0.data = slot1

	slot0:AddRefreshTimer()
end

slot0.UpdateData = function(slot0, slot1)
	assert(isa(slot1, FeastDorm))

	slot0.data = slot1
end

slot0.GetConsumeList = function(slot0)
	slot5 = pg.activity_partyinvitation_template[(getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST):getConfig("config_data")[3] or {})[1]]

	return slot5.invitationID[2], slot5.giftID[2]
end

slot3 = function(slot0)
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(_.filter(pg.ship_data_group.all, function (slot0)
		return pg.ship_data_group[slot0].handbook_type ~= 1
	end)) do
		if slot0[pg.ship_data_group[slot8].group_type] then
			table.insert(slot2, slot10)
		else
			table.insert(slot2, ShipGroup.New({
				id = slot9.group_type
			}))
		end
	end

	return slot2, slot3
end

slot4 = function(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8, slot9 in pairs(slot0) do
		if not table.contains(slot1, slot9.id) then
			table.insert(slot4, slot9)
		end
	end

	slot5 = {}
	slot6 = {}
	slot7 = {}

	for slot11, slot12 in ipairs(slot4) do
		for slot17, slot18 in ipairs(ShipGroup.getSkinList(slot12.id)) do
			table.insert(ShipSkin.GetShopTypeIdBySkinId(slot18.id, slot7) == 7 and slot5 or slot6, slot12)
		end
	end

	shuffle(slot5)
	shuffle(slot6)

	for slot11, slot12 in ipairs(slot5) do
		if table.getCount(slot2) == slot3 then
			break
		end

		slot2[slot12.id] = slot12
	end

	for slot11, slot12 in ipairs(slot6) do
		if table.getCount(slot2) == slot3 then
			break
		end

		slot2[slot12.id] = slot12
	end
end

slot0.RandomShips = function(slot0, slot1, slot2)
	slot3 = pg.activity_partyinvitation_template or {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot4, slot3[slot9].groupid)
	end

	for slot9, slot10 in pairs(slot0:getRawData():GetFeastShipList()) do
		if not table.contains(slot4, slot9) then
			table.insert(slot4, slot9)
		end
	end

	slot7, slot8 = uv0(getProxy(CollectionProxy):RawgetGroups())
	slot9 = {}

	uv1(slot7, slot4, slot9, slot2)

	slot14 = slot2

	uv1(slot8, slot4, slot9, slot14)

	slot10 = {}

	for slot14, slot15 in pairs(slot9) do
		table.insert(slot10, slot15)
	end

	return slot10
end

slot0.AddRefreshTimer = function(slot0)
	slot0:RemoveRefreshTimer()

	slot0.timer = Timer.New(function ()
		uv0:RemoveRefreshTimer()

		if getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST) and not slot0:isEnd() then
			uv1(uv0, slot0, function ()
			end)
		end
	end, GetZeroTime() - pg.TimeMgr.GetInstance():GetServerTime() + 1, 1)

	slot0.timer:Start()
end

slot0.RemoveRefreshTimer = function(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

slot0.remove = function(slot0)
	slot0:RemoveRefreshTimer()
end

slot0.GetBuffList = function(slot0)
	if not getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_PT_ACT) or slot1:isEnd() then
		return {}
	end

	return slot1:GetBuffList()
end

slot0.GetTaskList = function(slot0)
	slot1 = getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_TASK_ACT)

	assert(slot1)

	slot2 = {}
	slot3 = getProxy(TaskProxy)
	slot7 = "config_data"

	for slot7, slot8 in ipairs(slot1:getConfig(slot7)) do
		if slot3:getTaskById(slot8) or slot3:getFinishTaskById(slot8) then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

slot0.GetPtActData = function(slot0)
	slot1 = getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_PT_ACT)

	assert(slot1)

	return ActivityPtData.New(slot1)
end

slot0.GetSubmittedTaskStories = function(slot0)
	if not getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST) or slot1:isEnd() then
		return {}
	end

	slot2 = slot1:getConfig("config_client")
	slot4 = {}

	for slot8, slot9 in ipairs({
		slot2[8],
		slot2[9]
	}) do
		slot10 = slot9[1]

		if not pg.NewStoryMgr.GetInstance():IsPlayed(slot9[2]) then
			slot4[slot10] = slot11
		end
	end

	return slot4
end

slot0.ShouldTipPt = function(slot0)
	if slot0:GetPtActData():AnyAwardCanGet() then
		return true
	end

	return false
end

slot0.ShouldTipFeastTask = function(slot0)
	slot1 = getProxy(TaskProxy)

	for slot6, slot7 in ipairs(slot0:GetTaskList()) do
		if slot1:getTaskById(slot7) and slot8:isFinish() and not slot8:isReceive() then
			return true
		end
	end

	return false
end

slot0.ShouldTipTask = function(slot0)
	if slot0:ShouldTipPt() then
		return true
	end

	if slot0:ShouldTipFeastTask() then
		return true
	end

	return false
end

slot0.ShouldTipInvitation = function(slot0)
	slot1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)
	slot2, slot3 = slot0:GetConsumeList()
	slot4 = slot1:getVitemNumber(slot2)
	slot5 = slot1:getVitemNumber(slot3)

	for slot10, slot11 in ipairs(slot0.data:GetInvitedFeastShipList()) do
		if not slot11:GotGift() and slot5 > 0 or not slot11:GotTicket() and slot4 > 0 then
			return true
		end
	end

	return false
end

slot0.ShouldTip = function(slot0)
	if not slot0.data then
		return false
	end

	if not getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_TASK_ACT) or slot1:isEnd() then
		return false
	end

	if not getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_PT_ACT) or slot2:isEnd() then
		return false
	end

	if not getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG) or slot3:isEnd() then
		return false
	end

	if slot0.data == nil then
		return false
	end

	for slot8, slot9 in pairs(slot0.data:GetFeastShipList()) do
		if slot9:HasBubble() then
			return true
		end
	end

	if slot0:ShouldTipTask() then
		return true
	end

	if slot0:ShouldTipInvitation() then
		return true
	end

	return false
end

slot0.HandleTaskStories = function(slot0, slot1, slot2)
	if not slot0:GetSubmittedTaskStories() or table.getCount(slot3) == 0 then
		if slot2 then
			slot2()
		end

		return
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if slot3[slot9] ~= nil then
			table.insert(slot4, slot3[slot9])
		end
	end

	if #slot4 > 0 then
		if slot2 then
			pg.NewStoryMgr.GetInstance():SeriesPlay(slot4, slot2)
		else
			pg.NewStoryMgr.GetInstance():SeriesPlay(slot4)
		end
	end
end

return slot0
