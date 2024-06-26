slot0 = class("QuotaShop", import(".BaseShop"))

slot0.Ctor = function(slot0)
	slot0.type = ShopArgs.ShopQuota
	slot0.goods = {}

	for slot5, slot6 in ipairs(pg.quota_shop_template[1].shop_goods) do
		slot0.goods[slot6] = Goods.Create({
			shop_id = slot6,
			buy_count = slot0:getOwnedGoodCount(slot6)
		}, Goods.TYPE_QUOTA)
	end
end

slot0.getOwnedGoodCount = function(slot0, slot1)
	slot2 = pg.activity_shop_template[slot1]

	assert(slot2, "config is missing in activity_shop_template, id: " .. slot1)

	return Drop.New({
		id = slot2.commodity_id,
		type = slot2.commodity_type,
		count = slot2.num
	}):getOwnedCount()
end

slot0.IsSameKind = function(slot0, slot1)
	return isa(slot1, QuotaShop)
end

slot0.GetCommodityById = function(slot0, slot1)
	return slot0:getGoodsById(slot1)
end

slot0.GetCommodities = function(slot0)
	return slot0:getSortGoods()
end

slot0.getSortGoods = function(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.goods) do
		table.insert(slot1, slot6)
	end

	table.sort(slot1, CompareFuncs({
		function (slot0)
			return slot0:canPurchase() and 0 or 1
		end,
		function (slot0)
			return slot0:getConfig("order")
		end,
		function (slot0)
			return slot0.id
		end
	}))

	return slot1
end

slot0.getGoodsCfg = function(slot0, slot1)
	return pg.activity_shop_template[slot1]
end

slot0.getGoodsById = function(slot0, slot1)
	assert(slot0.goods[slot1], "goods should exist")

	return slot0.goods[slot1]
end

slot0.getLimitGoodCount = function(slot0, slot1)
	if type(pg.activity_shop_template[slot1].limit_args) == "table" then
		for slot6, slot7 in ipairs(slot2) do
			if slot7[1] == "quota" then
				return slot7[2]
			end
		end
	end

	assert(false, "good not limit_args 'quota' with good id: " .. slot1)
end

return slot0
