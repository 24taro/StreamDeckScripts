#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
fi

API_TOKEN="${SWITCHBOT_API_TOKEN}"
DESK_LIGHT_ID="${DESK_LIGHT_ID}"
TAPE_LIGHT_ID="${TAPE_LIGHT_ID}"

echo "ライトを暖色系白色に設定中..."

# デスクライト（Color Bulb）を暖色系白色に（色温度指定）
curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "turnOn"}' &

curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "setColorTemperature", "parameter": "3000"}' &

# テープライト（Strip Light）を暖色系白色に（RGB指定）
curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${TAPE_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "turnOn"}' &

curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${TAPE_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "setColor", "parameter": "255:220:180"}' &

wait
echo "両方のライトを暖色系白色にしました"
# macOS通知
osascript -e 'display notification "ライトをウォームホワイトに設定しました" with title "🟠 SwitchBot ウォームホワイト"' 2>/dev/null || true
