# load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,aliases,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# run multiple installs and updates
update() {
    declare -a actions=("softwareupdate -i -a" "npm install npm -g" "npm update -g npm" "npm update -g");
    for action in "${actions[@]}";
        echo "Run action: ${action}";
        sudo ${action};
        echo;
    done;
    unset actions;
    unset action;
};