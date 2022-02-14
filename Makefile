build-windows:
	v -prod -skip-unused -os windows .

build-linux:
	v -prod -skip-unused -compress .