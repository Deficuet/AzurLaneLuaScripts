slot0 = class("BattleGateCooperate")
ys.Battle.BattleGateCooperate = slot0
slot0.__name = "BattleGateCooperate"

slot0.Entrance = function(slot0, slot1)
	if BeginStageCommand.DockOverload() then
		return
	end

	slot2 = slot0.actId
	slot3 = getProxy(PlayerProxy)
	slot4 = getProxy(BayProxy)
	slot5 = getProxy(FleetProxy)
	slot7 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS].oil_cost > 0
	slot8 = {}
	slot9 = 0
	slot10 = 0
	slot11 = 0
	slot12 = 0

	for slot17, slot18 in ipairs(slot5:getActivityFleets()[slot2][Fleet.REGULAR_FLEET_ID].ships) do
		slot8[#slot8 + 1] = slot18
	end

	slot10 = slot13:getStartCost().oil
	slot12 = slot13:GetCostSum().oil
	slot16 = slot4:getSortShipsByFleet(slot13)
	slot17 = slot3:getData()

	if slot7 and slot17.oil < slot12 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

		return
	end

	slot20 = ys.Battle.BattleDataFunction.GetDungeonTmpDataByID(pg.expedition_data_template[slot0.stageId].dungeon_id).fleet_prefab

	slot1.ShipVertify()

	slot21 = nil

	if chapter:getPlayType() == ChapterConst.TypeExtra then
		slot21 = true
	end

	BeginStageCommand.SendRequest(SYSTEM_HP_SHARE_ACT_BOSS, slot8, {
		slot18
	}, function (slot0)
		if uv0 then
			uv1:consume({
				gold = 0,
				oil = uv2
			})
		end

		if uv3.enter_energy_cost > 0 and not uv4 then
			slot1 = pg.gameset.battle_consume_energy.key_value

			for slot5, slot6 in ipairs(uv5) do
				slot6:cosumeEnergy(slot1)
				uv6:updateShip(slot6)
			end
		end

		uv7:updatePlayer(uv1)
		uv11:sendNotification(GAME.BEGIN_STAGE_DONE, {
			mainFleetId = Fleet.REGULAR_FLEET_ID,
			prefabFleet = uv8,
			stageId = uv9,
			actId = uv10,
			system = SYSTEM_HP_SHARE_ACT_BOSS,
			token = slot0.key
		})
	end, function (slot0)
		uv0:RequestFailStandardProcess(slot0)
	end)
end

slot0.Exit = function(slot0, slot1)
	if client.CheaterVertify() then
		return
	end

	slot2 = pg.battle_cost_template[SYSTEM_HP_SHARE_ACT_BOSS]
	slot4 = getProxy(ChapterProxy)
	slot5 = ys.Battle.BattleConst.BattleScore.S
	slot6 = 0
	slot7 = 0
	slot8 = nil
	slot11 = getProxy(FleetProxy):getActivityFleets()[slot0.actId][slot0.mainFleetId]
	slot8 = bayProxy:getSortShipsByFleet(slot11)
	slot7 = slot11:getEndCost().oil

	if slot0.statistics.submarineAid then
		if slot3:getActivityFleets()[slot0.actId][Fleet.SUBMARINE_FLEET_ID] then
			for slot20, slot21 in ipairs(bayProxy:getSortShipsByFleet(slot15)) do
				if slot0.statistics[slot21.id] then
					table.insert(slot8, slot21)

					slot7 = slot7 + slot21:getEndBattleExpend()
				end
			end
		else
			originalPrint("finish stage error: can not find submarine fleet.")
		end
	end

	slot13 = client.GeneralPackage(slot0, slot8)
	slot14 = {}

	for slot18, slot19 in ipairs(slot0.statistics._enemyInfoList) do
		table.insert(slot14, {
			enemy_id = slot19.id,
			damage_taken = slot19.damage,
			total_hp = slot19.totalHp
		})
	end

	slot13.enemy_info = slot14
	slot16 = client

	slot16:SendRequest(slot13, function (slot0)
		client.addShipsExp(slot0.ship_exp_list, uv0.statistics)

		uv0.statistics.mvpShipID = slot0.mvp
		slot1, slot2 = client:GeneralLoot(slot0)

		uv2.GeneralPlayerCosume(SYSTEM_HP_SHARE_ACT_BOSS, ys.Battle.BattleConst.BattleScore.C < uv1, uv3, slot0.player_exp)
		client:sendNotification(GAME.FINISH_STAGE_DONE, {
			system = SYSTEM_HP_SHARE_ACT_BOSS,
			statistics = uv0.statistics,
			score = uv1,
			drops = slot1,
			commanderExps = {},
			result = slot0.result,
			extraDrops = slot2
		})
	end)
end

return slot0
