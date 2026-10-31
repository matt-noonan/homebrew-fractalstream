# Homebrew tap for FractalStream

```sh
brew tap matt-noonan/fractalstream
brew trust matt-noonan/fractalstream
brew install --cask fractalstream   # the app, plus fsrun
brew install fsrun                  # or just fsrun
```

Homebrew only loads formulae and casks from taps you trust, and the
FractalStream cask depends on the fsrun formula, so trust the tap first.
(Installing `matt-noonan/fractalstream/fsrun` by its full name also trusts
that formula.)

`fsrun` renders and tests FractalStream projects from the command line.

## Updating for a new release

Pushing a `v*` tag to [FractalStream](https://github.com/matt-noonan/FractalStream)
creates a draft release whose notes list each file's sha256. After publishing
it, set `version` and the `sha256` values in `Casks/fractalstream.rb` (from the
`FractalStream-*.zip` files) and `Formula/fsrun.rb` (from the `fsrun-*.tar.gz`
files).
