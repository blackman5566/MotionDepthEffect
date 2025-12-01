//
//  ParallaxTripleLayerView.swift
//  MotionParallax
//
//  三層視差 + 3D 傾斜效果的通用 View。
//  - 由 MotionManager 提供重力資訊
//  - 支援前 / 中 / 後三層位移
//  - 支援各層不同縮放比例
//  - 整張卡片會隨裝置傾斜產生 3D rotation
//
//  Created by 許佳豪 on 2025/12/1.
//

import SwiftUI

/// 基於 CoreMotion 的三層視差卡片。
/// 典型用途：首頁 Banner、卡片視差背景、錢包總覽 header 等。
struct ParallaxTripleLayerView: View {
    
    /// 外部注入的 MotionManager，用來取得重力資訊。
    @ObservedObject var motionManager: MotionManager
    
    /// 背景層圖片名稱（通常放景色、模糊背景）。
    let backImageName: String
    
    /// 中景層圖片名稱（主要內容，例如城市、Logo、插畫主體）。
    let middleImageName: String
    
    /// 前景層圖片名稱（HUD、裝飾、字樣等）。
    let frontImageName: String
    
    // MARK: - 公開可調參數
    
    /// 視差位移的最大距離（越大晃動越明顯）。
    var maxOffset: CGFloat = 30
    
    /// 左右搖晃時的最大傾斜角度（度數）。
    var maxAngleY: Double = 30
    
    /// 前後傾斜時的最大傾斜角度（度數）。
    var maxAngleX: Double = 40
    
    /// 中景層縮放比例。
    var middleScale: CGFloat = 1.0
    
    /// 前景層縮放比例。
    var foregroundScale: CGFloat = 1.1
    
    /// 背景層縮放比例（通常會比 1 大，避免偏移時露邊）。
    var backgroundScale: CGFloat = 1.3
    
    /// 視差位移比例：前景層。
    let frontFactor: CGFloat = 1.0
    
    /// 視差位移比例：中景層。
    let middleFactor: CGFloat = 0.3
    
    /// 視差位移比例：背景層。
    let backFactor: CGFloat = 0.6
    
    // MARK: - Internal helpers
    
    private func clamped(_ v: Double, min: Double = -1, max: Double = 1) -> Double {
        Swift.min(Swift.max(v, min), max)
    }
    
    /// 背景層的視差位移。
    private var backOffset: CGSize {
        let gx = CGFloat(motionManager.gravityX)
        let gy = CGFloat(motionManager.gravityY)
        return CGSize(
            width: -gx * maxOffset * backFactor,
            height: -gy * maxOffset * backFactor
        )
    }
    
    /// 中景層的視差位移。
    private var middleOffset: CGSize {
        let gx = CGFloat(motionManager.gravityX)
        let gy = CGFloat(motionManager.gravityY)
        return CGSize(
            width: gx * maxOffset * middleFactor,
            height: gy * maxOffset * middleFactor
        )
    }
    
    /// 前景層的視差位移。
    private var frontOffset: CGSize {
        let gx = CGFloat(motionManager.gravityX)
        let gy = CGFloat(motionManager.gravityY)
        return CGSize(
            width: gx * maxOffset * frontFactor,
            height: gy * maxOffset * frontFactor
        )
    }
    
    /// 整張卡片在 X 軸上的傾斜角（前後）。
    private var tiltX: Double {
        let gy = clamped(motionManager.gravityY)
        return gy * maxAngleX
    }
    
    /// 整張卡片在 Y 軸上的傾斜角（左右）。
    private var tiltY: Double {
        let gx = clamped(motionManager.gravityX)
        return gx * maxAngleY
    }
    
    // MARK: - View body
    
    var body: some View {
        ZStack {
            // 背景層：通常放景色 / 模糊背景
            Image(backImageName)
                .resizable()
                .scaledToFill()
                .scaleEffect(backgroundScale)
                .offset(backOffset)
                .clipped()
            
            // 中景層：主體內容
            Image(middleImageName)
                .resizable()
                .scaledToFill()
                .scaleEffect(middleScale)
                .offset(middleOffset)
                .clipped()
            
            // 前景層：HUD / 文案 / 裝飾
            Image(frontImageName)
                .resizable()
                .scaledToFill()
                .scaleEffect(foregroundScale)
                .offset(frontOffset)
                .clipped()
        }
        // 整張卡片做 3D 傾斜
        .rotation3DEffect(
            .degrees(tiltX),
            axis: (x: 1, y: 0, z: 0),
            perspective: 0.7
        )
        .rotation3DEffect(
            .degrees(tiltY),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.7
        )
        // 平滑動畫
        .animation(.easeOut(duration: 0.08),
                   value: motionManager.gravityX)
        .animation(.easeOut(duration: 0.08),
                   value: motionManager.gravityY)
    }
}
