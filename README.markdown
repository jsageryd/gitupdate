Git update scripts
==================

Scripts to install or update Git and Git man pages on OS X Snow Leopard.

Usage
------------------

### gitupdate.bash

Runs `./updategitmanpages.bash` and `./updategit.bash`.

Example:
	$ ./gitupdate.bash 1.7.4


### updategit.bash

Downloads the specified Git version (`$NEWGIT`), compiles and installs it to `/usr/local/$NEWGIT`,
then creates a symlink `/usr/local/git` -> `/usr/local/$NEWGIT`.
If this symlink already exists, it is replaced.
The script does not modify previously installed versions, and can be used to install multiple versions of Git if needed.

Example:
	$ ./updategit.bash git-1.6.6

`sudo` is called from within the script.


### updategitmanpages.bash

Downloads the specified Git man pages and installs them into `/usr/local/gitmanpages/`.
If this directory already exists, it is removed first.

Example:
	$ ./updategitmanpages.bash git-manpages-1.6.6

`sudo` is called from within the script.


Note
------------------

Be sure to set `$PATH` and `$MANPATH`:
	export PATH=/usr/local/git/bin:$PATH
	export MANPATH=/usr/local/git/share/man:/usr/local/gitmanpages:$MANPATH


Disclaimer
------------------

I take no responsibility for these scripts should they cause any harm.
