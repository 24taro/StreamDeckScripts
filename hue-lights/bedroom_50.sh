#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"
source "$(dirname "$0")/light_ids.conf"

echo "ベッドルームのライトを50%の明るさに設定..."

# ベッドルームのライトを50%に
curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${BEDROOM}/state" \
    -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
    -H "Content-Type: application/json" \
    -d '{"on": true, "bri": 127}' > /dev/null

echo "🔅 ベッドルームのライトを50%の明るさに設定しました"

# macOS通知
osascript -e 'display notification "ベッドルームのライトを50%に設定" with title "🛏️ ベッドルーム 50%"' 2>/dev/null || true