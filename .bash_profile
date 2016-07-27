# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`
# * ~/.extra can be used for other settings you don’t want to commit
for file in ~/.{path,aliases,extra}; do
    [ -r $file ] && [ -f $file ] && source $file;
done;
unset file;

# Run multiple installs and updates
sysupdate() {
    declare -a actions=("softwareupdate -i -a" "npm install npm -g" "npm update -g npm" "npm update -g");
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
    for dotfile in .{bash_profile,aliases,vimrc}; do
        if [ -r $dotfile ] && [ -f $dotfile ]; then
            echo "Update $dotfile";
            cp -af $dotfile ~/$dotfile;
        fi;
    done;
    source ~/.bash_profile;
    unset dotfile;
};

# Show branch name in bash prompt
# username@hostname working_directory (current_branch)
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/';
};
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ ";

# Shell options

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
# Append to the Bash history file, rather than overwriting it
shopt -s histappend;
# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
