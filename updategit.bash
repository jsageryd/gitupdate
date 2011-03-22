#!/bin/bash

# Downloads and installs specified version of Git to /usr/local/git-version,
# and symlinks /usr/local/git -> /usr/local/git-version.
#
# Set $NEWGIT variable before run.
# Run examples:
# $ ./updategit.bash git-1.6.6
# $ NEWGIT=git-1.6.6 ./updategit.bash

# Check that make exists
which make > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "'make' not found. Install dev tools first."
	exit 1
fi

# Use $1 as $NEWGIT if set
if [ ! -z "${1}" ]; then
	NEWGIT="${1}"
fi

# Check that the env var is properly set
if [[ "$NEWGIT" != git* ]]; then
	echo "Git version not properly specified. Example:"
	echo "./updategit.bash git-1.6.6"
	exit 1
fi

# Check the symlink
if [ -d "/usr/local/$NEWGIT" ]; then
	echo -n "/usr/local/$NEWGIT already exists"
	if [ "/usr/local/$NEWGIT" = "$(readlink /usr/local/git)" ]; then
		echo " and the symlink is already set up."
	else
		# Update Git symlink
		sudo ln -fhs /usr/local/"$NEWGIT" /usr/local/git || (echo && exit 1)
		echo ". Symlink updated."
	fi
	exit 1
fi

# Download Git
echo 'Downloading Git...'
curl -O "http://www.kernel.org/pub/software/scm/git/$NEWGIT.tar.gz" || exit 1

# Extract
echo 'Extracting...'
tar xvzf "$NEWGIT.tar.gz" || exit 1

# Remove tar
echo 'Removing tarball...'
rm "$NEWGIT.tar.gz" || exit 1

# Configure and make
echo 'Running configure & make...'
pushd "$NEWGIT"
make configure || exit 1
./configure --prefix=/usr/local/"$NEWGIT" || exit 1
make || exit 1

# Install
echo 'Running make install...'
sudo make install || exit 1

# Remove source files
echo 'Removing Git source files...'
popd > /dev/null 2>&1
rm -rf "$NEWGIT" || exit 1

# Update Git symlink
echo 'Updating symlink /usr/local/git ...'
sudo ln -fhs /usr/local/"$NEWGIT" /usr/local/git || exit 1

# Done
which -s git
if [ $? -eq 0 ]; then
	echo -n "Git updated: "
	git --version
else
	echo "Git installed."
fi
