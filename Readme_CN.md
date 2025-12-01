# 📱 SwiftUI 三層視差＋3D Tilt（Motion Parallax Effect）

這是一個使用 **CoreMotion + SwiftUI** 實作的「三層視差＋3D 立體傾斜效果」元件。  
你可以把它用作：

- App 首頁 Banner
- Web3 / Crypto 錢包的 Header 區塊
- 遊戲前景/中景/背景的場景視差效果
- 產品展示卡片（具有 3D 互動）
- Dynamic Wallpaper / Lock Screen 的動態視差效果

支援三層圖片、不同視差深度、縮放、旋轉角度，並具有平滑動畫。

---

## 🎥 Demo
<p align="center">
  <img 
    src="https://github.com/blackman5566/MotionDepthEffect/raw/main/demo.gif" 
    alt="MotionDepthEffect Demo" 
    width="320"
  />
</p>


---

## 🚀 功能特點（Features）

- 🎛 **三層視差（前 / 中 / 後）**
- 🎢 **3D 旋轉效果（rotation3DEffect + perspective）**
- 📱 **CoreMotion 重力感測器驅動**
- 🎚 **可調整視差深度、角度、縮放倍數**
- 🧰 **完全 SwiftUI 寫法，乾淨易維護**
- 🔧 **可輕鬆整合到任何專案（Banner / 卡片 / 頁面 Header）**

---

## 📦 專案結構建議

```
SwiftUI-MotionParallax/
 ├── App/
 │    ├── ContentView.swift
 │    └── SwiftUI_MotionParallaxApp.swift
 └── Parallax/
      ├── MotionManager.swift
      └── ParallaxTripleLayerView.swift
```

---

## 🛠 使用方式（Usage）

### **1. 建立 MotionManager（負責 CoreMotion）**

```swift
@StateObject private var motionManager = MotionManager()
```

### **2. 放入三層視差元件**

```swift
ParallaxTripleLayerView(
    motionManager: motionManager,
    backImageName: "back",
    middleImageName: "mid",
    frontImageName: "fore",
    maxOffset: 20,
    maxAngleY: 20,
    maxAngleX: 30,
    middleScale: 1.0,
    foregroundScale: 1.05,
    backgroundScale: 1.2
)
.frame(height: 220)
```

### **3. 啟動 / 停止 Motion 更新**

```swift
.onAppear { motionManager.start() }
.onDisappear { motionManager.stop() }
```

---

## ⚙️ 可調整參數（Parameters）

| 參數名稱 | 類型 | 說明 |
|---------|------|------|
| maxOffset | CGFloat | 視差最大位移 |
| maxAngleY | Double | 左右搖晃的傾斜角 |
| maxAngleX | Double | 前後傾斜角度 |
| middleScale | CGFloat | 中景圖縮放倍數 |
| foregroundScale | CGFloat | 前景縮放（通常略大） |
| backgroundScale | CGFloat | 背景縮放（避免移動時露邊） |

---

## 📘 內部原理簡介（How It Works）

### **MotionManager**
- 使用 CoreMotion 的 `gravity.x / gravity.y`
- 啟動時記錄基準值（baseline）
- 實際輸出為「相對於拿起手機那瞬間」的重力變化 → 讓效果更穩定自然

### **ParallaxTripleLayerView**
- 依重力位移計算三層 offset
- 依每層的 factor 決定前景/中景/背景的偏移程度
- 用 `rotation3DEffect` 實作 3D tilt
- 加上短暫動畫 `.easeOut(duration: 0.08)` 讓效果更順暢

---

## 🪪 License

MIT License — 可自由用於個人與商業用途。

---

## ✨ 作者（Author）

Allen Hsu  
Mobile Engineer（iOS + Flutter）｜Web3 Wallet Developer  
GitHub: https://github.com/blackman5566
