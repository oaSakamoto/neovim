CONFIG=~/.config/vi
rm -rf $CONFIG
mkdir -p $CONFIG
stow --restow --target=$CONFIG .
