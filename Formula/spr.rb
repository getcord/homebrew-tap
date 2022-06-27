class Spr < Formula
  desc "Submit pull requests for individual, amendable, rebaseable commits to GitHub"
  homepage "https://github.com/getcord/spr"
  url "https://github.com/getcord/spr.git",
    tag:      "v1.3.3",
    revision: "1f6d99ef268643cead1341cfc51e57b84c50b962"
  license "MIT"

  bottle do
    root_url "https://github.com/getcord/homebrew-tap/releases/download/spr-1.3.3"
    sha256 cellar: :any_skip_relocation, monterey:     "8d465d0ccd02af50d3fc119dbf8b6a4250361560a7fcb3b5cc328df71d4f2ca7"
    sha256 cellar: :any_skip_relocation, big_sur:      "c7d8deea2991f1d904b5abbcf1b3fc7e6dd4f161f620da47235c9e057470d5d3"
    sha256 cellar: :any_skip_relocation, catalina:     "5dc1fab5e0c4f0ae0196596980726376bc5d897492fb5163f023d0f801534696"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f8f60261534687dd2d0344ef47733afc087eef052c9e64c75502d93cafdb3705"
  end

  depends_on "rust" => :build

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
