#!/bin/bash

# 設定を読み込む
source "$(dirname "$0")/hue_config.sh"
source "$(dirname "$0")/light_ids.conf"

echo "======================================"
echo "   Philips Hue ライト状態一覧"
echo "======================================"

# 各ライトの状態を取得
response=$(curl -s -X GET "${HUE_BASE_URL}/${HUE_USERNAME}/lights" \
    -H "Authorization: Bearer ${HUE_ACCESS_TOKEN}")

# jqがある場合は整形表示
if command -v jq &> /dev/null; then
    echo "$response" | jq -r 'to_entries | .[] | 
        "ID: \(.key) | \(.value.name) | " +
        if .value.state.on then "🔆 ON" else "⭕ OFF" end +
        " | 明るさ: \(.value.state.bri // "-")/254" +
        if .value.state.reachable == false then " (未接続)" else "" end'
else
    # jqがない場合は簡易表示
    echo "ID 3: リビング右"
    echo "ID 4: リビング左"
    echo "ID 5: ベッド"
    echo "ID 6: リビング中"
    echo "ID 7: ダイニング右中"
    echo "ID 8: ダイニング左中"
    echo "ID 9: ダイニング左端"
    echo "ID 10: ダイニング右端"
    echo ""
    echo "詳細を見るには jq をインストールしてください: brew install jq"
fi

echo "======================================"