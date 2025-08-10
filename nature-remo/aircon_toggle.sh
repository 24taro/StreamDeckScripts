#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
fi

API_URL="https://api.nature.global/1"

echo "エアコンの状態を確認中..."

CURRENT_STATE=$(curl -s -X GET "${API_URL}/appliances" \
    -H "Authorization: Bearer ${NATURE_TOKEN}" | \
    jq -r '.[] | select(.id == "'${AIRCON_ID}'") | .settings.button')

if [ "$CURRENT_STATE" == "power-off" ]; then
    echo "エアコンをONにしています..."
    
    RESPONSE=$(curl -s -X POST "${API_URL}/appliances/${AIRCON_ID}/aircon_settings" \
        -H "Authorization: Bearer ${NATURE_TOKEN}" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "button=power-on")
    
    echo "エアコンをONにしました"
    
    osascript -e 'display notification "エアコンをONにしました" with title "🌡️ Nature Remo エアコンON"' 2>/dev/null || true
else
    echo "エアコンをOFFにしています..."
    
    RESPONSE=$(curl -s -X POST "${API_URL}/appliances/${AIRCON_ID}/aircon_settings" \
        -H "Authorization: Bearer ${NATURE_TOKEN}" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "button=power-off")
    
    echo "エアコンをOFFにしました"
    
    osascript -e 'display notification "エアコンをOFFにしました" with title "❄️ Nature Remo エアコンOFF"' 2>/dev/null || true
fi