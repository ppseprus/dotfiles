#!/usr/bin/env bash

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`
# * ~/.private can be used for other settings you don’t want to commit
for file in ~/.{path,bash_prompt,aliases,functions,private}
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
