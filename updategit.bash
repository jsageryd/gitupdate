#!/bin/bash

# Downloads and installs specified version of Git to /usr/local/git-version,
# and symlinks /usr/local/git -> /usr/local/git-version.
#
# Creates path and manpath in /etc/paths.d and /etc/manpaths.d/
# Set $NEWGIT variable before run.
# Run example:
# $ NEWGIT=git-1.6.5 ./updategit.bash

if [[ "$NEWGIT" != git* ]]; then
	echo "\$NEWGIT var not set. Run example:"
	echo "NEWGIT=git-1.6.5 ./updategit.bash"
	exit 1
fi

if [ -d "/usr/local/$NEWGIT" ]; then
	echo "/usr/local/$NEWGIT already exists."
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

# Create /etc/paths.d/git
echo 'Setting path in /etc/paths.d/git ...'
echo '/usr/local/git/bin' | sudo tee /etc/paths.d/git || exit 1

# Create /etc/manpaths.d/git
echo 'Setting paths in /etc/manpaths.d/git ...'
echo '/usr/local/git/share/man' | sudo tee /etc/manpaths.d/git || exit 1
echo '/usr/local/gitmanpages' | sudo tee -a /etc/manpaths.d/git || exit 1

# Done
which -s git
if [ $? -eq 0 ]; then
	echo -n "Git updated: "
	git --version
else
	echo "Git installed."
fi
