#!/bin/bash

if [ -f /root/share/tools/testing/selftests/tc-testing/skip_test ]; then
	echo "test skipped" | systemd-cat -t run_tdc.sh -p warning
else
	if pushd /root/share/tools/testing/selftests/tc-testing; then
		# allow bpf syscall from systemd context
		setenforce 0
		# eBPF plugin
		ln -sf ../plugin-lib/buildebpfPlugin.py plugins/10-buildebpfPlugin.py
		# run the test
		python3 ./tdc.py -B -c bpf
		popd
	fi
	poweroff
fi

