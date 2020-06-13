require "language/node"

class Hereditas < Formula
  desc "Static site generator for a fully trustless digital legacy box "
  homepage "https://hereditas.app"
  url "https://registry.npmjs.org/hereditas/-/hereditas-0.2.1.tgz"
  sha256 "e1e1cb375dc55b1e04220b2c2082bf9fc5b257fc8ea11e7db7edfd01afe7f71a"

  depends_on "node" => ["10"]

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match /hereditas\/0\.2\.1/, shell_output("#{bin}/hereditas --version")
  end
end