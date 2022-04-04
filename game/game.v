module game

import gx
import math.big

import vgui

import util

__global state GameState

fn init() {
	state = GameState{}
}

pub struct GameState {
pub mut:
	credits		big.Integer
	income		big.Integer = big.one_int
	click_mult	big.Integer = big.one_int
	applied_ups []int // ids of applied upgrades
	avail_ups	[]Upgrade
	window		&vgui.Window = 0
}

pub fn game() {

	util.load_save()
	
	params := vgui.WindowParams{ 100, 100, voidptr(0)}

	state.window = vgui.create_window('vig', 400, 400, tick, params)
	apply_styling(mut state.window)

	state.window.run()
}

fn apply_styling(mut window &vgui.Window) {
	window.style.label.text.mono = true
	window.style.label.text.color = gx.green
	window.gg.set_bg_color(gx.Color{ 
		byte(10), byte(10), byte(10), byte(0)
	})
}

fn tick(mut window &vgui.Window) {

	// update values every tick ~ every 30 frames
	// TODO: refresh rate dependency
	if window.gg.frame % u64(30) == 0 {
		state.credits = state.credits + (state.income)
	
		state.avail_ups << get_available_upgrades()
	}

	// draw info
	window.label('credits| ${format_number_string(state.credits)}', 10, 10)
	window.label('income | ${format_number_string(state.income)}/t', 10, 20)

	// draw upgrades
	window.label('upgrades', 10, 40)
	draw_upgrades(mut window)
}

fn draw_upgrades(mut window &vgui.Window) {
	y := 50
	for i, j in state.avail_ups {
		if window.buttons[i].contains(j.describe) { continue }
		window.button(j.describe, 10, y + (i * 20))
	}
}