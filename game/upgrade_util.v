module game

const all_upgrades = [ Upgrade(No{}),
	Upgrade(Click_100x{}), Upgrade(Income_10x{})
]

fn is_valid_upgrade(upgrade_id int) bool {
	return all_upgrades[upgrade_id].id == upgrade_id
}

fn is_applied(upgrade_id int) bool {
	return state.applied_ups.contains(upgrade_id)
}

fn apply_upgrade(mut up Upgrade) bool {
	if (state.credits - up.price).signum == 1  && !is_applied(up.id) {
		match up.up_type {
			.income { state.income     = state.income     * up.multiplier }
			.click  { state.click_mult = state.click_mult * up.multiplier }
			else    { /*no op*/ }
		}
		state.credits = state.credits - up.price
		state.applied_ups << up.id // add to applied upgrades
		return true
	} 

	return false
}

fn get_available_upgrades() []Upgrade {

	mut tmp := []Upgrade{}

	for i in all_upgrades {
		if i.id == 0 { continue }

		if i.price.str().len <= state.credits.str().len + 3
			|| !state.applied_ups.contains(i.id) {
			
			tmp << i
		}
	}

	return tmp

}