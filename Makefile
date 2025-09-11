.PHONY: build
build:
	mkdir -p build
	ansible-galaxy collection build --force --output-path build

.PHONY: clean
clean:
	rm -rf build/

install: build
	ansible-galaxy collection install --force build/fabacab-workstation_setup-*.tar.gz
