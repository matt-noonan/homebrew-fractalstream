cask "fractalstream" do
  arch arm: "arm64", intel: "x86_64"

  version "2.0.0"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "1111111111111111111111111111111111111111111111111111111111111111"

  url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/FractalStream-#{version}-macos-#{arch}.zip"
  name "FractalStream"
  desc "Explore real and complex dynamical systems"
  homepage "https://github.com/matt-noonan/FractalStream"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The command-line renderer, for scripting and checking projects.
  depends_on formula: "matt-noonan/fractalstream/fsrun"
  # The release builds run on macOS 15 runners.
  depends_on macos: :sequoia

  app "FractalStream.app"
end
