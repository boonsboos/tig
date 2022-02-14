build-windows:
	v -prod -skip-unused -enable-globals -os windows .

test-windows:
	v -skip-unused -enable-globals .

build-linux:
	v -prod -skip-unused -enable-globals -compress .