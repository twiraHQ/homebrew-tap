class Twira < Formula
  desc "Code intelligence engine for AI coding assistants"
  homepage "https://twira.com"
  license "LicenseRef-Proprietary"
  version "2.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TwiraHQ/twira/releases/download/v2.2.0/twira-v2.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "d8e714a5b72a3827339d4f2ad2ad8f55a537213f52e56f3fdb8119719b4ebb92"
    else
      url "https://github.com/TwiraHQ/twira/releases/download/v2.2.0/twira-v2.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "8e9f249cd77a3b66bd8817b70cd53ca9ad95ba283c69bc6c9b129d66ebcb2e5f"
    end
  end

  on_linux do
    # Only x86_64 Linux is built (no aarch64-unknown-linux-gnu target).
    url "https://github.com/TwiraHQ/twira/releases/download/v2.2.0/twira-v2.2.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "51fcaa7c3f549a23b067d41c8d75ea5e171ae7f51286f4fedb3501f18fd210df"
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
