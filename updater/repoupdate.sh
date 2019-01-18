#!/bin/bash

. ${HOME}/.updater.conf

repo_create()
{
	rm -rf $PROJECT_DIR/linux
	if git clone $MASTER_URL $PROJECT_DIR/linux ; then
		pushd $PROJECT_DIR/linux
		git remote add private $PRIVATE_URL
		if git fetch --all; then
			git pull
		fi
		popd
	fi
}

repo_update()
{
	pushd  $PROJECT_DIR/linux
	git checkout master
	git fetch --all
	git pull
	git push private master:master
	popd
}

if [ ! -d $PROJECT_DIR/linux ]; then
	repo_create
fi
repo_update
