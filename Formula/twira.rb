class Twira < Formula
  desc "Code intelligence engine for AI coding assistants"
  homepage "https://twira.com"
  license "LicenseRef-Proprietary"
  version "2.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TwiraHQ/twira/releases/download/v2.1.0/twira-v2.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "25b1bff800951ca0c5dd0822b4d9471b20b2bbcfc9c522679f15caad961b3cc4"
    else
      url "https://github.com/TwiraHQ/twira/releases/download/v2.1.0/twira-v2.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "cc5e462f1b28d00aecfcce77ba73ca62d8790e67bc5cf5d9333e65b742293665"
    end
  end

  on_linux do
    # Only x86_64 Linux is built (no aarch64-unknown-linux-gnu target).
    url "https://github.com/TwiraHQ/twira/releases/download/v2.1.0/twira-v2.1.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "36a399bed7e1fd3ec7eb4bb6f1c8ee33d6c4062f13b13b24ff28f25aab598eaa"
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
