#!/bin/bash

# メッセージの表示
echo "初期化処理を開始します..."

# 失敗の限度回数
FAILED_LIMIT=2

# 接続拒否を設定する[hosts.deny]の絶対パス
HOSTS_DENY_PATH="/etc/hosts.deny"

# ログに記載されている接続に失敗したIPを記載するファイルのパス
FailedLogIpPath="FailedLogIP"

# ログに記載されている接続に失敗したIPを記載するファイルのパス
FailedIpListPath="FailedIPList"

# 接続を拒否しているIPが記載されているファイルのパス
RejectIpListPath="RejectIPList"

# 新しく書き込まれたログを洗い出すための差分ファイルを作成
cat /var/log/secure > PreSecureLog

# 各ファイルの初期化
rm -f ${FailedLogIpPath} && touch ${FailedLogIpPath}
rm -f ${FailedIpListPath} && touch ${FailedIpListPath}
rm -f ${RejectIpListPath} && touch ${RejectIpListPath}

# 以下の内容は日付による制限ができてから実装する
#########################################################################################################
## これまでに接続に失敗したことがある接続元IPの一覧を[FailedLogIP]ファイルに書き出す
#cat /var/log/secure | grep ".*sshd.*Failed.*" | rev | cut -d' ' -f4 | rev | sort > ${FailedLogIpPath}
#chmod 600 ${FailedLogIpPath}
#
## これまでに接続に失敗したことがある接続元IPの一覧を[FailedIPList]ファイルに書き出す
#cat ${FailedLogIpPath} | uniq > ${FailedIpListPath}
#chmod 600 ${FailedIpListPath}
#
## これまでに接続に失敗したことがある接続元IPの一覧を配列[srcIpList]に格納する
#srcIpList=($(cat ${FailedIpListPath} | tr -s ',' '\n'))
#
## for文で使用するループ回数
#ipListCount=$(grep -c "" ${FailedIpListPath})
#
## ssh接続の接続に失敗した回数によって、接続元IPアドレスからのsshを拒否する
#for i in $(seq ${ipListCount})
#do
#  num=$(expr $i - 1)
#  FailedCount=$(grep -c "${srcIpList[$num]}" ./FailedLogIP)
#  if [ $FailedCount -gt $FAILED_LIMIT ]; then
#    addRule="sshd : ${srcIpList[$num]}"
#    echo ${addRule} 
#    if [ -n "$(grep "${addRule}" ${HOSTS_DENY_PATH})" ]; then
#      echo "\"${addRule}\" already exists in hosts.deny"
#    else
#      echo ${addRule} >> ${HOSTS_DENY_PATH}
#    fi
#    echo "${srcIpList[$num]}" >> ${RejectIpListPath}
#  fi
#done
#########################################################################################################

# メッセージの表示
echo "初期化処理完了"
