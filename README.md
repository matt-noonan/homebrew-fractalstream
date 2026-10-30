# Homebrew tap for FractalStream

```sh
brew install --cask matt-noonan/fractalstream/fractalstream   # the app, plus fsrun
brew install matt-noonan/fractalstream/fsrun                  # just fsrun
```

`fsrun` renders and tests FractalStream projects from the command line.

## Updating for a new release

Pushing a `v*` tag to [FractalStream](https://github.com/matt-noonan/FractalStream)
creates a draft release whose notes list each file's sha256. After publishing
it, set `version` and the `sha256` values in `Casks/fractalstream.rb` (from the
`FractalStream-*.zip` files) and `Formula/fsrun.rb` (from the `fsrun-*.tar.gz`
files).
