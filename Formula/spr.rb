class Spr < Formula
  desc "Submit pull requests for individual, amendable, rebaseable commits to GitHub"
  homepage "https://github.com/getcord/spr"
  url "https://github.com/getcord/spr.git",
    tag:      "v1.3.1",
    revision: "972a38c8a052a239042d631e20a4cf9b3376e4e6"
  license "MIT"

  bottle do
    root_url "https://github.com/getcord/homebrew-tap/releases/download/spr-1.3.1"
    sha256 cellar: :any,                 monterey:     "3faf33fc17a5b7c98e447a7cf53b16fbb393edf3415be8b47400fcc4f95fa9b9"
    sha256 cellar: :any,                 big_sur:      "8420004cc682a3065740d994a7b0f7d16488740413535be0cab78fc646b83f32"
    sha256 cellar: :any,                 catalina:     "8b66466e815506e99156f0dce418a60148177fbbf602e2d462737e522502505f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f8ca3ece9d04d5d910b71c7788095440ec81439b25c0c6773c45b2eff387406b"
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
