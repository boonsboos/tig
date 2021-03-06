module game 

import math.big

const magnitudes = ['',
'K', 'M', 'B', 'T', 'Qa', 'Qu', 'Sx', 'Sp', 'Oc', 'No', 'Dc',
'UDc', 'DDc', 'TDc', 'QtDc', 'QiDc', 'SxDc', 'SpDc', 'OcDc', 'NoDc',
'Vg', 'UVg', 'DVg', 'TVg', 'QtVg', 'QiVg', 'SxVg', 'SpVg', 'OcVg', 'NoVg'
'Tg', 'UTg', 'DTg', 'TTg', 'QtTg', 'QiTg', 'SxTg', 'SpTg', 'OcTg', 'NoTg']

pub fn format_number_string(number big.Integer) string {

	nr := number.str()

	if nr.len > 5 {

		if nr.len % 3 == 1 {
			return '${nr[0].ascii_str()}.${nr[1..4]}${magnitudes[nr.len/3]}'
		}

		if nr.len % 3 == 2 {
			return '${nr[0..2]}.${nr[2..4]}${magnitudes[nr.len/3]}'
		}

		if nr.len % 3 == 0 {
			return '${nr[0..3]}.${nr[3].ascii_str()}${magnitudes[(nr.len/3)-1]}'
		} //celse if nr.len % 3 == 0 && f64(nr.len) / 3.0 == 2 {
		// 	return '${nr[0..3]}.${nr[3].ascii_str()}${magnitudes[]}'
		// }
		
	}

	return nr
}