PERMISSION_GRANTED = "permission_granted"
PERMISSION_NEVER_REMIND = "permission_never_remind"
PERMISSION_REJECT = "permission_reject"
ANDROID_CAMERA_PERMISSION = "android.permission.CAMERA"
ANDROID_RECORD_AUDIO_PERMISSION = "android.permission.RECORD_AUDIO"
ANDROID_WRITE_EXTERNAL_PERMISSION = "android.permission.WRITE_EXTERNAL_STORAGE"

CheckPermissionGranted = function(slot0)
	return PermissionMgr.Inst:CheckPermissionGranted(slot0)
end

ApplyPermission = function(slot0)
	PermissionMgr.Inst:ApplyPermission(slot0)
end

OpenDetailSetting = function()
	PermissionMgr.Inst:OpenDetailSetting()
end

OnPermissionRequestResult = function(slot0)
	pg.m02:sendNotification(PERMISSION_GRANTED, slot0)
end

OnPermissionNeverRemind = function(slot0)
	pg.m02:sendNotification(PERMISSION_NEVER_REMIND, slot0)
end

OnPermissionReject = function(slot0)
	pg.m02:sendNotification(PERMISSION_REJECT, slot0)
end
