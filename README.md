# homebrew-ymlx

Homebrew tap for [ymlx](https://github.com/pavsefcik/ymlx) — a small zsh
launcher for browsing, running and downloading local MLX LLMs on Apple Silicon,
with a drop-in OpenAI-compatible REST endpoint at `localhost:11500`.

## Install

```sh
brew tap pavsefcik/ymlx
brew install ymlx
```

The formula installs `ymlx` plus the Homebrew packages it needs (`gum`, `uv`).
The runtime model runtime, `mlx-vlm`, has no formula (it is a uv tool), so run
the one-off setup once to install it and wire the optional pi extension:

```sh
sh "$(brew --prefix)/opt/ymlx/libexec/install.sh"
```

Then add the launcher to `~/.zshrc` and reload:

```sh
echo 'source "$(brew --prefix)/opt/ymlx/libexec/ymlx-launcher.zsh"' >> ~/.zshrc
source ~/.zshrc
ymlx
```

## Update

```sh
brew update && brew upgrade ymlx
```

## Development

The formula is generated from `/Users/pavel/Dev/projects/ymlx` via its Makefile:
`make formula` recomputes the `sha256`/`url` from the actual GitHub release
tarball after a tag is pushed. See that Makefile for the full release flow.
