return {
	time = 0,
	name = "",
	init_effect = "",
	id = 800775,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 800770,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onStartGame"
			},
			arg_list = {
				skill_id = 800775,
				dungeonTypeList = {
					98,
					99
				}
			}
		},
		{
			type = "BattleBuffCount",
			trigger = {
				"onFire"
			},
			arg_list = {
				countTarget = 12,
				countType = 800770,
				index = {
					1
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onBattleBuffCount"
			},
			arg_list = {
				skill_id = 800771,
				target = "TargetSelf",
				countType = 800770
			}
		}
	}
}
