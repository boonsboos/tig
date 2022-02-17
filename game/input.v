module game

import term.ui

fn handle_input(event &ui.Event, hm voidptr) {

	if event.typ == .key_down {
		
		match event.code {
			.escape { exit(0) }
			.space  { increment_credits() }
			.enter  { /* handle confirmations */ }
			.left 	{ change_window_focus() }
			.right	{ change_window_focus() }
			//.u      { apply_upgrade(mut up) }
			else {}
		}
	}

	
}

fn change_window_focus() {
	if state.focused == .upgrades {
		state.focused = .machines
	} else {
		state.focused = .upgrades
	}
}