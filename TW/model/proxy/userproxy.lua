slot0 = class("UserProxy", import(".NetProxy"))

slot0.register = function(slot0)
	slot0.userIsLogined = false
	slot0.gateways = {}
	slot0.canSwitchGateway = false
end

slot0.setLastLogin = function(slot0, slot1)
	assert(isa(slot1, User), "should be an instance of User")

	if slot1.type == 1 then
		PlayerPrefs.SetString("user.type", "1")
		PlayerPrefs.SetString("user.arg1", slot1.arg1)
		PlayerPrefs.SetString("user.arg2", slot1.arg2)
		PlayerPrefs.SetString("user.arg3", slot1.arg3)
	elseif slot1.type == 2 then
		PlayerPrefs.SetString("user.type", "1")
		PlayerPrefs.SetString("user.arg1", "yongshi")
		PlayerPrefs.SetString("user.arg2", slot1.arg1)
		PlayerPrefs.SetString("user.arg3", slot1.token)
	elseif slot1.type == 3 then
		PlayerPrefs.SetString("user.type", "3")
		PlayerPrefs.SetString("user.arg1", slot1.arg1)
		PlayerPrefs.SetString("user.arg2", "")
		PlayerPrefs.SetString("user.arg3", "")
		PlayerPrefs.SetString("guest_uuid", slot1.arg1)
	end

	PlayerPrefs.Save()

	slot0.data = slot1:clone()

	slot0.data:display("logged in")

	if PLATFORM_CODE == PLATFORM_JP then
		slot0:clearTranscode()
	end
end

slot0.getLastLoginUser = function()
	slot0 = tonumber(PlayerPrefs.GetString("user.type"))
	slot2 = PlayerPrefs.GetString("user.arg2")
	slot3 = PlayerPrefs.GetString("user.arg3")

	print("last login:", slot0, " arg1:", PlayerPrefs.GetString("user.arg1"))

	if slot0 ~= "" and slot1 ~= "" and slot2 ~= "" then
		return User.New({
			type = slot0,
			arg1 = slot1,
			arg2 = slot2,
			arg3 = slot3
		})
	end

	return nil
end

slot0.saveTranscode = function(slot0, slot1)
	PlayerPrefs.SetString("transcode", slot1)
	PlayerPrefs.Save()
end

slot0.getTranscode = function(slot0)
	if PlayerPrefs.GetString("transcode") then
		return slot1
	end

	return ""
end

slot0.clearTranscode = function(slot0)
	PlayerPrefs.DeleteKey("transcode")
end

slot0.SetLoginedFlag = function(slot0, slot1)
	slot0.userIsLogined = slot1
end

slot0.GetLoginedFlag = function(slot0)
	return slot0.userIsLogined
end

slot1 = "#cacheGatewayFlag#"

slot0.SetDefaultGateway = function(slot0)
	if not slot0.gateways[PLATFORM] then
		slot0.gateways[PLATFORM] = GatewayInfo.New(NetConst.GATEWAY_HOST, NetConst.GATEWAY_PORT, NetConst.PROXY_GATEWAY_HOST, NetConst.PROXY_GATEWAY_PORT)
	end
end

slot0.ShouldSwitchGateway = function(slot0, slot1, slot2)
	return slot0:GetCacheGatewayFlag(slot2) ~= slot1
end

slot0.GetGateWayByPlatform = function(slot0, slot1)
	return slot0.gateways[slot1]
end

slot0.SetGatewayForPlatform = function(slot0, slot1, slot2)
	slot0.gateways[slot1] = slot2
end

slot0.GetCacheGatewayFlag = function(slot0, slot1)
	if not slot0.cachePlatform then
		slot0.cachePlatform = PlayerPrefs.GetInt(uv0 .. slot1, PLATFORM)
	end

	return slot0.cachePlatform
end

slot0.GetCacheGatewayInServerLogined = function(slot0)
	return slot0.cachePlatform or PLATFORM
end

slot0.SetCacheGatewayFlag = function(slot0, slot1)
	if slot0.cachePlatform ~= slot1 then
		slot0.cachePlatform = slot1
	end
end

slot0.SaveCacheGatewayFlag = function(slot0, slot1)
	if not slot0.canSwitchGateway then
		return
	end

	if PlayerPrefs.GetInt(uv0 .. slot1, PLATFORM) ~= slot0.cachePlatform then
		PlayerPrefs.SetInt(uv0 .. slot1, slot0.cachePlatform)
		PlayerPrefs.Save()
	end
end

slot0.GetReversePlatform = function(slot0)
	return slot0.cachePlatform == PLATFORM_IPHONEPLAYER and PLATFORM_ANDROID or PLATFORM_IPHONEPLAYER
end

slot0.ActiveGatewaySwitcher = function(slot0)
	slot0.canSwitchGateway = true
end

slot0.ShowGatewaySwitcher = function(slot0)
	return slot0.canSwitchGateway
end

return slot0
