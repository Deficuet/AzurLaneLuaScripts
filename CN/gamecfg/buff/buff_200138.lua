return {
	time = 1,
	name = "2022莱莎联动 BOSS随机施放技能 二阶段",
	init_effect = "",
	id = 200138,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 200138,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkillRandom",
			trigger = {
				"onAttach"
			},
			arg_list = {
				target = "TargetSelf",
				skill_id_list = {
					200116,
					200117,
					200118,
					200119,
					200121
				},
				range = {
					{
						0,
						0.34
					},
					{
						0.34,
						0.52
					},
					{
						0.52,
						0.7
					},
					{
						0.7,
						0.88
					},
					{
						0.88,
						1
					}
				}
			}
		}
	}
}
