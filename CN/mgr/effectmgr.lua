pg = pg or {}
slot1 = singletonClass("EffectMgr")
pg.EffectMgr = slot1

slot1.Ctor = function(slot0)
	slot1 = ys.Battle.BattleResourceManager.GetInstance()
	slot0.effectCbMap = setmetatable({}, {
		__mode = "k"
	})

	slot0.commonEffectEvent = function(slot0)
		if uv0.effectCbMap[slot0] == nil then
			uv1:DestroyOb(slot0)

			return
		end

		if slot1[2] ~= nil then
			slot2(slot0)
		end

		uv0.effectCbMap[slot0] = nil

		if slot1[1] then
			uv1:DestroyOb(slot0)
		else
			slot0:SetActive(false)
		end
	end
end

slot1.ClearBattleEffectMap = function(slot0)
	slot0.effectCbMap = setmetatable({}, {
		__mode = "k"
	})
end

slot1.CommonEffectEvent = function(slot0, slot1)
	LuaHelper.SetParticleEndEvent(slot1, slot0.commonEffectEvent)
end

slot1.PlayBattleEffect = function(slot0, slot1, slot2, slot3, slot4, slot5)
	slot1.transform.localPosition = slot2

	slot1:SetActive(true)

	if slot5 then
		LuaHelper.SetParticleSpeed(slot1, 1 / Time.timeScale)
	end

	slot0.effectCbMap[slot1] = {
		slot3,
		slot4
	}
end

slot1.BattleUIEffect = function(slot0, slot1, slot2)
	assert(string.sub(slot1, -2, -1) == "UI", "UI效果不是以UI结尾，请检查")
	LoadAndInstantiateAsync("UI", slot1, function (slot0)
		slot1 = ys.Battle.BattleState.GetInstance()

		if slot1:GetState() ~= slot1.BATTLE_STATE_FIGHT then
			Destroy(slot0)

			return
		end

		LuaHelper.SetGOParentGO(slot0, uv0.UIMgr.GetInstance().UIMain, false)
		SetActive(slot0, true)
		uv1(slot0)
	end)
end

slot1.EndEffect = function(slot0, slot1)
	if slot0._effectMap[slot1] ~= nil then
		slot2:GetComponent(typeof(ParticleSystem)):Stop()
	end
end
