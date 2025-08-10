# 時報点滅システム

SwitchBotライトを使用した毎時0分の時報点滅機能

## ファイル構成

```
time-signal/
├── hourly_blink.sh         # メインの点滅スクリプト
├── streamdeck_hourly.sh    # Stream Deck用トグルスクリプト
└── test_blink.sh          # 手動テスト用
```

## Stream Deck設定

1. Stream Deckで新しいボタンを作成
2. 「System」→「Open」を選択
3. App/Fileに設定:
   ```
   /Users/nishioka/Develop/stream/time-signal/streamdeck_hourly.sh
   ```
4. タイトルを「時報」に設定

## 動作

- ボタンを押すたびにON/OFF切り替え
- 毎時0分（00:00, 01:00, 02:00...）に3回点滅
- 現在の色のまま点滅
- macOS通知でON/OFF状態をお知らせ

## テスト

手動で点滅をテストする場合:
```bash
./test_blink.sh
```