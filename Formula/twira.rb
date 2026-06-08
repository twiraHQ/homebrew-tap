class Twira < Formula
  desc "Code intelligence engine for AI coding assistants"
  homepage "https://twira.com"
  license "LicenseRef-Proprietary"
  version "2.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.1/twira-v2.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "74613c929d828f3ffc144847f1dc635105344922049a2f8c28cf374f0e6ed339"
    else
      url "https://github.com/TwiraHQ/twira/releases/download/v2.0.1/twira-v2.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "1398c9e34ab0482dfa0e0d47f81aa3aeb865e94e09ff44a81cd2de06deb1082d"
    end
  end

  on_linux do
    # Only x86_64 Linux is built (no aarch64-unknown-linux-gnu target).
    url "https://github.com/TwiraHQ/twira/releases/download/v2.0.1/twira-v2.0.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "fa921d38388e0ebd58b170a1fd1f461d75dce14136f9949353a6aac9a58c9c36"
  end

  def install
    bin.install "twira"
    bin.install "libonnxruntime.dylib" if File.exist?("libonnxruntime.dylib")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/twira --version")
  end
end
