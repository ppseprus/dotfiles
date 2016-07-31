# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`
# * ~/.extra can be used for other settings you don’t want to commit
for file in ~/.{path,bash_prompt,aliases,extra}; do
    [ -r $file ] && [ -f $file ] && source $file;
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# System update
sysupdate() {
	sudo softwareupdate -i -a;
};

# Environment update
envupdate() {
    declare -a actions=("npm install npm -g" "npm update -g npm" "npm update -g");
    for action in "${actions[@]}"; do
        echo "Run action: $action";
        sudo ${action};
    done;
    unset action;
    unset actions;
};

# Update dotfiles
# `cd` to the directory of the `dotfiles` repository and type `dotfiles`
# cp -af ~/<some directory structure>/dotfiles/<dotfile> ~/<dotfile>
dotfiles() {
    sudo -v;
    for dotfile in .{bash_profile,bash_prompt,bashrc,aliases,vimrc}; do
        if [ -r $dotfile ] && [ -f $dotfile ]; then
            echo "Update $dotfile";
            cp -af $dotfile ~/$dotfile;
        fi;
    done;
    source ~/.bash_profile;
    unset dotfile;
};
