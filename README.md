# AviUtl2 グラデーション+
sRGB 以外の色空間 (Linear sRGB, HSV, HSL, L\*a\*b\*, LCh, Oklab, Oklch) でグラデーションさせる [AviUtl2](https://spring-fragrance.mints.ne.jp/aviutl/) 用スクリプトです。

![GradientPlus](assets/gradient_plus.png)

## 動作環境

- [AviUtl ExEdit2](https://spring-fragrance.mints.ne.jp/aviutl/)
<br>beta 27 で動作確認済み。

## 導入方法
1. [Release](https://github.com/azurite581/AviUtl2-GradientPlus/releases) から zip ファイルをダウンロードしてください。
2. zip ファイルを展開し、`グラデーション+.anm2` を `C:\ProgramData\aviutl2\Script` フォルダか一層下にあるフォルダに入れてください。本体に D&D することでも導入できます。

## 使い方
グラデーションをかけたいオブジェクトに `グラデーション+` を適用してください。デフォルトでは `色調整` カテゴリの中にあります。

## パラメーター

### トラックバー
- #### 中心 X
  中心点から X 方向へのオフセット値。

- #### 中心 Y
  中心点から Y 方向へのオフセット値。

- #### 角度
  グラデーションの角度。

- #### 幅
  グラデーションの幅。

### 設定ダイアログ
- #### 強さ
  グラデーションの適用度。

- #### 合成モード
  合成モードを指定します。項目は標準グラデーションと同じです。

- #### 形状
  グラデーションの形状を指定します。標準グラデーションの形状のほか、`角丸短形`、`円形ループ`、`短形ループ`、`凸形ループ`、`角丸短形ループ` が選択できます。

- #### 色空間
    グラデーションの色空間を指定します。
  名称 | 簡単な説明 |
  :---|:---|
  | `sRGB` |標準グラデーションと同じ。|
  | `Linear sRGB` |ガンマを除去した sRGB。|
  | `HSV` |Hue(色相)、Saturation(彩度)、Value(明度)からなる色空間。|
  | `HSL` |Hue(色相)、Saturation(彩度)、Lightness(輝度)からなる色空間。黒や白とのグラデーションで HSV との違いが顕著に表れる。|
  | `L*a*b*`<br>(CIE LAB) |人間の視覚に基づいて色の差が均等に認識できるように設計された色空間。本スクリプトでは D50 を白色点とする。|
  | `LCh` | L\*a\*b* の a, b を極座標に変換したもの。 Hue(色相)を回転させながら補間できるため、色の変化がより自然になる。
  | `Oklab` |L\*a\*b* の知覚的均等性を改善した色空間。
  | `Oklch` | Oklab を極座標に変換したもの。

  **比較画像**
  ![comparison](assets/gradient_comparison.png)

- #### 補間経路
  HSV、HSL、LCh、Oklch といった色相を角度として表す色空間が、色相環上でどのような経路で補間するか指定します。
  | 値 | 経路 |
  |:---:|:---:|
  | `1` | 短経路 |
  | `2` | 長経路 |

  ![Hue](assets/hue_wheel.png)

- #### 開始色
  開始色を指定します。初期値は `0xffffff` です。

- #### 終了色
  終了色を指定します。初期値は `0x000000` です。

- #### 開始色透明度
  開始色の透明度を指定します。

- #### 終了色透明度
  終了色の透明度を指定します。

## ライセンス
[CC0](LICENSE.txt) に基づくものとします。

## クレジット
### [aulua](https://github.com/karoterra/aviutl2-aulua)

<details>
<summary>MIT License</summary>

```
MIT License

Copyright (c) 2025 karoterra

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
</details>

## 更新履歴
- #### v1.1.0 (2026/1/7)
    - 透明度を追加。
    - 色空間に `sRGB` を追加。
    - アルファマスクの計算が正しくなかったのを修正。
    - ビルドツールに aulua を使うように変更。
- #### v1.0.0 (2025/7/13)
  初版
