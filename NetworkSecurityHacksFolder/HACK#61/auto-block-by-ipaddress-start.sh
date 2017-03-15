#!/bin/bash -eu
trap "exit 0" 3 # QUITシグナルで停止

WATCH_DIR="/var/log/"    # 監視するディレクトリ
FILE_PATTERN="secure" # ファイル名正規表現
COMMAND="./auto-block-by-ipaddress-exe.sh"      # ファイル更新時に実行するコマンド

# 初期化処理を行う
./auto-block-by-ipaddress-init.sh

# メッセージの出力
echo " inotifywaitによる監視を開始します"

# --formatで"ディレクトリ ファイル名 イベント"の形式で出力するように指定
inotifywait -e MODIFY -m -r ${WATCH_DIR} --format "%w %f %e" | \
while read LINE; do

  # --format指定した通りに変数に格納
  declare -a eventData=(${LINE})
  dirPath=${eventData[0]}
  fileName=${eventData[1]}

  # ファイル名パターンマッチング (マッチしなかったら無視)
  [[ $fileName =~ ${FILE_PATTERN} ]] || continue

  # (DEBUG)イベントがあったファイルを表示
  echo "${dirPath}${fileName}"

  # コマンドの実行
  ${COMMAND}

done
