return {
	time = 5,
	name = "减速",
	init_effect = "",
	picture = "",
	desc = "6s减速",
	stack = 1,
	id = 424,
	icon = 424,
	last_effect = "Darkness",
	effect_list = {
		{
			type = "BattleBuffFixVelocity",
			trigger = {
				"onAttach",
				"onStack",
				"onRemove"
			},
			arg_list = {
				add = 0,
				mul = -1980,
				group = {
					id = 421,
					level = 4
				}
			}
		},
		{
			type = "BattleBuffCastSkillRandom",
			trigger = {
				"onAttach"
			},
			arg_list = {
				target = "TargetSelf",
				skill_id_list = {
					358,
					359,
					360,
					361
				},
				range = {
					{
						0,
						0.266
					},
					{
						0.266,
						0.532
					},
					{
						0.532,
						799
					},
					{
						0.799,
						1
					}
				}
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 5000,
				target = "TargetSelf",
				skill_id = 424
			}
		}
	}
}
