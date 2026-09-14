# homebrew-ymlx

Homebrew tap for [ymlx](https://github.com/pavsefcik/ymlx) — a small zsh
launcher for browsing, running and downloading local MLX LLMs on Apple Silicon,
with a drop-in OpenAI-compatible REST endpoint at `localhost:11500`.

## Install

```sh
brew install pavsefcik/ymlx/ymlx
```

That's all — works on any Homebrew version. Homebrew 6 trusts exactly this
formula when you install it by fully-qualified name, so no separate tap/trust
step is needed.

If you'd rather have the short `ymlx` name (e.g. for `brew upgrade ymlx`):

```sh
brew trust pavsefcik/ymlx   # Homebrew 6+: trusts non-official taps; skip on older versions
brew tap pavsefcik/ymlx
brew install ymlx
```

Homebrew 6.x refuses to load formulae from non-official taps until the tap is
explicitly trusted (older Homebrews don't have `brew trust` — just skip that
line). If you already ran `brew tap` and saw
`Error: Cannot tap pavsefcik/ymlx: invalid syntax in tap!`, re-run the tap
command after trusting.

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
