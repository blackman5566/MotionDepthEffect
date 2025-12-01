//
//  MotionManager.swift
//  MotionParallax
//
//  封裝 CoreMotion 的重力資訊，並提供「相對基準」的數值，
//  讓畫面可以以「目前拿手機的姿勢」當成 0,0 來做視差與傾斜效果。
//  使用方式：
//    1. 在 View 裡用 @StateObject 建立一個 MotionManager
//    2. 在 .onAppear 呼叫 start()
//    3. 在 .onDisappear 呼叫 stop()
//    4. 如果想重新校正基準，可以呼叫 resetBaseline()
//
//  Created by 許佳豪 on 2025/12/1.
//

import Foundation
import CoreMotion

/// 管理裝置的重力資訊，並提供相對於「校正時刻」的重力向量。
final class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    
    /// 相對基準的重力 X，通常對應裝置左右傾斜。
    @Published var gravityX: Double = 0
    
    /// 相對基準的重力 Y，通常對應裝置前後傾斜。
    @Published var gravityY: Double = 0
    
    /// 原始的重力 Z（目前範例沒有特別使用）。
    @Published var gravityZ: Double = 0
    
    /// CoreMotion 更新頻率，預設 60 FPS。
    private let updateInterval: TimeInterval = 1.0 / 60.0
    
    // MARK: - Baseline（校正）相關
    
    /// 校正時刻的原始重力 X。
    private var baseGX: Double = 0
    
    /// 校正時刻的原始重力 Y。
    private var baseGY: Double = 0
    
    // MARK: - Public API
    
    /// 開始監聽裝置重力變化。
    /// 第一次讀到數值時，會以當下的裝置姿勢作為 baseline。
    func start() {
        guard motionManager.isDeviceMotionAvailable else { return }
        
        motionManager.deviceMotionUpdateInterval = updateInterval
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let self, let motion = motion else { return }
            
            let gx = motion.gravity.x
            let gy = motion.gravity.y
            let gz = motion.gravity.z
            
            // 將重力轉成「相對 baseline」的變化量
            self.gravityX = gx - self.baseGX
            self.gravityY = gy - self.baseGY
            self.gravityZ = gz
        }
    }
    
    /// 停止監聽重力變化，並重置 baseline 狀態。
    func stop() {
        motionManager.stopDeviceMotionUpdates()
    }
}
