//
//  ContentView.swift
//  MotionDepthEffect
//
//  Created by 許佳豪 on 2025/12/1.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 🔹 最上面的 Parallax Banner
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
                .frame(height: 200)
                .clipped()
                
                // 🔹 下方列表（示意用假資料）
                List {
                    Section(header: Text("Recent Activity")) {
                        ForEach(0..<20, id: \.self) { index in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Transaction #\(index + 1)")
                                        .font(.headline)
                                    Text("Some description for this item")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Text("- 0.\(index) ETH")
                                    .font(.subheadline)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden) // 讓 List 背景透明
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("ParallaxTripleLayerView Demo")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            motionManager.start()
        }
        .onDisappear {
            motionManager.stop()
        }
    }
}


