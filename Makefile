FLAGS := -skip-unused -enable-globals

build-windows:
	v -prod $(FLAGS) -os windows .

test-windows:
	v $(FLAGS) -os windows .

# we can only use -compress on linux for now
build-linux:
	v -prod $(FLAGS) -compress .

test-linux:
	v $(FLAGS) -compress  .