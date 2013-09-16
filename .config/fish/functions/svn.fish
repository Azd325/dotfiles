function svn
	/usr/bin/svn $argv | colordiff | less -r
end
