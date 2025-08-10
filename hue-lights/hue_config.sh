#!/bin/bash

# 設定ファイルのパス
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

# .envファイルを読み込む
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "エラー: .envファイルが見つかりません"
    exit 1
fi

# ライトIDの設定（必要に応じて変更）
DEFAULT_LIGHT_ID="1"