module game

import term.ui

fn handle_input(event &ui.Event, hm voidptr) {

	if event.typ == .key_down {
		
		match event.code {
			.escape { exit(0) }
			.enter { increment_credits() }
			
			else {}
		}
	}

	
}