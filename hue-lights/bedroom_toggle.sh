#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"
source "$(dirname "$0")/light_ids.conf"

# ベッドルームライトの状態を確認
STATE=$(curl -s -X GET "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${BEDROOM}" \
    -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" | grep -o '"on":[^,]*' | cut -d':' -f2)

if [ "$STATE" == "true" ]; then
    # OFFにする
    echo "ベッドルームのライトをOFFにします..."
    curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${BEDROOM}/state" \
        -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
        -H "Content-Type: application/json" \
        -d '{"on": false}' > /dev/null
    echo "⭕ ベッドルームのライトをOFFにしました"
    osascript -e 'display notification "ベッドルームのライトをOFFにしました" with title "🛏️ ベッドルーム OFF"' 2>/dev/null || true
else
    # ONにする
    echo "ベッドルームのライトをONにします..."
    curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${BEDROOM}/state" \
        -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
        -H "Content-Type: application/json" \
        -d '{"on": true, "bri": 200}' > /dev/null
    echo "✅ ベッドルームのライトをONにしました"
    osascript -e 'display notification "ベッドルームのライトをONにしました" with title "🛏️ ベッドルーム ON"' 2>/dev/null || true
fi