class Spr < Formula
  desc "Submit pull requests for individual, amendable, rebaseable commits to GitHub"
  homepage "https://github.com/getcord/spr"
  url "https://github.com/getcord/spr.git",
    tag:      "v1.2.4",
    revision: "dc2e667fb6daf53cba8800b3a94a2ed6a7f460ac"
  license "MIT"

  bottle do
    root_url "https://github.com/getcord/homebrew-tap/releases/download/spr-1.2.4"
    sha256 cellar: :any,                 big_sur:      "f171c7683bd4d0bb04cd331f03a2fa8c62ccb293a2d70367bb69528c70fc074d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "47a19cb954c14943efc8abaf04d566681ec1e81ddbda08f6a4beafefdd814c7b"
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
end
