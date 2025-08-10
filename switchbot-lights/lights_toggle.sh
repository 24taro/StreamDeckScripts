#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
fi

API_TOKEN="${SWITCHBOT_API_TOKEN}"
DESK_LIGHT_ID="${DESK_LIGHT_ID}"
TAPE_LIGHT_ID="${TAPE_LIGHT_ID}"

# 現在の状態を取得（デスクライトの状態で判定）
STATE=$(curl -s -X GET "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/status" \
    -H "Authorization: Bearer $API_TOKEN" | grep -o '"power":"[^"]*"' | cut -d'"' -f4)

if [ "$STATE" == "on" ]; then
    # OFFにする
    echo "ライトをOFFにしています..."
    
    curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/commands" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"command": "turnOff"}' &
    
    curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${TAPE_LIGHT_ID}/commands" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"command": "turnOff"}' &
    
    wait
    echo "両方のライトをOFFにしました"
    
    # macOS通知
    osascript -e 'display notification "ライトをOFFにしました" with title "⭕ SwitchBot OFF"' 2>/dev/null || true
else
    # ONにする
    echo "ライトをONにしています..."
    
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
fi