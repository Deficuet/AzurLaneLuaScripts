slot0 = class("NewCommanderScene", import("..base.BaseUI"))

slot0.getUIName = function(slot0)
	return "GetCommanderUI"
end

slot0.init = function(slot0)
	slot0.bgTF = slot0:findTF("main/bg")
	slot0.clickTF = slot0:findTF("click")
	slot0.paintTF = slot0:findTF("main/paint")
	slot0.paintTFCG = slot0.paintTF:GetComponent(typeof(CanvasGroup))
	slot0.infoTF = slot0:findTF("main/info")
	slot0.leftPanel = slot0:findTF("left_panel")
	slot0.lockBtn = slot0:findTF("left_panel/btns/lock")
	slot0.unlockBtn = slot0:findTF("left_panel/btns/unlock")
	slot0.shareBtn = slot0:findTF("left_panel/btns/share")
	slot0.nameTF = slot0:findTF("content/name/value", slot0.infoTF):GetComponent(typeof(Text))
	slot0.nationTF = slot0:findTF("content/nation/value", slot0.infoTF):GetComponent(typeof(Text))
	slot0.rarityTF = slot0:findTF("content/rarity/value", slot0.infoTF):GetComponent(typeof(Image))
	slot0.skillTF = slot0:findTF("content/skill/value", slot0.infoTF):GetComponent(typeof(Text))
	slot0.abilitysTF = slot0:findTF("content/abilitys/attrs", slot0.infoTF)
	slot0.talentsTF = slot0:findTF("content/talents", slot0.infoTF)
	slot0.talentsList = UIItemList.New(slot0.talentsTF, slot0.talentsTF:Find("talent"))
	slot0.dateTF = slot0:findTF("content/copyright/Text", slot0.infoTF)
	slot0.treePanel = CommanderTreePage.New(slot0._tf, slot0.event)
	slot0.msgbox = CommanderMsgBoxPage.New(slot0._tf, slot0.event)
	slot0.antor = slot0._tf:GetComponent(typeof(Animator))
	slot0.skipBtn = slot0._tf:Find("skip")
	slot0.getEffect = slot0:findTF("main/effect")
	slot0.skipAnim = true

	if pg.NewGuideMgr.GetInstance():IsBusy() then
		slot0.skipAnim = false
	end

	pg.UIMgr.GetInstance():BlurPanel(slot0._tf, false, {
		weight = LayerWeightConst.SECOND_LAYER + 1
	})
	setText(slot0:findTF("main/info/content/abilitys/attrs/command/name/Text"), i18n("commander_command_ability"))
	setText(slot0:findTF("main/info/content/abilitys/attrs/tactic/name/Text"), i18n("commander_tactical_ability"))
	setText(slot0:findTF("main/info/content/abilitys/attrs/support/name/Text"), i18n("commander_logistics_ability"))
	setText(slot0:findTF("main/info/content/copyright/title"), i18n("commander_get_commander_coptyright"))
end

slot0.openTreePanel = function(slot0, slot1)
	slot2 = function()
		uv0.treePanel:ActionInvoke("Show", uv1, LayerWeightConst.SECOND_LAYER + 2)
	end

	if slot0.treePanel:GetLoaded() then
		slot2()
	else
		slot0.treePanel:Load()
		slot0.treePanel:CallbackInvoke(slot2)
	end
end

slot0.closeTreePanel = function(slot0)
	slot0.treePanel:ActionInvoke("closeTreePanel")
end

slot0.onUIAnimEnd = function(slot0, slot1)
	slot2 = slot0.antor

	slot2:SetBool("play", true)

	slot0.isAnim = true

	setActive(slot0.clickTF, slot0.skipAnim)

	slot2 = slot0._tf
	slot2 = slot2:GetComponent(typeof(DftAniEvent))

	slot2:SetTriggerEvent(function (slot0)
		if uv0.contextData.commander:isSSR() then
			uv0:playerEffect()
		end

		uv1:SetTriggerEvent(nil)
	end)
	slot2:SetEndEvent(function ()
		uv0.isAnim = false

		setActive(uv0.clickTF, true)
		uv1:SetEndEvent(nil)
		uv2()
	end)
end

slot0.playerEffect = function(slot0)
	slot1 = PoolMgr.GetInstance()

	slot1:GetUI("AL_zhihuimiao_zhipian", true, function (slot0)
		uv0.effect = slot0

		SetParent(slot0, uv0._tf)
		setActive(slot0, true)
	end)
end

slot0.openMsgBox = function(slot0, slot1)
	slot0.isShowMsgBox = true

	slot2 = function()
		uv0.msgbox:ActionInvoke("Show", uv1)
	end

	if slot0.msgbox:GetLoaded() then
		slot2()
	else
		slot0.msgbox:Load()
		slot0.msgbox:CallbackInvoke(slot2)
	end
end

slot0.closeMsgBox = function(slot0)
	slot0.isShowMsgBox = nil

	slot0.msgbox:ActionInvoke("Hide")
end

slot0.didEnter = function(slot0)
	slot0:updateInfo()
	onButton(slot0, slot0.shareBtn, function ()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeCommander, pg.ShareMgr.PANEL_TYPE_PINK, {
			weight = LayerWeightConst.TOP_LAYER
		})
	end, SFX_PANEL)
	onButton(slot0, slot0.skipBtn, function (slot0)
		if uv0.isAnim then
			return
		end

		getProxy(CommanderProxy).hasSkipFlag = true

		uv0:DoExit()
	end, SFX_CANCEL)
	onButton(slot0, slot0.lockBtn, function ()
		uv0:emit(NewCommanderMediator.ON_LOCK, uv0.contextData.commander.id, 1 - getProxy(CommanderProxy):getCommanderById(uv0.contextData.commander.id):getLock())
	end, SFX_PANEL)
	onButton(slot0, slot0.unlockBtn, function ()
		uv0:emit(NewCommanderMediator.ON_LOCK, uv0.contextData.commander.id, 1 - getProxy(CommanderProxy):getCommanderById(uv0.contextData.commander.id):getLock())
	end, SFX_PANEL)
	onButton(slot0, slot0.clickTF, function ()
		if uv0.isAnim then
			uv0.antor:SetBool("play", false)

			if uv0.contextData.commander:isSSR() and not uv0.effect then
				uv0:playerEffect()
			end

			uv0.isAnim = nil
		else
			uv0:DoExit()
		end
	end, SFX_CANCEL)
end

slot0.DoExit = function(slot0)
	if slot0.contextData.commander:ShouldTipLock() then
		slot0:openMsgBox({
			content = i18n("commander_lock_tip"),
			onYes = function ()
				uv0:emit(NewCommanderMediator.ON_LOCK, uv0.contextData.commander.id, 1)
				uv0:emit(uv1.ON_CLOSE)
			end,
			layer = LayerWeightConst.SECOND_LAYER + 2,
			onNo = function ()
				uv0:emit(uv1.ON_CLOSE)
			end
		})
	else
		slot0:emit(uv0.ON_CLOSE)
	end
end

slot0.updateLockState = function(slot0)
	setActive(slot0.lockBtn, getProxy(CommanderProxy):getCommanderById(slot0.contextData.commander.id):getLock() ~= 0)
	setActive(slot0.unlockBtn, slot2 == 0)
end

slot0.updateInfo = function(slot0, slot1)
	slot2 = slot0.contextData.commander

	slot0:updateLockState(slot2:getLock())

	slot0.nameTF.text = slot2:getName()
	slot0.nationTF.text = Nation.Nation2Name(slot2:getConfig("nationality"))
	slot0.skillTF.text = slot2:getSkills()[1]:getConfig("name")

	LoadImageSpriteAsync("CommanderRarity/" .. Commander.rarity2Print(slot2:getRarity()), slot0.rarityTF, true)
	setCommanderPaintingPrefab(slot0.paintTF, slot2:getPainting(), "get")

	slot0.painting = slot2

	slot0:updateAbilitys()
	slot0:updateTalents()
	setText(slot0.dateTF, pg.TimeMgr.GetInstance():CurrentSTimeDesc("%y%m%d"))

	if slot1 then
		slot1()
	end
end

slot0.updateAbilitys = function(slot0)
	slot1 = slot0.contextData.commander
	slot2 = slot1:getAbilitys()

	eachChild(slot0.abilitysTF, function (slot0)
		slot2 = uv0[go(slot0).name]

		setText(slot0:Find("slider/point"), slot2.value)

		slot0:Find("slider"):GetComponent(typeof(Slider)).value = slot2.value / CommanderConst.MAX_ABILITY
	end)
end

slot0.updateTalents = function(slot0)
	slot2 = slot0.contextData.commander:getTalents()

	slot0.talentsList:make(function (slot0, slot1, slot2)
		if slot0 == UIItemList.EventUpdate then
			slot3 = uv0[slot1 + 1]

			setActive(slot2:Find("empty"), not slot3)
			setActive(slot2:Find("icon"), slot3)

			if slot3 then
				GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. slot3:getConfig("icon"), "", slot2:Find("icon"))
			end

			onButton(uv1, slot2, function ()
				uv0:openTreePanel(uv1)
			end, SFX_PANEL)
		end
	end)
	slot0.talentsList:align(3)
end

slot0.onBackPressed = function(slot0)
	if slot0.isShowMsgBox then
		slot0:closeMsgBox()

		return
	end
end

slot0.willExit = function(slot0)
	pg.UIMgr.GetInstance():UnblurPanel(slot0._tf, pg.UIMgr.GetInstance().UIMain)
	slot0.treePanel:Destroy()
	slot0.msgbox:Destroy()
	retCommanderPaintingPrefab(slot0.paintTF, slot0.painting:getPainting())

	if slot0.effect then
		PoolMgr.GetInstance():ReturnUI("AL_zhihuimiao_zhipian", slot0.effect)
	end

	if slot0.contextData.onExit then
		slot0.contextData.onExit()
	end
end

return slot0
