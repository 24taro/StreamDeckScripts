#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"
source "$(dirname "$0")/light_ids.conf"

echo "すべてのライトをOFFにします（ベッドルーム含む）..."

# 全ライトをOFF（ベッドルーム含む）
for LIGHT_ID in $ALL_LIGHTS; do
    curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${LIGHT_ID}/state" \
        -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
        -H "Content-Type: application/json" \
        -d '{"on": false}' > /dev/null &
done

wait
echo "⭕ すべてのライトをOFFにしました"

# macOS通知
osascript -e 'display notification "すべてのライトをOFFにしました" with title "💡 Hue 全ライトOFF"' 2>/dev/null || true