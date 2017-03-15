#!/bin/bash

# 失敗の限度回数
FAILED_LIMIT=2

# 監視ファイル
WATCH_DIR="/var/log/secure"

# ログに記載されている接続に失敗したIPを記載するファイルのパス
FailedLogIpPath="FailedLogIP"

# ログに記載されている接続に失敗したIPを記載するファイルのパス
FailedIpListPath="FailedIPList"

# 接続を拒否しているIPが記載されているファイルのパス
RejectIpListPath="RejectIPList"

# 新しく書き込まれたログを洗い出すための差分ファイルのパス
PreSecureLogPath="PreSecureLog"

# 検索するルールを確立
rule="^DROP.*${FailedIp}.*tcp dpt:ssh"

# 新規に書き込まれたログの取得
diff ${PreSecureLogPath} ${WATCH_DIR} > temp

# 差分ファイルを更新
cat ${WATCH_DIR} > ${PreSecureLogPath}

# DEBUG
cat temp

# ssh接続失敗のログの場合、IPアドレスの抽出する
FailedSshLog=$(grep ".*sshd.*Failed.*" temp)

#echo ${FailedSshLog}

# 変数[FailedSshLog]が空文字ではない場合
if [ -n "${FailedSshLog}" ]; then

  # 出力されたログの中で、IPアドレスだけを抽出する
  FailedIp=$(echo ${FailedSshLog} | rev | cut -d' ' -f4 | rev)

  # 抽出されたログが既に拒否設定を行っている場合、その旨を表示する
  if [ -n "$(grep "${FailedIp}" ${RejectIpListPath})"  ]; then
    echo "FailedIp[${FailedIp}] already reject"

  # そうでない場合
  else

    # 抽出したアドレスをファイルに追記し、その旨を表示する
    echo ${FailedIp} >> ${FailedLogIpPath}
    echo "\"${FailedIp}\" add FailedLogIp"

    # もし、ファイルに抽出したIPアドレスが既定値をこえていた場合、
    # そのIPアドレスからの接続を遮断する設定を行う
    if [ $(grep -c "${FailedIp}" ${FailedLogIpPath}) -gt ${FAILED_LIMIT} ]; then

      # 現在のiptablesの設定を出力
      iptables -L > CurrentIptablesRule

      # iptablesに接続元を遮断するルールが追加されている場合、その旨を表示する
      if [ -n "$(grep "${rule}" CurrentIptablesRule)" ]; then
        echo "\"${rule}\" already exists in iptables"

      # そうでない場合、iptablesに追加する
      else
         iptables -I INPUT -s ${FailedIp} -p tcp --dport ssh -j DROP
      fi
      echo "${FailedIp}" >> ${RejectIpListPath}
      echo "\"${FailedIp}\" add RejectIpList"
    fi
  fi
fi
