class Spr < Formula
    desc "Submit pull requests for individual, amendable, rebaseable commits to GitHub"
    homepage "https://github.com/getcord/spr"
    url "https://github.com/getcord/spr.git",
        tag:      "v1.2.2",
        revision: "131ba055d8affcf86a8c806b8cbe139bc9416642"
    license "MIT"
  
    depends_on "rust" => :build
  
    def install
      system "cargo", "install", *std_cargo_args
    end
end
