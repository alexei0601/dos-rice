# Manual Setup Notes

Steps required on your system that aren't part of the repo files themselves.

## Shell prompt (bash)

If your `~/.bashrc` sets a custom `PS1` using 256-color codes
(`\e[38;5;NNNm`), comment it out. Those codes bypass Alacritty's
16-color theme palette, so a monochrome theme like `amber.toml` will
show broken colors (e.g. plain white text where amber is expected).

This project uses Starship for the prompt instead, which respects
the active Alacritty color theme.
