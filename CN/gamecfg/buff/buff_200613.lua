return {
	time = 0,
	name = "2023 主线15-4 三阶段亡语",
	init_effect = "",
	picture = "",
	desc = "",
	stack = 1,
	id = 200613,
	icon = 200613,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onBeforeFatalDamage"
			},
			arg_list = {
				buff_id = 200614,
				target = {
					"TargetAllHelp",
					"TargetShipType"
				},
				ship_type_list = {
					7
				}
			}
		}
	}
}
