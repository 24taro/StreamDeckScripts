#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"
source "$(dirname "$0")/light_ids.conf"

echo "メインルームのライトを50%の明るさに設定..."

# メインルームのライトを50%に
for LIGHT_ID in $MAIN_ROOM_LIGHTS; do
    curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${LIGHT_ID}/state" \
        -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
        -H "Content-Type: application/json" \
        -d '{"on": true, "bri": 127}' > /dev/null &
done

wait
echo "🔅 メインルームのライトを50%の明るさに設定しました"

# macOS通知
osascript -e 'display notification "メインルームのライトを50%に設定" with title "💡 メインルーム 50%"' 2>/dev/null || true