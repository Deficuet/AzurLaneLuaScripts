slot0 = class("AddFoodCommand", pm.SimpleCommand)

slot0.execute = function(slot0, slot1)
	slot2 = slot1:getBody()
	slot7 = getProxy(DormProxy):getData()

	if slot7:getConfig("capacity") + slot7.dorm_food_max < slot7.food + Item.getConfigData(slot2.id).usage_arg[1] * slot2.count then
		slot7.food = slot8
	else
		slot7.food = slot7.food + slot5.usage_arg[1] * slot4
	end

	if slot7.next_timestamp == 0 then
		slot7:restNextTime()
	end

	slot6:updateDrom(slot7, BackYardConst.DORM_UPDATE_TYPE_USEFOOD)
	slot0:sendNotification(GAME.ADD_FOOD_DONE, {
		id = slot3
	})
end

return slot0
