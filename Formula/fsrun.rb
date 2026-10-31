class Fsrun < Formula
  desc "Command-line renderer and tester for FractalStream projects"
  homepage "https://github.com/matt-noonan/FractalStream"
  version "0.0.1"
  license "BSD-3-Clause"

  # Check the repository's tags rather than its latest release, since
  # releases may be marked as prereleases.
  livecheck do
    url :stable
    strategy :git
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on :macos

  # A prebuilt binary: building from source needs GHC and LLVM 12, which
  # Homebrew no longer provides.
  on_macos do
    on_arm do
      url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/fsrun-#{version}-macos-arm64.tar.gz"
      sha256 "4cd07ee89a8030d73d1a09653209c177a9b4486b5f9977bd9b22945446208018"
    end
    on_intel do
      url "https://github.com/matt-noonan/FractalStream/releases/download/v#{version}/fsrun-#{version}-macos-x86_64.tar.gz"
      sha256 "c00cd323de5de45b11388d974119d2f66a2648df6226a5779fd56887606f4991"
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
