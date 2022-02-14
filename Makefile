FLAGS := -skip-unused -enable-globals

build-windows:
	v -prod $(FLAGS) -os windows .

test-windows:
	v $(FLAGS) -os windows .

build-linux:
	v -prod $(FLAGS) -compress .