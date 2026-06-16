class Twira < Formula
  desc "Code intelligence engine for AI coding assistants"
  homepage "https://twira.com"
  license "LicenseRef-Proprietary"
  version "2.0.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.3/twira-v2.0.3-aarch64-apple-darwin.tar.gz"
      sha256 "df9955ec0a5374d3fb9d370f08f820b4d8f159b5611ab779fbaab25bf605e2d5"
    else
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.3/twira-v2.0.3-x86_64-apple-darwin.tar.gz"
      sha256 "303dc85d9f5b641ad2c0ae14b40484351f3396e6924608b792efc2664ab381b0"
    end
  end

  on_linux do
    # Only x86_64 Linux is built (no aarch64-unknown-linux-gnu target).
    url "https://github.com/TwiraHQ/twira/releases/download/v2.0.3/twira-v2.0.3-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "56babe02c5c7c21f812945f7ba84b53f1682dbbbe86862acb83bb3fbb7a29f5c"
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
