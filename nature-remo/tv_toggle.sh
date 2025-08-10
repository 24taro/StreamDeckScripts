#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
    source "$SCRIPT_DIR/.env"
fi

API_URL="https://api.nature.global/1"

echo "テレビの電源を切り替えています..."

RESPONSE=$(curl -s -X POST "${API_URL}/appliances/${TV_ID}/tv" \
    -H "Authorization: Bearer ${NATURE_TOKEN}" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "button=power")

echo "テレビの電源を切り替えました"

osascript -e 'display notification "テレビの電源を切り替えました" with title "📺 Nature Remo テレビ"' 2>/dev/null || true