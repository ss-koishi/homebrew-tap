# Homebrew Cask のテンプレート。
# .github/workflows/release.yml が @@...@@ を埋めて
# ss-koishi/homebrew-tap の Casks/ へ push する。手で編集するならこちら側を直すこと。
cask "docker-sandbox-launcher" do
  version "0.1.1"
  sha256 "6e164bdd4f9fb124591b1784131db9993202127dec9bab3b139daf366247f479"

  url "https://github.com/ss-koishi/docker-sandbox-launcher/releases/download/v#{version}/Docker.Sandbox.Launcher_#{version}_universal.dmg"
  name "Docker Sandbox Launcher"
  desc "GUI launcher for Docker Sandboxes (sbx)"
  homepage "https://github.com/ss-koishi/docker-sandbox-launcher"

  depends_on macos: ">= :big_sur"

  app "Docker Sandbox Launcher.app"

  # Developer ID 署名も公証もしていないため、そのままでは Gatekeeper に
  # 「壊れているため開けません」と弾かれる。quarantine 属性を外しておく。
  # 署名・公証を入れたらこのブロックごと削除してよい。
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Docker Sandbox Launcher.app"]
  end

  caveats <<~EOS
    このアプリは Docker Sandboxes の sbx CLI を呼び出します。未導入なら:

      brew install --cask docker/tap/sbx

    Developer ID 署名・公証は行っていないため、インストール時に quarantine 属性を外しています。
  EOS

  zap trash: [
    "~/Library/Application Support/dev.ss-koishi.docker-sandbox-launcher",
    "~/Library/Caches/dev.ss-koishi.docker-sandbox-launcher",
    "~/Library/HTTPStorages/dev.ss-koishi.docker-sandbox-launcher",
    "~/Library/Saved Application State/dev.ss-koishi.docker-sandbox-launcher.savedState",
    "~/Library/WebKit/dev.ss-koishi.docker-sandbox-launcher",
  ]
end
