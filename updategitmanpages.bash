#!/bin/bash

# Downloads and installs specified version of Git manpages to /usr/local/gitmanpages.
# WARNING NOTE: This script DELETES any previous content in '/usr/local/gitmanpages'.
# This script does not set $MANPATH, it only downloads the man files.
#
# Set $NEWGITMANPAGES variable before run.
# Run examples:
# $ ./updategitmanpages.bash git-manpages-1.6.6
# $ NEWGITMANPAGES=git-manpages-1.6.6 ./updategitmanpages.bash

# Use $1 as $NEWGITMANPAGES if set
if [ ! -z "${1}" ]; then
	NEWGITMANPAGES="${1}"
fi

# Check that the env var is properly set
if [[ "$NEWGITMANPAGES" != git* ]]; then
	echo "Git manpage version not properly specified. Example:"
	echo "./updategitmanpages.bash git-manpages-1.6.6"
	exit 1
fi

# Remove old directory
echo 'Removing /usr/local/gitmanpages ...'
[ -d /usr/local/gitmanpages ] && sudo rm -rf /usr/local/gitmanpages

# Create new directory
echo 'Creating new /usr/local/gitmanpages ...'
sudo mkdir -p /usr/local/gitmanpages || exit 1
pushd /usr/local/gitmanpages || exit 1

# Download manpages
echo 'Downloading Git man pages...'
sudo curl -O "http://www.kernel.org/pub/software/scm/git/$NEWGITMANPAGES.tar.gz" || exit 1

# Extract
echo 'Extracting...'
sudo tar xvzf "$NEWGITMANPAGES.tar.gz" || exit 1

# Remove tar
echo 'Removing tarball...'
sudo rm "$NEWGITMANPAGES.tar.gz" || exit 1

# Done
popd > /dev/null 2>&1
echo "Git man pages updated."
