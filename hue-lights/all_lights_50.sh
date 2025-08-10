#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"
source "$(dirname "$0")/light_ids.conf"

echo "すべてのライトを50%の明るさに設定（ベッドルーム含む）..."

# 全ライトを50%に（ベッドルーム含む）
for LIGHT_ID in $ALL_LIGHTS; do
    curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${LIGHT_ID}/state" \
        -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
        -H "Content-Type: application/json" \
        -d '{"on": true, "bri": 127}' > /dev/null &
done

wait
echo "🔅 すべてのライトを50%の明るさに設定しました"

# macOS通知
osascript -e 'display notification "すべてのライトを50%に設定" with title "💡 Hue 全ライト50%"' 2>/dev/null || true