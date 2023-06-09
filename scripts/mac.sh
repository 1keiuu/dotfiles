#!/bin/bash

# c.f. https://qiita.com/ryuichi1208/items/5905240f3bfce793b33d

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS"
	exit 1
fi

# ====================
#
# Base
#
# ====================

# スタンバイまでの時間を24時間へ変更 (デフォルト1時間)
sudo pmset -a standbydelay 86400

# ブート時のサウンドの無効化 (寂しい気もしますが煩いので消しています)
sudo nvram SystemAudioVolume=" "

# スクロールバーの常時表示
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# コンソールアプリケーションの画面サイズ変更を高速にする
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# フリーズすると自動的に再起動
sudo systemsetup -setrestartfreeze on

# スリープさせない
sudo systemsetup -setcomputersleep Off > /dev/null

# 自動大文字の無効化
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# クラッシュレポートの無効化
defaults write com.apple.CrashReporter DialogType -string "none"

# 時計アイコンクリック時にOSやホスト名ipを表示する
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Bluetoothヘッドフォン/ヘッドセットの音質を向上させる
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# ====================
#
# Dock
#
# ====================

# Dockの位置を右に変更
defaults write com.apple.dock orientation right

# window効果の最大/最小を変更
defaults write com.apple.dock mineffect -string "scale"

# Dockで開いているアプリケーションのインジケータライトを表示する
defaults write com.apple.dock show-process-indicators -bool true

# 開いているアプリケーションのみをdockに表示
defaults write com.apple.dock static-only -bool true

# アプリケーション起動時のアニメーションを無効化
defaults write com.apple.dock launchanim -bool false

# すべての（デフォルトの）アプリアイコンをDockから消去する
defaults write com.apple.dock persistent-apps -array

# Dashboard無効化
defaults write com.apple.dashboard mcx-disabled -bool true

# ====================
#
# Finder
#
# ====================

# アニメーションを無効化する
defaults write com.apple.finder DisableAllAnimations -bool true

# デフォルトで隠しファイルを表示する
defaults write com.apple.finder AppleShowAllFiles -bool true

# 全ての拡張子のファイルを表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# ステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true

# パスバーを表示
defaults write com.apple.finder ShowPathbar -bool true

# 名前で並べ替えを選択時にディレクトリを前に置くようにする
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# 検索時にデフォルトでカレントディレクトリを検索
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# 拡張子変更時の警告を無効化
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# ディレクトリのスプリングロードを有効化
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# スプリングロード遅延を除去
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# USBやネットワークストレージに.DS_Storeファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ディスク検証を無効化
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# ボリュームマウント時に自動的にFinderを表示
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# ゴミ箱を空にする前の警告の無効化
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# ====================
#
# SystemUIServer
#
# ====================

# Display date, day, and time in the menu bar
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm'

# Display battery level in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# change caps lock → control
# c.f. https://hatappi.blog/entry/2018/11/29/215118
# c.f. https://baqamore.hatenablog.com/entry/2017/01/27/200044
# NOTE: grepの結果が2件ひっかかるので -m 1 で1件目だけを取得
vid=$(ioreg -r -n 'Apple Internal Keyboard / Trackpad' | grep -E 'idVendor' -m 1 | awk '{ print $4 }')
pid=$(ioreg -r -n 'Apple Internal Keyboard / Trackpad' | grep -E 'idProduct' -m 1 | awk '{ print $4 }')
keyboard_id=${vid}-${pid}-0

defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add '
<dict>
  <key>HIDKeyboardModifierMappingDst</key>
  <integer>30064771296</integer>
  <key>HIDKeyboardModifierMappingSrc</key>
  <integer>30064771129</integer>
</dict>
'

for app in "Dock" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done