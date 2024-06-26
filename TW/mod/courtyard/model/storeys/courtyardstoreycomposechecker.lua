slot0 = class("CourtYardStoreyComposeChecker")

slot0.Ctor = function(slot0, slot1)
	slot0.storey = slot1
	slot0.config = pg.furniture_compose_template
	slot0.list = {}
end

slot0.Check = function(slot0)
	for slot4, slot5 in ipairs(slot0.config.all) do
		if slot0:IsMatch(slot0.config[slot5].furniture_ids) then
			slot0:Add(slot5)
		else
			slot0:Remove(slot5)
		end
	end
end

slot0.Add = function(slot0, slot1)
	if not table.contains(slot0.list, slot1) then
		table.insert(slot0.list, slot1)
		slot0.storey:DispatchEvent(CourtYardEvent.ON_ADD_EFFECT, slot0.config[slot1].effect_name)
	end
end

slot0.Remove = function(slot0, slot1)
	if table.contains(slot0.list, slot1) then
		table.removebyvalue(slot0.list, slot1)
		slot0.storey:DispatchEvent(CourtYardEvent.ON_REMOVE_EFFECT, slot0.config[slot1].effect_name)
	end
end

slot0.IsMatch = function(slot0, slot1)
	return _.all(slot1, function (slot0)
		return uv0.storey.furnitures[slot0] ~= nil or uv0.storey.wallPaper and uv0.storey.wallPaper.configId == slot0 or uv0.storey.floorPaper and uv0.storey.floorPaper.configId == slot0
	end)
end

slot0.Dispose = function(slot0)
	slot0.config = nil
	slot0.list = nil
	slot0.storey = nil
end

return slot0
