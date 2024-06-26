ys = ys or {}
slot0 = ys
slot0.Battle.BattleLabelWave = class("BattleLabelWave", slot0.Battle.BattleWaveInfo)
slot0.Battle.BattleLabelWave.__name = "BattleLabelWave"
slot1 = slot0.Battle.BattleLabelWave

slot1.Ctor = function(slot0)
	uv0.super.Ctor(slot0)
end

slot1.SetWaveData = function(slot0, slot1)
	uv0.super.SetWaveData(slot0, slot1)

	slot0._labelData = {
		op = slot0._param.op,
		key = slot0._param.key,
		x = slot0._param.x,
		y = slot0._param.y,
		dialogue = slot0._param.dialogue,
		duration = slot0._param.duration
	}
end

slot1.DoWave = function(slot0)
	uv0.super.DoWave(slot0)
	uv1.Battle.BattleState.GetInstance():GetProxyByName(uv1.Battle.BattleDataProxy.__name):DispatchCustomWarning(slot0._labelData)
	slot0:doPass()
end
