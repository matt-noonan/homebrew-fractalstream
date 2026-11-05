class Fsrun < Formula
  desc "Command-line renderer and tester for FractalStream projects"
  homepage "https://github.com/matt-noonan/FractalStream"
  version "0.0.4-alpha"
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
      sha256 "94687c6cd2bb4dd554e9dcbca0fe1adf04d4a2c015502eef47379955de3511e6"
    end
    on_intel do
      url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/fsrun-#{version}-macos-x86_64.tar.gz"
      sha256 "be40485f4db56ab449bb9daff964044982694828146ce9c409cf032005065037"
    end
  end
  # The Linux build bundles the shared libraries it needs (LLVM 12 among
  # them) in lib/, next to bin/, and needs glibc 2.39 or newer.
  on_linux do
    depends_on arch: :x86_64
    on_intel do
      url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/fsrun-#{version}-linux-x86_64.tar.gz"
      sha256 "d4c4901e6e980ed8d8a2f20a511f14ea106443a066029fb492d55ae6a32d32d0"
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
