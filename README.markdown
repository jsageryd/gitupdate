Git update scripts
==================

Scripts to install or update Git and Git man pages on OS X Snow Leopard.

Usage
------------------

### updategit.bash

Downloads the specified Git version, compiles and installs it to `/usr/local/$NEWGIT`,
then creates a symlink `/usr/local/git` -> `/usr/local/$NEWGIT`.
If this symlink already exists, it is replaced.
The script does not modify previously installed versions, and can be used to install multiple versions of Git if needed.

Set `$NEWGIT` before script is run:
	$ NEWGIT=git-1.6.5 ./updategit.bash

`sudo` is called from within the script.


### updategitmanpages.bash

Downloads the specified Git man pages and installs them into `/usr/local/gitmanpages/`.
If this directory already exists, it is removed first.

Set `$NEWGITMANPAGES` before script is run:
	$ NEWGITMANPAGES=git-manpages-1.6.5 ./updategitmanpages.bash

`sudo` is called from within the script.


Note
------------------

For `$MANPATH` to be correctly set from `/etc/manpaths.d/*` on OS X Snow Leopard, I have added the following to my `.profile`:

	# Make path_helper set MANPATH from /etc/manpaths.d/*

	export MANPATH=
	if [ -x /usr/libexec/path_helper ]; then
		eval `/usr/libexec/path_helper -s`
	fi

Without this, `$MANPATH` will not be set, and the manpages in `/usr/local/gitmanpages/` may not be found.


Disclaimer
------------------

I take no responsibility for these scripts should they cause any harm.
