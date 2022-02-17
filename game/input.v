module game

import term.ui

fn handle_input(event &ui.Event, hm voidptr) {

	mut up := Click_100x{}

	if event.typ == .key_down {
		
		match event.code {
			.escape { exit(0) }
			.space  { increment_credits() }
			.enter  { /* handle confirmations */ }
			.u      { apply_upgrade(mut up) }
			else {}
		}
	}

	
}