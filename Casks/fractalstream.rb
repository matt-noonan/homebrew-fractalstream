cask "fractalstream" do
  arch arm: "arm64", intel: "x86_64"

  version "0.0.2-alpha.1"
  sha256 arm:   "4fea0b02fa7180b3491394195c79c8bfbfec55d22611f9cd420221e10524dd7e",
         intel: "bf776ca74ec191627c9539bd8f8a3050c6d289733a3e84ad570eda503d33aa44"

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
