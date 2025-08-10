#!/bin/bash

# Stream Deck用時報トグルスクリプト

SCRIPT_DIR="/Users/nishioka/Develop/stream/time-signal"

# cron設定の有無を確認
CRON_EXISTS=$(crontab -l 2>/dev/null | grep -c "hourly_blink.sh")

if [ "$CRON_EXISTS" -eq 0 ]; then
    # ONにする
    CRON_TEMP=$(mktemp)
    crontab -l 2>/dev/null > "$CRON_TEMP" || true
    echo "0 * * * * $SCRIPT_DIR/hourly_blink.sh" >> "$CRON_TEMP"
    crontab "$CRON_TEMP"
    rm "$CRON_TEMP"
    
    # デスクトップ通知
    osascript -e 'display notification "毎時0分に点滅します" with title "⏰ 時報点滅 ON" sound name "Glass"' 2>/dev/null || true
else
    # OFFにする
    CRON_TEMP=$(mktemp)
    crontab -l 2>/dev/null | grep -v "hourly_blink.sh" > "$CRON_TEMP"
    crontab "$CRON_TEMP"
    rm "$CRON_TEMP"
    
    # デスクトップ通知
    osascript -e 'display notification "時報点滅を停止しました" with title "⏸️ 時報点滅 OFF"' 2>/dev/null || true
fi