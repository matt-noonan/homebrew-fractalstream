class Fsrun < Formula
  desc "Command-line renderer and tester for FractalStream projects"
  homepage "https://github.com/matt-noonan/FractalStream"
  version "0.0.2-alpha.1"
  license "BSD-3-Clause"

  # Check the repository's tags rather than its latest release, since
  # releases may be marked as prereleases (tagged like v1.2.3-alpha.1).
  livecheck do
    url :stable
    strategy :git
    regex(/^v?(\d+(?:\.\d+)+(?:-[a-z0-9]+(?:\.[a-z0-9]+)*)?)$/i)
  end

  # A prebuilt binary: building from source needs GHC and LLVM 12, which
  # Homebrew no longer provides.
  on_macos do
    on_arm do
      url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/fsrun-#{version}-macos-arm64.tar.gz"
      sha256 "eb06506e290825e2cfc21e17c5a42210ce552e174dbb26a3fda1b46cf4501753"
    end
    on_intel do
      url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/fsrun-#{version}-macos-x86_64.tar.gz"
      sha256 "6e9d408d2cf469bc2ac28834e0fa75ae33a1fb872e8ba838a88bb8caabfa7420"
    end
  end
  # The Linux build bundles the shared libraries it needs (LLVM 12 among
  # them) in lib/, next to bin/, and needs glibc 2.39 or newer.
  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/fsrun-#{version}-linux-x86_64.tar.gz"
      sha256 "032491ecf9c6f0468221404a62cdca37ebb0dcd6696940b373354adf487b8065"
    end
  end

  def install
    if OS.mac?
      bin.install "fsrun"
    else
      # fsrun finds its libraries through an $ORIGIN/../lib rpath, so keep
      # bin/ and lib/ together.
      libexec.install "bin", "lib"
      bin.install_symlink libexec/"bin/fsrun"
    end
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
