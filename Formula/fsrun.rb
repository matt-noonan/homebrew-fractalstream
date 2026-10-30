class Fsrun < Formula
  desc "Command-line renderer and tester for FractalStream projects"
  homepage "https://github.com/matt-noonan/FractalStream"
  version "2.0.0"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  # A prebuilt binary: building from source needs GHC and LLVM 12, which
  # Homebrew no longer provides.
  on_macos do
    on_arm do
      url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/fsrun-#{version}-macos-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    on_intel do
      url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/fsrun-#{version}-macos-x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "fsrun"
  end

  test do
    (testpath/"project.yaml").write <<~YAML
      script: |
        @viewer "Plane" var=z
        color <- if |z| < 1 then blue else black
    YAML
    system bin/"fsrun", "project.yaml", "--snapshot", "Plane", "--output", "plane.png"
    assert_path_exists testpath/"plane.png"
  end
end
