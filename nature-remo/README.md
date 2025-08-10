# Nature Remo 制御スクリプト

Stream Deck用のNature Remo制御スクリプト集

## デバイス構成

- **Nature Remo mini**: 赤外線リモコン送信デバイス
- **エアコン**: Daikin製エアコン
- **テレビ**: アイリスオーヤマ製テレビ

## ファイル構成

```
nature-remo/
├── .env                # 認証情報（APIトークン、デバイスID）
├── aircon_toggle.sh    # エアコンON/OFF切り替え
└── tv_toggle.sh        # テレビ電源切り替え
```

## Stream Deck設定

### エアコン制御
```
/Users/nishioka/Develop/stream/nature-remo/aircon_toggle.sh
```
- 現在の状態を自動判定してON/OFF切り替え
- macOS通知付き

### テレビ制御
```
/Users/nishioka/Develop/stream/nature-remo/tv_toggle.sh
```
- 電源ボタンでON/OFF切り替え
- macOS通知付き

## 機能

- Nature Remo Cloud API v1使用
- 認証トークンベース
- 状態自動判定（エアコンのみ）
- macOS通知機能付き

## 通知アイコン

- 🌡️ エアコンON
- ❄️ エアコンOFF
- 📺 テレビ

## 使用方法

### コマンドライン
```bash
# エアコンON/OFF切り替え
./aircon_toggle.sh

# テレビ電源切り替え
./tv_toggle.sh
```

### Stream Deck
1. Stream Deckで新しいボタンを作成
2. 「System」→「Open」を選択
3. App/Fileに上記のパスを設定
4. アイコンとタイトルを設定

## API情報

Nature Remo Cloud API v1を使用
- エンドポイント: `https://api.nature.global/1/`
- 認証: Bearer Token
- レート制限: 5分間に30リクエストまで

## 注意事項

- `.env`ファイルにAPIトークンが含まれているため、取り扱いに注意してください
- エアコンは現在の設定のままON/OFFが切り替わります
- テレビは電源トグルのみ（チャンネルや音量制御は別途スクリプト作成可能）