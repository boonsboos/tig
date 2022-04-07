module util

import os
import time
import math.big

import tigsave

const lastsave = '${saves_folder}lastsave'

fn save_file() {

	time_now := time.now().get_fmt_date_str(.hyphen, .ddmmyyyy)
	save_file_name := '${time_now}.tigsave'
	save_path := '$saves_folder$save_file_name'

	if os.exists(save_path) {
		backup_file(save_path)
		os.create(save_path) or { failed_to_write(save_file_name) }
	} 

	mut encode := tigsave.TigsaveEncoder{}
	mut save_file := os.open_append(save_path) or { failed_to_open(save_file_name) }

	credit_bytes, _ := state.credits.bytes()
	encode.encode_byte_arr(credit_bytes)

	income_bytes, _ := state.income.bytes()
	encode.encode_byte_arr(income_bytes)

	// encode lightswitches
	encode.encode_int(1)
	encode.encode_int(state.machines.ls.amount)
	encode.encode_int(state.machines.ls.mult)

	save_file.write(encode.finish()) or { failed_to_write(save_file_name) }

	save_file.close()

	if !os.exists(lastsave) {
		os.create(lastsave) or { failed_to_write('lastsave') }
	}

	os.write_file(lastsave, save_file_name) or { failed_to_write('lastsave') }
}

pub fn load_save() {
	// only run if there is a savefile present
	// if the lastsave file is present, there has to be a save file
	// could make this a symlink, perhaps? though not cross-platform
	if !os.exists(lastsave) { return }

	ic := big.IntegerConfig{}

	mut decode := tigsave.TigsaveDecoder{}
	save_file_name := os.read_lines(lastsave) or { failed_to_open('lastsave') }[0]

	decode.data = os.read_bytes('$saves_folder$save_file_name') or { failed_to_open('$save_file_name') }

	state.credits    = big.integer_from_bytes(decode.decode_byte_arr(), ic)
	state.income     = big.integer_from_bytes(decode.decode_byte_arr(), ic)

	// decode lightswitches
	if decode.decode_int() != 1 { dec_err() }
	state.machines.ls.amount = int(decode.decode_int())
	state.machines.ls.mult   = int(decode.decode_int())
}

[noreturn]
fn dec_err() {
	panic('malformed save file!')
}

pub fn reset_saves() {
	folder := os.ls(saves_folder) or { return }
	for i in folder {
		os.rm(saves_folder+i) or { failed_to_write(i) }
	}
}