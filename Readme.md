<div align="left">
  <a href="README-CN.md"><img alt="中文" src="https://img.shields.io/badge/Documentation-中文-blue"></a>
</div>

# 📱 SwiftUI Triple-Layer Parallax + 3D Tilt (Motion Parallax Effect)

This component implements a **triple-layer parallax + 3D tilt** animation using **CoreMotion + SwiftUI**.  
You can use this effect for:

- App home screen banners  
- Web3 / Crypto wallet header sections  
- Game foreground/midground/background parallax scenes  
- Product showcase cards with 3D interaction  
- Dynamic wallpaper / lock-screen style depth effects  

Supports three image layers, adjustable depth, scaling, rotation angles, and smooth animations.

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

## 🚀 Features

- 🎛 **Triple-layer parallax** (front / middle / back)  
- 🎢 **3D rotation effect** using `rotation3DEffect` + perspective  
- 📱 **Powered by CoreMotion gravity sensors**  
- 🎚 **Customizable parallax depth, rotation angles, and scaling**  
- 🧰 **Pure SwiftUI implementation — clean and maintainable**  
- 🔧 **Easy to integrate into any project (banner, card, page header)**  

---

## 📦 Recommended Project Structure

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

## 🛠 Usage

### **1. Create the MotionManager (CoreMotion handler)**

```swift
@StateObject private var motionManager = MotionManager()
```

### **2. Add the triple-layer parallax component**

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

### **3. Start / Stop motion updates 更新**

```swift
.onAppear { motionManager.start() }
.onDisappear { motionManager.stop() }
```

---

## ⚙️ Adjustable Parameters

| 參數名稱 | 類型 | 說明 |
|---------|------|------|
| maxOffset | CGFloat | Maximum parallax displacement |
| maxAngleY | Double | Horizontal tilt rotation |
| maxAngleX | Double | Forward/backward tilt rotation |
| middleScale | CGFloat | Mid layer scale factor |
| foregroundScale | CGFloat | Foreground scale (usually slightly larger) |
| backgroundScale | CGFloat | Background scale (prevents edge exposure during movement) |

---

## 📘 How It Works

### **MotionManager**
- Uses CoreMotion’s `gravity.x / gravity.y`
- Records a baseline when motion updates start
- Outputs gravity values relative to the moment the device is lifted → making the effect more stable and natural

### **ParallaxTripleLayerView**
- Calculates the offsets of the three layers based on gravity changes
- Each layer uses its own factor to determine foreground/middle/background displacement
- Implements 3D tilt using `rotation3DEffect`
- Adds a short transition animation `.easeOut(duration: 0.08)` for smoother movement

---

## 🪪 License

MIT License — free for personal and commercial use.


---

## ✨ Author

Allen Hsu  
Mobile Engineer（iOS + Flutter）｜Web3 Wallet Developer  
GitHub: https://github.com/blackman5566
