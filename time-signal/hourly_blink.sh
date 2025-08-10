#!/bin/bash

# SwitchBot API設定
API_TOKEN="4c9fe1d31dcba07229d811bb280e0b2a4ada6cc89167649271ec9067a6b041bb9da38c6c417b30c04a514e08d322e9ec"
DESK_LIGHT_ID="D83BDA175836"
TAPE_LIGHT_ID="48CA43C5957A"


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