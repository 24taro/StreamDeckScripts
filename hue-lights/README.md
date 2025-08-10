# Philips Hue ライト制御スクリプト

Stream Deck用のPhilips Hueライト制御スクリプト集

## ライト構成

```
ID 3: リビング右      (Color temperature light)
ID 4: リビング左      (Color temperature light)
ID 5: ベッド         (Color temperature light)
ID 6: リビング中      (Color temperature light)
ID 7: ダイニング右中   (Dimmable light)
ID 8: ダイニング左中   (Dimmable light)
ID 9: ダイニング左端   (Dimmable light)
ID 10: ダイニング右端  (Dimmable light)
```

## ファイル構成

```
hue-lights/
├── .env                    # 認証情報（非公開）
├── light_ids.conf         # ライトID設定
├── hue_config.sh          # 共通設定
│
├── all_lights_on.sh       # 全ライトON（ベッドルーム含む）
├── all_lights_off.sh      # 全ライトOFF（ベッドルーム含む）
├── all_lights_50.sh       # 全ライト50%（ベッドルーム含む）
│
├── main_room_toggle.sh    # メインルームON/OFF（リビング＋ダイニング）
├── main_room_50.sh        # メインルーム50%
├── bedroom_toggle.sh      # ベッドルームON/OFF
├── bedroom_50.sh          # ベッドルーム50%
│
├── living_toggle.sh       # リビングのみON/OFF
├── dining_toggle.sh       # ダイニングのみON/OFF
│
├── lights_on.sh          # 個別ライトON
├── lights_off.sh         # 個別ライトOFF
├── lights_50.sh          # 個別ライト50%
│
└── list_lights.sh        # ライト状態一覧表示
```

## Stream Deck設定

### 全体制御
1. Stream Deckで新しいボタンを作成
2. 「System」→「Open」を選択
3. App/Fileに設定:

**全ライトON**
```
/Users/nishioka/Develop/stream/hue-lights/all_lights_on.sh
```

**全ライトOFF**
```
/Users/nishioka/Develop/stream/hue-lights/all_lights_off.sh
```

**全ライト50%**
```
/Users/nishioka/Develop/stream/hue-lights/all_lights_50.sh
```

### グループ制御

**メインルーム切り替え（リビング＋ダイニング）**
```
/Users/nishioka/Develop/stream/hue-lights/main_room_toggle.sh
```

**メインルーム50%**
```
/Users/nishioka/Develop/stream/hue-lights/main_room_50.sh
```

**ベッドルーム切り替え**
```
/Users/nishioka/Develop/stream/hue-lights/bedroom_toggle.sh
```

**ベッドルーム50%**
```
/Users/nishioka/Develop/stream/hue-lights/bedroom_50.sh
```

## コマンドライン使用方法

### 全体制御
```bash
# 全ライトON
./all_lights_on.sh

# 全ライトOFF
./all_lights_off.sh

# 全ライト50%
./all_lights_50.sh

# ライト状態確認
./list_lights.sh
```

### グループ制御
```bash
# メインルーム（リビング＋ダイニング）切り替え
./main_room_toggle.sh

# メインルーム50%
./main_room_50.sh

# ベッドルーム切り替え
./bedroom_toggle.sh

# ベッドルーム50%
./bedroom_50.sh

# 個別エリア制御（旧機能）
./living_toggle.sh   # リビングのみ
./dining_toggle.sh   # ダイニングのみ
```

### 個別ライト制御
```bash
# ライトID 3をON
./lights_on.sh 3

# ライトID 4をOFF
./lights_off.sh 4

# ライトID 6を50%に
./lights_50.sh 6
```

## グループ設定

`light_ids.conf`でグループを定義：
- **ALL_LIGHTS**: 全8灯（ベッドルーム含む）
- **MAIN_ROOM_LIGHTS**: メインルーム7灯（リビング＋ダイニング）
- **BEDROOM_LIGHTS**: ベッドルーム1灯（ID: 5）
- **LIVING_LIGHTS**: リビング3灯（ID: 3, 4, 6）
- **DINING_LIGHTS**: ダイニング4灯（ID: 7, 8, 9, 10）

## トークン有効期限

- **Access Token**: 約7日間
- **Refresh Token**: 約730日間

トークンの更新が必要な場合は`.env`ファイルを更新してください。

## 注意事項

- `.env`ファイルには認証情報が含まれているため、Gitにコミットしないでください
- macOS通知機能付き（ON/OFF時に通知）
- ベッドルーム（ID: 5）は現在未接続の可能性がありますが、スクリプトには含まれています
- メインルーム = リビング＋ダイニング（日常使用で最も便利）