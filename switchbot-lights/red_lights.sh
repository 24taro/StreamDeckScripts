#!/bin/bash

API_TOKEN="4c9fe1d31dcba07229d811bb280e0b2a4ada6cc89167649271ec9067a6b041bb9da38c6c417b30c04a514e08d322e9ec"
DESK_LIGHT_ID="D83BDA175836"
TAPE_LIGHT_ID="48CA43C5957A"

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