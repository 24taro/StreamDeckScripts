#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"
source "$(dirname "$0")/light_ids.conf"

# メインルーム（リビング＋ダイニング）の状態を確認
FIRST_LIGHT=$(echo $MAIN_ROOM_LIGHTS | cut -d' ' -f1)
STATE=$(curl -s -X GET "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${FIRST_LIGHT}" \
    -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" | grep -o '"on":[^,]*' | cut -d':' -f2)

if [ "$STATE" == "true" ]; then
    # OFFにする
    echo "メインルームのライトをOFFにします..."
    for LIGHT_ID in $MAIN_ROOM_LIGHTS; do
        curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${LIGHT_ID}/state" \
            -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
            -H "Content-Type: application/json" \
            -d '{"on": false}' > /dev/null &
    done
    wait
    echo "⭕ メインルームのライトをOFFにしました"
    osascript -e 'display notification "メインルームのライトをOFFにしました" with title "💡 メインルーム OFF"' 2>/dev/null || true
else
    # ONにする
    echo "メインルームのライトをONにします..."
    for LIGHT_ID in $MAIN_ROOM_LIGHTS; do
        curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${LIGHT_ID}/state" \
            -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
            -H "Content-Type: application/json" \
            -d '{"on": true, "bri": 254}' > /dev/null &
    done
    wait
    echo "✅ メインルームのライトをONにしました"
    osascript -e 'display notification "メインルームのライトをONにしました" with title "💡 メインルーム ON"' 2>/dev/null || true
fi