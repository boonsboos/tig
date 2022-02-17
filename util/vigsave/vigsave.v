module vigsave

import encoding.binary

pub struct VigsaveEncoder {
mut:
	data	[]byte
}

const separator = ':'.bytes()[0]

pub fn (mut v VigsaveEncoder) encode_byte_arr(arr []byte) {
	v.data << separator
	mut tmp := []byte{len:4}
	binary.big_endian_put_u32(mut tmp, u32(arr.len))
	v.data << tmp
	v.data << arr
}

pub fn (mut v VigsaveEncoder) encode_int(i int) {
	v.data << separator
	mut tmp := []byte{len:4}
	binary.big_endian_put_u32(mut tmp, u32(i))
	v.data << tmp
}

pub fn (mut v VigsaveEncoder) encode_int_array(arr []int) {
	v.data << separator
	mut tmp := []byte{len:4}
	binary.big_endian_put_u32(mut tmp, u32(arr.len))
	v.data << tmp
	for i in arr {
		mut pmt := []byte{len:4}
		binary.big_endian_put_u32(mut pmt, u32(i))
		v.data << pmt
	}
}

pub fn (mut v VigsaveEncoder) encode_byte(b byte) {
	v.data << separator
	v.data << b
}

[inline]
pub fn (mut v VigsaveEncoder) finish() []byte {
	return v.data
}

pub struct VigsaveDecoder {
pub mut:
	data	[]byte
mut:
	idx		int
}

pub fn (mut v VigsaveDecoder) decode_byte_arr() []byte {
	if v.data[v.idx] == separator {
		v.idx++
		arr_len := int(binary.big_endian_u32(v.data[v.idx..v.idx+4]))
		v.idx += 4 + arr_len

		return v.data[v.idx-arr_len..v.idx]
	}

	return []byte{}
}

pub fn (mut v VigsaveDecoder) decode_int() u32 {
	if v.data[v.idx] == separator {
		v.idx += 5
		return binary.big_endian_u32(v.data[v.idx-4..v.idx])
	}

	return u32(0)
}

pub fn (mut v VigsaveDecoder) decode_int_array() []int {
	if v.data[v.idx] == separator {

		v.idx++
		arr_len := int(binary.big_endian_u32(v.data[v.idx..v.idx+4]))
		mut res := []int{len:arr_len}
		v.idx += 4
		for _ in 0..arr_len {
			res << int(binary.big_endian_u32(v.data[v.idx..v.idx+4]))
			v.idx += 4
		}

		return res
	}

	return [0]
}
pub fn (mut v VigsaveDecoder) decode_byte() byte {
	if v.data[v.idx] == separator {
		v.idx += 2
		return v.data[v.idx-1]
	}

	return byte(0)
}