# SwitchBot ライト制御スクリプト

Stream Deck用のSwitchBotライト制御スクリプト集

## デバイス構成

- **デスクライト**: SwitchBot RGB電球
- **テープライト**: SwitchBot LEDテープライト

## ファイル構成

```
switchbot-lights/
├── lights_on.sh          # ライトON（白色）
├── lights_off.sh         # ライトOFF
├── lights_toggle.sh      # ON/OFF切り替え
│
├── red_lights.sh         # 赤色
├── blue_lights.sh        # 青色
├── green_lights.sh       # 緑色
├── yellow_lights.sh      # 黄色
├── pink_lights.sh        # ピンク色
├── warm_white_lights.sh  # ウォームホワイト
└── cool_white_lights.sh  # クールホワイト
```

## Stream Deck設定

### 基本制御
**ON/OFF切り替え（推奨）**
```
/Users/nishioka/Develop/stream/switchbot-lights/lights_toggle.sh
```

**ライトON**
```
/Users/nishioka/Develop/stream/switchbot-lights/lights_on.sh
```

**ライトOFF**
```
/Users/nishioka/Develop/stream/switchbot-lights/lights_off.sh
```

### 色設定
各色のスクリプトをStream Deckボタンに割り当て：
- **赤**: `red_lights.sh`
- **青**: `blue_lights.sh`
- **緑**: `green_lights.sh`
- **黄**: `yellow_lights.sh`
- **ピンク**: `pink_lights.sh`
- **ウォームホワイト**: `warm_white_lights.sh`
- **クールホワイト**: `cool_white_lights.sh`

## 機能

- デスクライトとテープライトを同時制御
- macOS通知機能付き（操作後に通知表示）
- 並列処理で高速実行

## 通知アイコン

- 💡 ON
- ⭕ OFF
- 🔴 赤
- 🔵 青
- 🟢 緑
- 🟡 黄
- 🩷 ピンク
- 🟠 ウォームホワイト
- ⚪ クールホワイト

## 使用方法

### コマンドライン
```bash
# ON/OFF切り替え
./lights_toggle.sh

# 特定の色に設定
./red_lights.sh
./blue_lights.sh
# など
```

### Stream Deck
1. Stream Deckで新しいボタンを作成
2. 「System」→「Open」を選択
3. App/Fileに上記のパスを設定
4. アイコンとタイトルを設定

## API情報

SwitchBot API v1.1を使用
- エンドポイント: `https://api.switch-bot.com/v1.1/`
- 認証: Bearer Token