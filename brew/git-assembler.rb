class GitAssembler < Formula
  include Language::Python::Virtualenv

  desc "update git branches using high-level instructions"
  homepage "https://gitlab.com/wavexx/git-assembler"
  url "https://github.com/ErichDonGubler/git-assembler"
  version "1.4"
  sha256 "6b2ca9bd95e3e29b622e409dfcf229f1ac3f84c9469feb5f3011c0237afac013"
  license "GPL-3.0"

  depends_on "git"
  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/git-assembler", "--version"
  end
end
