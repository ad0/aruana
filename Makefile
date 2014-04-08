BIN=aruana
SRC=$(wildcard src/*.hs src/*.x src/*.y)

all: $(BIN)

aruana: $(SRC)
	cabal configure
	cabal build
	cp dist/build/aruana/aruana .

clean:
	rm -rf ./aruana
	cabal clean
