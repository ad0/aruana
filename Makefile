SRC=$(wildcard src/*.hs src/*.x src/*.y)

all: $(SRC)
	cabal configure
	cabal build
	cp dist/build/aruana/aruana .
	cp dist/build/pirana/pirana .

clean:
	rm -rf ./aruana ./pirana
	cabal clean
