class Spr < Formula
  desc "Submit pull requests for individual, amendable, rebaseable commits to GitHub"
  homepage "https://github.com/getcord/spr"
  url "https://github.com/getcord/spr.git",
    tag:      "v1.2.3",
    revision: "f48663ae9cbd7eb7dee757c56726818351fb8871"
  license "MIT"

  bottle do
    root_url "https://github.com/getcord/homebrew-tap/releases/download/spr-1.2.3"
    rebuild 1
    sha256 cellar: :any,                 big_sur:      "e02a8536fbebef6c0d766208072086535fb025a34df019d94fedba0f9c72ff3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "062133dfc8434cd0dcc5777a858bd53a058a446cdfd55b3acdda992919f8d0a4"
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
