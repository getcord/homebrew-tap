class Spr < Formula
  desc "Submit pull requests for individual, amendable, rebaseable commits to GitHub"
  homepage "https://github.com/getcord/spr"
  url "https://github.com/getcord/spr/archive/refs/tags/v1.3.4.tar.gz"
  sha256 "eada48e089a7edef98a45cfa7ba8b4f31102e72c9b9fba519712b3cfb8663229"
  license "MIT"

  bottle do
    root_url "https://github.com/getcord/homebrew-tap/releases/download/spr-1.3.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, monterey:     "598fa41bf7797ec3288d3cd7473b2ae886aded00aa06b2046a0f649b99aa2c10"
    sha256 cellar: :any_skip_relocation, big_sur:      "2438b527a672e11fc1f6958824fc033869382306535901c718968c8e40650fd5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eb38573d28d5b662cde7c89eddfe7c3017a6fdbf464dd909fcbfac15d863a3bf"
  end

  depends_on "rust" => :build
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
    cd "test-repo" do
      system "git", "config", "spr.githubMasterBranch", "trunk"

      # Some bogus config
      system "git", "config", "spr.githubRepository", "a/b"
      system "git", "config", "spr.branchPrefix", "spr/"

      # Create an empty commit, which is set to be upstream
      system "git", "commit", "--allow-empty", "--message", "Empty commit"
      mkdir ".git/refs/remotes/origin"
      (testpath/"test-repo/.git/refs/remotes/origin/trunk").atomic_write Utils.git_head
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
