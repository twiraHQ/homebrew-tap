class Twira < Formula
  desc "Code intelligence engine for AI coding assistants"
  homepage "https://twira.com"
  license "LicenseRef-Proprietary"
  version "2.0.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.5/twira-v2.0.5-aarch64-apple-darwin.tar.gz"
      sha256 "461aa6628834787fb930ee2b6e4e6c9b7e1ab5e4c5f18d596a7ef29935d33c22"
    else
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.5/twira-v2.0.5-x86_64-apple-darwin.tar.gz"
      sha256 "c69a851479cbba3cc118d1d0a8ca69a575a4f3ce2b1e8d268e80f63390c9abd9"
    end
  end

  on_linux do
    # Only x86_64 Linux is built (no aarch64-unknown-linux-gnu target).
    url "https://github.com/TwiraHQ/twira/releases/download/v2.0.5/twira-v2.0.5-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b6d8c54b1ce58f4131d6b72da05b4f56cc6dfa55aee7157d79f1c75774f20149"
  end

  def install
    bin.install "twira"
    # Intel-macOS archive bundles the ONNX Runtime next to the binary
    # (ort load-dynamic); arm64 static-links it, so the file is absent.
    bin.install "libonnxruntime.dylib" if File.exist?("libonnxruntime.dylib")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/twira --version")
  end
end
