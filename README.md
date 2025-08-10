# Stream Deck Control Scripts

Stream Deck用のスマートホーム制御スクリプト集

## プロジェクト構成

```
stream/
├── switchbot-lights/   # SwitchBotライト制御
├── hue-lights/         # Philips Hueライト制御
├── nature-remo/        # Nature Remo家電制御
└── time-signal/        # 時報（毎時点滅）
```

## 各ディレクトリの機能

### 🔦 switchbot-lights
SwitchBot RGB電球の制御
- デスクライト・テープライトの同時制御
- 色変更（赤、青、緑、黄、ピンク、白）
- ON/OFF/トグル
- macOS通知対応

### 💡 hue-lights
Philips Hueライトの制御
- リビング・ダイニング統合制御（メインルーム）
- ベッドルーム個別制御
- 明るさ調整
- ON/OFF/トグル
- macOS通知対応

### 🏠 nature-remo
Nature Remo経由の家電制御
- エアコンON/OFF（Daikin）
- テレビON/OFF（アイリスオーヤマ）
- 状態自動判定
- macOS通知対応

### ⏰ time-signal
毎時0分の時報機能
- SwitchBotライトを3回点滅
- cron自動設定/解除
- Stream Deckボタンで有効/無効切り替え

## セットアップ

1. 各ディレクトリの`.env`ファイルにAPIトークンを設定
2. スクリプトに実行権限を付与
3. Stream Deckの「System」→「Open」でスクリプトパスを設定

## セキュリティ

- `.env`ファイルは`.gitignore`に含まれています
- APIトークンは環境変数として管理
- プライベートリポジトリとして管理

## 必要条件

- macOS
- Stream Deck
- jq（JSONパーサー）
- curl

## ライセンス

Private Repository - All Rights Reserved