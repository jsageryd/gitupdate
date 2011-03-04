#!/bin/bash

# Runs updategitmanpages.bash and updategit.bash

if [ ! -z "${1}" ]; then
	./updategitmanpages.bash "git-manpages-${1}" && \
	./updategit.bash "git-${1}"
else
	echo "Specify Git version like:"
	echo "./gitupdate.bash 1.7.4"
	exit 1
fi
