class Twira < Formula
  desc "Code intelligence engine for AI coding assistants"
  homepage "https://twira.com"
  license "LicenseRef-Proprietary"
  version "2.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TwiraHQ/twira/releases/download/v2.3.0/twira-v2.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "fa5aa927761e10714c8cf65b8f31cd8644743c9a71e51293e3290854c29249dc"
    else
      url "https://github.com/TwiraHQ/twira/releases/download/v2.3.0/twira-v2.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "fb728b6193df511be1ecce2eb49d27ed76f6623833b0d98be630ebbaf994a10a"
    end
  end

  on_linux do
    # Only x86_64 Linux is built (no aarch64-unknown-linux-gnu target).
    url "https://github.com/TwiraHQ/twira/releases/download/v2.3.0/twira-v2.3.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d86f6e41c21aefac1c442fa3b8df62b20e04e15c35360056c36576186c1f6fb7"
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
