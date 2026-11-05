cask "fractalstream" do
  arch arm: "arm64", intel: "x86_64"

  version "0.0.4-alpha"
  sha256 arm:   "68568cd21b0e98c1369258aa6ff493ad5fa509f4fb4b20f8c391e71b8e5e2de7",
         intel: "3eab5b5a89c7216f7528e530479c7416c4679a24e95a7e516afff3f3ead96dc7"

  url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/FractalStream-#{version}-macos-#{arch}.zip"
  name "FractalStream"
  desc "Explore real and complex dynamical systems"
  homepage "https://github.com/matt-noonan/FractalStream"

  # Check the repository's tags rather than its latest release, since
  # releases may be marked as prereleases (tagged like v1.2.3-alpha.1).
  livecheck do
    url :url
    strategy :git
    regex(/^v?(\d+(?:\.\d+)+(?:-[a-z0-9]+(?:\.[a-z0-9]+)*)?)$/i)
  end

  # The command-line renderer, for scripting and checking projects.
  depends_on formula: "matt-noonan/fractalstream/fsrun"
  # The release builds run on macOS 15 runners.
  depends_on macos: :sequoia

  app "FractalStream.app"
end
