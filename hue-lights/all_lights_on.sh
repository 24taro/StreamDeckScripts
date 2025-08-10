#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"
source "$(dirname "$0")/light_ids.conf"

echo "すべてのライトをONにします（ベッドルーム含む）..."

# 全ライトをON（ベッドルーム含む）
for LIGHT_ID in $ALL_LIGHTS; do
    curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${LIGHT_ID}/state" \
        -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
        -H "Content-Type: application/json" \
        -d '{"on": true, "bri": 254}' > /dev/null &
done

wait
echo "✅ すべてのライトをONにしました"

# macOS通知
osascript -e 'display notification "すべてのライトをONにしました" with title "💡 Hue 全ライトON"' 2>/dev/null || true