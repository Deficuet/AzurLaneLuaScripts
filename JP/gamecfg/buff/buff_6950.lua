return {
	time = 0,
	name = "",
	init_effect = "",
	id = 6950,
	picture = "",
	desc = "",
	stack = 1,
	color = "red",
	icon = 6950,
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				target = "TargetSelf",
				skill_id = 6950
			}
		}
	}
}
