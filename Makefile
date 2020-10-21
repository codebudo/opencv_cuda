CURRENT_DIR := $(shell pwd)

.PHONY: all
all: setup configure build copy
	@echo "done."

.PHONY: setup
setup:
	mkdir -p build bin

.PHONY: configure
configure:
	cd build && cmake ..

.PHONY: build
build:
	cd build && make 

.PHONY: copy
copy:
	cp build/resizecpu build/resizegpu bin/

.PHONY: clean
clean:
	rm -rf build bin

.PHONY: docker
docker:
	docker build --tag opencv_cuda_build -f Dockerfile .

.PHONY: shell
shell:
	docker run --gpus all -ti -v ${CURRENT_DIR}:/data --workdir=/data opencv_cuda_build bash
	#With the command "--gpus all" the container has access to the GPU.
