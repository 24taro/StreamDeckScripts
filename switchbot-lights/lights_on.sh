#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
fi

API_TOKEN="${SWITCHBOT_API_TOKEN}"
DESK_LIGHT_ID="${DESK_LIGHT_ID}"
TAPE_LIGHT_ID="${TAPE_LIGHT_ID}"

echo "ライトをONにしています..."

# 両方のライトをオン（デフォルトの白色）
curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "turnOn"}' &

curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${TAPE_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "turnOn"}' &

wait
echo "両方のライトをONにしました"

# macOS通知
osascript -e 'display notification "ライトをONにしました" with title "💡 SwitchBot ON"' 2>/dev/null || true