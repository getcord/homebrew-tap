class Spr < Formula
  desc "Submit pull requests for individual, amendable, rebaseable commits to GitHub"
  homepage "https://github.com/getcord/spr"
  url "https://github.com/getcord/spr.git",
    tag:      "v1.3.1",
    revision: "972a38c8a052a239042d631e20a4cf9b3376e4e6"
  license "MIT"

  bottle do
    root_url "https://github.com/getcord/homebrew-tap/releases/download/spr-1.3.0"
    sha256 cellar: :any,                 monterey:     "56404b66b9fa7a462feeb64675a608af3476c1384ead42071058aac5f7ed4463"
    sha256 cellar: :any,                 big_sur:      "4e1d3b7b5e09cac1080fe7f8e9e19a7a31823b8d0e7255e4cd71bdb999e6a318"
    sha256 cellar: :any,                 catalina:     "c2b07114deb4c70c52a442807fb008009411a708aac7f0afd74443a8b1e20e6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "58812ad94ff297fbe04db657426214ad7c07ecdb08924043fd918aceb1441c24"
  end

  depends_on "rust" => :build
  depends_on "openssl@1.1"

  on_linux do
    depends_on "pkg-config" => :build
    depends_on "zlib"
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "spr #{version}", shell_output("#{bin}/spr --version")
  end
end
