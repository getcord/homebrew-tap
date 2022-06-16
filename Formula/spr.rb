class Spr < Formula
  desc "Submit pull requests for individual, amendable, rebaseable commits to GitHub"
  homepage "https://github.com/getcord/spr"
  url "https://github.com/getcord/spr.git",
    tag:      "v1.3.2",
    revision: "808673bae021aa28e9ea5e4c1a56b8632ce576cc"
  license "MIT"

  bottle do
    root_url "https://github.com/getcord/homebrew-tap/releases/download/spr-1.3.2"
    sha256 cellar: :any_skip_relocation, monterey:     "fe61bf58a746b0793f9fd76a0768bf203b3c4e808a512074f98c25f1cb5c411e"
    sha256 cellar: :any_skip_relocation, big_sur:      "dded600ae2158fe7983aa82c0dfbd052520544f03cb29f4eb3345bacdf64a3da"
    sha256 cellar: :any_skip_relocation, catalina:     "19c9d0314dd30d56111fb375b8b0e6f4b73e6029a5ac3552f441bb55a8629251"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f03c9957505ffde0f185e7a389d9a5026595373ef802b19173e655983a7b8215"
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
