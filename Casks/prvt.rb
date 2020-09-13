cask "prvt" do
  version "0.5.1"
  sha256 "de507030ce2f8f941303b29339bb797df203ff9bebca11150fee1a80ad0d603c"

  url "https://github.com/ItalyPaleAle/prvt/releases/download/v#{version}/prvt-v#{version}-macos.tar.gz"
  appcast "https://github.com/ItalyPaleAle/prvt/releases.atom"
  name "prvt"
  desc "Store end-to-end encrypted files and view them in your browser"
  homepage "https://github.com/ItalyPaleAle/prvt"

  depends_on macos: ">= :sierra"

  binary "prvt-v#{version}-macos/prvt"

  # Remove the quarantine because the binary isn't signed
  preflight do
    system_command "/usr/bin/xattr",
                   args: [
                     "-dr",
                     "com.apple.quarantine",
                     "#{staged_path}/prvt-v#{version}-macos/prvt"
                   ]
  end
end
