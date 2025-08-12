#!/bin/bash
# Tailscale Pingループスクリプト (UTF-8で保存)

# デバイス一覧を表示するのじゃ。見やすいようにタブで区切ってやる。
echo "========================================"
echo " Tailscaleデバイス一覧じゃ"
echo "========================================"
sudo tailscale status | awk '{print $1, "\t", $2}'
echo "========================================"
echo

# ユーザーにIPアドレスを入力させるのじゃ
read -p "Pingを送るデバイスのIPアドレスを入力せい: " target_ip

# 入力が空っぽじゃないか、一応確認してやるぞ
if [ -z "$target_ip" ]; then
    echo "IPアドレスが入力されておらんではないか。やり直せ！"
    exit 1
fi

echo
echo "------------------------------------------------------------"
echo "[$target_ip] に1秒おきにpingを送信するぞ。"
echo "止めたければ Ctrl+C を押すがよい。"
echo "------------------------------------------------------------"

# Ctrl+C で中断されるまで、永遠にpingを送り続けるのじゃ
# trap 'echo -e "\n\nPingを中断したぞ。"; exit 0' INT
while true; do
    # tailscale pingを実行する。時刻も表示してやろうかの。
    echo "[$(date +'%T')] "
    sudo tailscale ping "$target_ip" | grep -E 'pong|timeout'
    sleep 1
done


