return {
	desc_get = "",
	name = "公海舰队活动 塔干扰-旋涡",
	init_effect = "",
	id = 8945,
	time = 3,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 8945,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				buff_id = 8948,
				target = "TargetSelf"
			}
		},
		{
			type = "BattleBuffRegisterWaveFlags",
			trigger = {
				"onAttach"
			},
			arg_list = {
				flags = {
					8945
				}
			}
		}
	}
}
