class Twira < Formula
  desc "Code intelligence engine for AI coding assistants"
  homepage "https://twira.com"
  license "LicenseRef-Proprietary"
  version "2.0.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.4/twira-v2.0.4-aarch64-apple-darwin.tar.gz"
      sha256 "0a2400f9980a359662afa091cf0c92f7fed7e9fc97eb3815dab61f827c8e1787"
    else
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.4/twira-v2.0.4-x86_64-apple-darwin.tar.gz"
      sha256 "29a3b20343804b85e0b9d5c247353ef91d923b3eb8e37f022d78d61dccfa927b"
    end
  end

  on_linux do
    # Only x86_64 Linux is built (no aarch64-unknown-linux-gnu target).
    url "https://github.com/TwiraHQ/twira/releases/download/v2.0.4/twira-v2.0.4-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "283024f0e12c23f15a16cac1119588c641c29673110106441808565a1adeafbf"
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
