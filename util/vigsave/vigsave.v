module util.vigsave

import encoding.binary

pub struct VigsaveEncoder {
mut:
	data	[]byte
}

const separator = ':'.bytes()

pub fn (v VigsaveEncoder) encode_byte_arr(arr []byte) {
	v.data << ':'.bytes()
	binary.little_endian_put_u32(v.data, u32(arr.len))
	v.data << arr
}

pub fn (v VigsaveEncoder) encode_byte(b byte) {
	v.data << separator
	v.data << b
}

pub fn (v VigsaveEncoder) encode_int(i int) {
	binary.little_endian_put_u32(v.data, u32(1))
}