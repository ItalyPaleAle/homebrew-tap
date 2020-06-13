class Prvt < Formula
  desc "Store end-to-end encrypted files and view them in your browser "
  homepage "https://github.com/ItalyPaleAle/prvt"
  url "https://github.com/ItalyPaleAle/prvt/archive/v0.4.1.tar.gz"
  sha256 "3e9ecefff72bba5f7f7834f442bdd9b6ee953306bbbf0f4bd1ecccaf7af9b09b"

  depends_on "go" => ["1.14", :build]

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    ENV["CGO_ENABLED"] = "0"
    ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
    (buildpath/"src/github.com/ItalyPaleAle/prvt").install buildpath.children
    cd "src/github.com/ItalyPaleAle/prvt" do
      system "go", "build", "-ldflags",
        "-X github.com/ItalyPaleAle/prvt/buildinfo.AppVersion=v0.4.1 " \
        "-X github.com/ItalyPaleAle/prvt/buildinfo.BuildID=0.4.1 " \
        "-X github.com/ItalyPaleAle/prvt/buildinfo.BuildTime=brew",
        "-X github.com/ItalyPaleAle/prvt/buildinfo.CommitHash=v0.4.1",
        "-o", bin/"prvt", "."
    end
  end

  test do
    assert_match /v0\.4\.1/, shell_output("#{bin}/prvt version")
  end
end
