#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"

# ライトIDを引数から取得（なければデフォルト）
LIGHT_ID="${1:-$DEFAULT_LIGHT_ID}"

# ライトをONにする
response=$(curl -s -X PUT "${HUE_BASE_URL}/${HUE_USERNAME}/lights/${LIGHT_ID}/state" \
    -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}" \
    -H "Content-Type: application/json" \
    -d '{"on": true, "bri": 254}')

# 結果を確認
if echo "$response" | grep -q "success"; then
    echo "✅ ライト${LIGHT_ID}をONにしました"
    # macOS通知
    osascript -e "display notification \"ライト${LIGHT_ID}をONにしました\" with title \"💡 Hue ライト ON\"" 2>/dev/null || true
else
    echo "❌ エラー: $response"
fi