slot0 = class("ReturnerAwardWindow", import(".PtAwardWindow"))

slot1 = function(slot0, slot1, slot2, slot3)
	slot0.UIlist:make(function (slot0, slot1, slot2)
		if slot0 == UIItemList.EventUpdate then
			slot3 = uv0[slot1 + 1]
			slot4 = uv1[slot1 + 1]
			uv2.resTitle = string.gsub(uv2.resTitle, "：", "")

			setText(slot2:Find("title/Text"), "PHASE " .. slot1 + 1)
			setText(slot2:Find("target/Text"), slot4)
			setText(slot2:Find("target/title"), uv2.resTitle)
			updateDrop(slot2:Find("award"), {
				type = slot3[1],
				id = slot3[2],
				count = slot3[3]
			}, {
				hideName = true
			})
			onButton(uv2.binder, slot2:Find("award"), function ()
				uv0.binder:emit(BaseUI.ON_DROP, uv1)
			end, SFX_PANEL)
			setActive(slot2:Find("award/mask"), table.contains(uv3, slot4))

			if slot2:Find("target/icon") and uv2.resIcon and uv2.resIcon ~= "" then
				setActive(slot2:Find("target/icon"), true)
				LoadImageSpriteAsync(uv2.resIcon, slot2:Find("target/icon"), false)
			else
				setActive(slot2:Find("target/icon"), false)
			end
		end
	end)
	slot0.UIlist:align(#slot1)
end

slot0.Show = function(slot0, slot1)
	slot7 = Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = slot1.resId
	}):getName()
	slot0.cntTitle = i18n("pt_total_count", slot7)
	slot0.resTitle = i18n("pt_count", slot7)
	slot0.cntTitle = string.gsub(slot0.cntTitle, "：", "")

	slot0:updateResIcon(slot1.resId, slot1.resIcon, slot1.type)
	uv0(slot0, slot1.dropList, slot1.targets, slot1.fetchList)

	slot0.totalTxt.text = slot1.count
	slot0.totalTitleTxt.text = slot0.cntTitle

	setActive(slot0._tf, true)
end

return slot0
