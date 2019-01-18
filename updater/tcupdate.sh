#!/bin/sh

. ${HOME}/.updater.conf

repo_create() {
	if git clone $IPROUTE2_URL $PROJECT_DIR/iproute2; then
		return 0
	fi
	return 1
}

repo_update() {
	pushd $PROJECT_DIR/iproute2
	git checkout master
	git fetch --all
	git pull
	make clean
	./configure && make
	popd
}

if [ ! -d $PROJECT_DIR/iproute2 ]; then
	repo_create
fi
repo_update
