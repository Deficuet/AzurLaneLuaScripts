slot0 = class("SnapshotSceneMediator", import("..base.ContextMediator"))

slot0.register = function(slot0)
	slot0:bind(SnapshotScene.SELECT_CHAR_PANEL, function (slot0)
		uv0:addSubLayers(Context.New({
			mediator = SnapshotSelectCharMediator,
			viewComponent = SnapshotSelectCharLayer
		}))
	end)
	slot0:bind(SnapshotScene.SHARE_PANEL, function (slot0, slot1, slot2)
		uv0:addSubLayers(Context.New({
			mediator = SnapshotShareMediator,
			viewComponent = SnapshotShareLayer,
			data = {
				photoTex = slot1,
				photoData = slot2
			}
		}))
	end)
end

slot0.listNotificationInterests = function(slot0)
	return {
		SnapshotSelectCharMediator.SELECT_CHAR,
		PERMISSION_GRANTED,
		PERMISSION_REJECT,
		PERMISSION_NEVER_REMIND
	}
end

slot0.handleNotification = function(slot0, slot1)
	slot3 = slot1:getBody()

	if slot1:getName() == SnapshotSelectCharMediator.SELECT_CHAR then
		if pg.ship_skin_template[slot3] then
			slot0.viewComponent.contextData.propose = getProxy(BayProxy):getGroupPropose(pg.ship_skin_template[slot3].ship_group)
		end

		slot0.viewComponent:setSkin(slot3)
	elseif PERMISSION_GRANTED == slot2 then
		if slot3 == ANDROID_RECORD_AUDIO_PERMISSION then
			slot0.viewComponent:changeToTakeVideo()
		end
	elseif PERMISSION_REJECT == slot2 then
		if slot3 == ANDROID_RECORD_AUDIO_PERMISSION then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("apply_permission_record_audio_tip3"),
				onYes = function ()
					ApplyPermission({
						ANDROID_RECORD_AUDIO_PERMISSION
					})
				end
			})
		end
	elseif PERMISSION_NEVER_REMIND and slot3 == ANDROID_RECORD_AUDIO_PERMISSION then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("apply_permission_record_audio_tip2"),
			onYes = function ()
				OpenDetailSetting()
			end
		})
	end
end

return slot0
