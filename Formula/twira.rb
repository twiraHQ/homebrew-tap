class Twira < Formula
  desc "Code intelligence engine for AI coding assistants"
  homepage "https://twira.com"
  license "LicenseRef-Proprietary"
  version "2.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TwiraHQ/twira/releases/download/v2.1.1/twira-v2.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "32d4a7410025d38f382ed778590ffb7aeb81aacff42884217e3b0fbfaf0ad79f"
    else
      url "https://github.com/TwiraHQ/twira/releases/download/v2.1.1/twira-v2.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "d90e74a69ad531b451bcdc5a7fde69437b2c51061cdd10667d4808a77e53893b"
    end
  end

  on_linux do
    # Only x86_64 Linux is built (no aarch64-unknown-linux-gnu target).
    url "https://github.com/TwiraHQ/twira/releases/download/v2.1.1/twira-v2.1.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "e813c75548443f64fe6b716946dc007fc335c9f6fe63fb80b8a9bf17d787fe0c"
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
