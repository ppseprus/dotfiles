#!/usr/bin/env bash

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`
# * ~/.private can be used for other settings you don’t want to commit
for file in ~/.{path,bash_prompt,aliases,private}
do
	[ -r $file ] && [ -f $file ] && source $file
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Do not autocomplete when accidentally pressing Tab on an empty line
shopt -s no_empty_cmd_completion

# System update
sysupdate() {
	sudo softwareupdate -i -a
}

# Environment update
envupdate() {
	declare -a actions=("npm update -g npm" "npm update -g")
	for action in "${actions[@]}"
	do
		echo "Run action: $action"
		sudo ${action}
	done
	unset action actions
}

# Update dotfiles
# `cd` to the directory of the `dotfiles` repository and type `dotfiles`
# cp -af ~/<some directory structure>/dotfiles/<dotfile> ~/<dotfile>
dotfiles() {
	sudo -v
	for dotfile in .{bash_profile,bash_prompt,bashrc,aliases,vimrc}
	do
		if [ -r $dotfile ] && [ -f $dotfile ]
		then
			echo "Update $dotfile"
			cp -af $dotfile ~/$dotfile
		fi
	done
	source ~/.bash_profile
	unset dotfile
}

# Update dotfiles via SSH
# An `scp`-extending function to copy dotfiles to a remote server
# @param 1 <string> ssh user
# @param 2 <string> ssh host
remoteotfiles() {
	scp -p ~/.{bash_profile,bash_prompt,bashrc,aliases,vimrc} $1@$2:~/
}
