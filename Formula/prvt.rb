class Prvt < Formula
  desc "Store end-to-end encrypted files and view them in your browser"
  homepage "https://github.com/ItalyPaleAle/prvt"
  url "https://github.com/ItalyPaleAle/prvt/archive/v0.4.2.tar.gz"
  sha256 "1c282c6c48a596f64adf0f815eb6185fdecd05e9df4b0a9fc6ab677496099c40"

  depends_on "go" => ["1.14", :build]

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
        "v0.4.2/prvt-v0.4.2-ui.tar.gz",
        "-o dist.tar.gz"
      system "tar", "-xvzf dist.tar.gz"
      rm_rf "ui/dist"
      mv "dist", "ui/dist"
      # Fetch packr (the formula on homebrew is broken)
      system "curl", "-LO",
        "https://github.com/gobuffalo/packr/releases/download/"\
        "v2.7.1/packr_2.7.1_darwin_amd64.tar.gz"
      system "tar", "-xvzf packr_2.7.1_darwin_amd64.tar.gz"
      system "packr_2.7.1_darwin_amd64/packr2"
      # Build the app
      system "go", "build", "-ldflags",
        "-X github.com/ItalyPaleAle/prvt/buildinfo.AppVersion=v0.4.2 " \
        "-X github.com/ItalyPaleAle/prvt/buildinfo.BuildID=0.4.2 " \
        "-X github.com/ItalyPaleAle/prvt/buildinfo.BuildTime=brew " \
        "-X github.com/ItalyPaleAle/prvt/buildinfo.CommitHash=v0.4.2",
        "-o", bin/"prvt", "."
    end
  end

  test do
    assert_match /v0\.4\.2/, shell_output("#{bin}/prvt version")
  end
end
