#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
fi

API_TOKEN="${SWITCHBOT_API_TOKEN}"
DESK_LIGHT_ID="${DESK_LIGHT_ID}"
TAPE_LIGHT_ID="${TAPE_LIGHT_ID}"

echo "ライトを赤色に設定中..."

# デスクライトを赤色に（オンにしてから色変更）
curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "turnOn"}' &

curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "setColor", "parameter": "255:0:0"}' &

# テープライトを赤色に（オンにしてから色変更）
curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${TAPE_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "turnOn"}' &

curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${TAPE_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "setColor", "parameter": "255:0:0"}' &

wait
echo "両方のライトを赤色にしました"

# macOS通知
osascript -e 'display notification "ライトを赤色に設定しました" with title "🔴 SwitchBot 赤"' 2>/dev/null || true