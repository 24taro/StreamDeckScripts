#!/bin/bash

# SwitchBot API設定
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SWITCHBOT_DIR="$(dirname "$SCRIPT_DIR")/switchbot-lights"

if [ -f "$SWITCHBOT_DIR/.env" ]; then
    source "$SWITCHBOT_DIR/.env"
fi

API_TOKEN="${SWITCHBOT_API_TOKEN}"
DESK_LIGHT_ID="${DESK_LIGHT_ID}"
TAPE_LIGHT_ID="${TAPE_LIGHT_ID}"


# 点滅パターン（3回点滅 - 現在の色のまま）
for i in {1..3}; do
    # ライトをオフ
    curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/commands" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"command": "turnOff"}' &
    
    curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${TAPE_LIGHT_ID}/commands" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"command": "turnOff"}' &
    
    wait
    sleep 0.5
    
    # ライトをオン（色は変更しない）
    curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/commands" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"command": "turnOn"}' &
    
    curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${TAPE_LIGHT_ID}/commands" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"command": "turnOn"}' &
    
    wait
    sleep 0.5
done

# ライトをオンのままにする（最後の点滅後）
curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${DESK_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "turnOn"}' &

curl -s -X POST "https://api.switch-bot.com/v1.1/devices/${TAPE_LIGHT_ID}/commands" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json" \
    -d '{"command": "turnOn"}' &

wait