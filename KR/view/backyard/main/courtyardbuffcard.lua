slot0 = class("CourtYardBuffCard")

slot0.Ctor = function(slot0, slot1)
	slot0._go = slot1
	slot0._tf = slot1.transform
	slot0.timeTxt = slot0._tf:Find("Text"):GetComponent(typeof(Text))
	slot0.icon = slot0._tf:GetComponent(typeof(Image))
end

slot0.Flush = function(slot0, slot1)
	slot0.buff = slot1
	slot0.icon.sprite = LoadSprite(slot1:getConfig("icon") .. "_backyard") or LoadSprite(slot1:getConfig("icon"))

	slot0:RemoveTimer()

	slot0.using = true

	if slot1:isActivate() then
		slot0:StartTimer(slot1)
	end
end

slot0.StartTimer = function(slot0, slot1)
	setActive(slot0._tf, true)

	slot0.timer = Timer.New(function ()
		if uv0:getLeftTime() > 0 then
			slot1 = pg.TimeMgr.GetInstance():DescCDTime(slot0)
			uv1.timeTxt.text = slot0 <= 600 and setColorStr(slot1, COLOR_RED) or setColorStr(slot1, "#FFFFFFFF")
		else
			uv1:RemoveTimer()
		end
	end, 1, -1)

	slot0.timer:Start()
	slot0.timer.func()
end

slot0.RemoveTimer = function(slot0)
	slot0.using = false

	setActive(slot0._tf, false)

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

slot0.IsUsing = function(slot0)
	return slot0.using
end

slot0.Dispose = function(slot0)
	slot0:RemoveTimer()
end

return slot0
