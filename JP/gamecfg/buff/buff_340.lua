return {
	time = 0,
	name = "航母空袭降低隐蔽恢复",
	init_effect = "",
	picture = "",
	desc = "",
	stack = 1,
	id = 340,
	icon = 340,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onAllInStrike"
			},
			arg_list = {
				buff_id = 341,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onChargeWeaponFire"
			},
			arg_list = {
				buff_id = 341,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onManualMissileFire"
			},
			arg_list = {
				buff_id = 341,
				target = "TargetSelf"
			}
		}
	}
}
