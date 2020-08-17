class Prvt < Formula
  desc "Store end-to-end encrypted files and view them in your browser"
  homepage "https://github.com/ItalyPaleAle/prvt"
  url "https://github.com/ItalyPaleAle/prvt/archive/v0.5.0-beta.3.tar.gz"
  sha256 "16e4da3eb38cfdf4894b43f88e72b797b14c1a44595ca71d261a3f2c5f042761"

  depends_on "go" => ["1.15", :build]

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"
    ENV["CGO_ENABLED"] = "0"
    ENV["PATH"] = "#{ENV["PATH"]}:#{buildpath}/bin"
    (buildpath/"src/github.com/ItalyPaleAle/prvt").install buildpath.children
    cd "src/github.com/ItalyPaleAle/prvt" do
      # Fetch the UI
      system "curl", "-L",
        "https://github.com/ItalyPaleAle/prvt/releases/download/" \
        "v0.5.0-beta.3/prvt-v0.5.0-beta.3-ui.tar.gz",
        "-o dist.tar.gz"
      system "tar", "-xvzf dist.tar.gz"
      rm_rf "ui/dist"
      mv "dist", "ui/dist"
      # Fetch packr (the formula on homebrew is broken)
      system "curl", "-L",
        "https://github.com/gobuffalo/packr/releases/download/" \
        "v2.7.1/packr_2.7.1_darwin_amd64.tar.gz",
        "-o packr.tar.gz"
      system "tar", "-xvzf packr.tar.gz", "packr2"
      system "./packr2"
      # Build the app
      system "go", "build", "-ldflags",
        "-X github.com/ItalyPaleAle/prvt/buildinfo.AppVersion=v0.5.0-beta.3 " \
        "-X github.com/ItalyPaleAle/prvt/buildinfo.BuildID=0.5.0-beta.3 " \
        "-X github.com/ItalyPaleAle/prvt/buildinfo.BuildTime=brew " \
        "-X github.com/ItalyPaleAle/prvt/buildinfo.CommitHash=v0.5.0-beta.3",
        "-o", bin/"prvt", "."
    end
  end

  test do
    assert_match /v0\.5\.0/, shell_output("#{bin}/prvt version")
  end
end
