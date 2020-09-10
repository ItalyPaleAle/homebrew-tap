cask "prvt" do
  version "0.5.0"
  sha256 "a7eff5105fe8e8414cbfb2198109f8e4e8cec0e056fe8208cea0dc750e5632ae"

  url "https://github.com/ItalyPaleAle/prvt/releases/download/v#{version}/prvt-v#{version}-macos.tar.gz"
  appcast "https://github.com/ItalyPaleAle/prvt/releases.atom"
  name "prvt"
  desc "Store end-to-end encrypted files and view them in your browser"
  homepage "https://github.com/ItalyPaleAle/prvt"

  depends_on macos: ">= :sierra"

  binary "prvt-v#{version}-macos/prvt"

  # Remove the quarantine because the binary isn't signed
  preflight do
    system_command "xattr",
                   args: [
                           "-dr", "com.apple.quarantine",
                           "#{staged_path}/prvt-v#{version}-macos/prvt"
                         ]
  end
end
