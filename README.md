
Dotfiles
========

After cloning this repo, run `./install` to automatically set up the development
environment. Note that the install script is idempotent: it can safely be run
multiple times.

After install is completed, open vim and run `:PluginInstall`

`YouCompleteMe` requires installation, see [instructions](https://github.com/Valloric/YouCompleteMe).

`vimrc` uses patched fonts, I recommend [Inconsolata-g](https://github.com/powerline/fonts/tree/master/Inconsolata-g).  

Dotfiles uses [Dotbot][dotbot] for installation.

Making Customizations
---------------------------

Below are the main config files and their corrosponding symlinks:

* `vim` : `~/.vimrc`
* `zsh` : `~/.zshrc`
* `gitconfig` : `~/.gitconfig`
* `tmux.conf` : `~/.tmux.conf`

License
-------

Copyright (c) 2015 Kenny Kaye. Released under the MIT License. See
[LICENSE.md][license] for details.

[dotbot]: https://github.com/anishathalye/dotbot
[license]: LICENSE.md

