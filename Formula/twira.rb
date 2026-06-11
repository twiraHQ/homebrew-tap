class Twira < Formula
  desc "Code intelligence engine for AI coding assistants"
  homepage "https://twira.com"
  license "LicenseRef-Proprietary"
  version "2.0.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.2/twira-v2.0.2-aarch64-apple-darwin.tar.gz"
      sha256 "be3bc26d14a73afeb3c51f321a09e5186c8567347d2c87030a1b8c3dbca3518c"
    else
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.2/twira-v2.0.2-x86_64-apple-darwin.tar.gz"
      sha256 "02bcf99de6c825d059597f8dc5cc411b70eead1f0298881a987b62197d98a345"
    end
  end

  on_linux do
    # Only x86_64 Linux is built (no aarch64-unknown-linux-gnu target).
    url "https://github.com/TwiraHQ/twira/releases/download/v2.0.2/twira-v2.0.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "b0e3207d6a1a631c89ffeff75c159abcf58d50063e05a0d1817401bbc7ba5a44"
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
