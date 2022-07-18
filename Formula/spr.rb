class Spr < Formula
  desc "Submit pull requests for individual, amendable, rebaseable commits to GitHub"
  homepage "https://github.com/getcord/spr"
  url "https://github.com/getcord/spr.git",
    tag:      "v1.3.4",
    revision: "1b05ef36f0beb0ff8bdb376bf98ce77a41e41605"
  license "MIT"

  bottle do
    root_url "https://github.com/getcord/homebrew-tap/releases/download/spr-1.3.4"
    sha256 cellar: :any_skip_relocation, monterey:     "b129726fbbf96238d3479646854c6f8d7a322f14107a84311b19002d5a6214c2"
    sha256 cellar: :any_skip_relocation, big_sur:      "8738c712487402640a9496b96afb3c9ddf304764d61350137db08d4f9661f5f1"
    sha256 cellar: :any_skip_relocation, catalina:     "32422a716b36033b4e3c35182375b8aaf03ff68739699bde1042e12d3ef24354"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "719869cd5398d3c32a72b13a42c5ec3d28676da225e01ed5d07d50d3323bfe08"
  end

  depends_on "rust" => :build
  depends_on "git" => :test
  uses_from_macos "zlib"

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    spr = "#{bin}/spr"
    assert_match "spr #{version}", shell_output("#{spr} --version")

    system "git", "init", "-b", "trunk", testpath/"test-repo"
    system "git", "config", "--global", "user.email", "nobody@example.com"
    system "git", "config", "--global", "user.name", "Nobody"
    cd testpath/"test-repo" do
      system "git", "config", "spr.githubMasterBranch", "trunk"

      # Some bogus config
      system "git", "config", "spr.githubRepository", "a/b"
      system "git", "config", "spr.branchPrefix", "spr/"

      # Create an empty commit, which is set to be upstream
      system "git", "commit", "--allow-empty", "--message", "Empty commit"
      mkdir ".git/refs/remotes/origin"
      system "git rev-parse HEAD >.git/refs/remotes/origin/trunk"
      system "git", "commit", "--allow-empty", "--message", <<~EOS
        Hello world

        Foo bar baz
        test plan: eyes
      EOS

      system spr, "format"

      expected = <<~EOS
        Hello world

        Foo bar baz

        Test Plan: eyes
      EOS

      assert_match expected, shell_output("git log -n 1 --format=format:%B")
    end
  end
end
