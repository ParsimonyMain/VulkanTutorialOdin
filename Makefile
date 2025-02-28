build:
	mkdir -p bin
	odin build src -extra-linker-flags:"-Wl,-rpath,/usr/local/lib" -out:bin/vrt

run: build
	./bin/vrt

clean:
	rm -rf bin