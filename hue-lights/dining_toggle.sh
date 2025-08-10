#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"
source "$(dirname "$0")/light_ids.conf"

# ダイニングライトの状態を確認（最初のライトで判定）
FIRST_LIGHT=$(echo $DINING_LIGHTS | cut -d' ' -f1)
STATE=$(curl -s -X GET "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${FIRST_LIGHT}" \
    -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" | grep -o '"on":[^,]*' | cut -d':' -f2)

if [ "$STATE" == "true" ]; then
    # OFFにする
    echo "ダイニングライトをOFFにします..."
    for LIGHT_ID in $DINING_LIGHTS; do
        curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${LIGHT_ID}/state" \
            -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
            -H "Content-Type: application/json" \
            -d '{"on": false}' > /dev/null &
    done
    wait
    echo "⭕ ダイニングライトをOFFにしました"
    osascript -e 'display notification "ダイニングライトをOFFにしました" with title "💡 ダイニング OFF"' 2>/dev/null || true
else
    # ONにする
    echo "ダイニングライトをONにします..."
    for LIGHT_ID in $DINING_LIGHTS; do
        curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${LIGHT_ID}/state" \
            -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
            -H "Content-Type: application/json" \
            -d '{"on": true, "bri": 254}' > /dev/null &
    done
    wait
    echo "✅ ダイニングライトをONにしました"
    osascript -e 'display notification "ダイニングライトをONにしました" with title "💡 ダイニング ON"' 2>/dev/null || true
fi