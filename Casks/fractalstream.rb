cask "fractalstream" do
  arch arm: "arm64", intel: "x86_64"

  version "0.0.1"
  sha256 arm:   "3ce859ed5e953088f4fbbffe786735acdc4c2951ddedbc3c7deac17a4bb86ba1",
         intel: "8ab48a229523606657ea701f663b4c19dbb563f5de49e889062db7ba98f0a005"

  url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/FractalStream-#{version}-macos-#{arch}.zip"
  name "FractalStream"
  desc "Explore real and complex dynamical systems"
  homepage "https://github.com/matt-noonan/FractalStream"

  # Check the repository's tags rather than its latest release, since
  # releases may be marked as prereleases.
  livecheck do
    url :url
    strategy :git
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  # The command-line renderer, for scripting and checking projects.
  depends_on formula: "matt-noonan/fractalstream/fsrun"
  # The release builds run on macOS 15 runners.
  depends_on macos: :sequoia

  app "FractalStream.app"
end
