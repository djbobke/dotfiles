# My dotfiles
Look around if you like

## Note for myself

oneline installer:

`git clone https://github.com/rikvdh/dotfiles.git ~/.dotfiles && pushd ~/.dotfiles && git submodule update --init && ./install && popd`

or without git:

`mkdir -p ~/.dotfiles && wget -O- https://github.com/rikvdh/dotfiles/archive/master.tar.gz | tar xzf - -C ~/.dotfiles --strip-components=1 && pushd ~/.dotfiles && ./install && popd`
