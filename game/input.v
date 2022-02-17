module game

import term.ui

fn handle_input(event &ui.Event, hm voidptr) {

	mut up := Click_100x{}

	if event.typ == .key_down {
		
		match event.code {
			.escape { exit(0) }
			.enter  { increment_credits() }
			.u      { apply_upgrade(mut up) }
			else {}
		}
	}

	
}