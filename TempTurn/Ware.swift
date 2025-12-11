//
//  Ware.swift
//  TempTurn
//
//  Created by Eli J on 12/11/25.
//

import SwiftUI

extension Double {
    /// Map this value from one numeric range to another
    func map(from: ClosedRange<Double>, to: ClosedRange<Double>) -> Double {
        let clampedSelf = min(max(self, from.lowerBound), from.upperBound)
        let normalized = (clampedSelf - from.lowerBound) / (from.upperBound - from.lowerBound)
        return to.lowerBound + normalized * (to.upperBound - to.lowerBound)
    }
}


func continuousThermalColor(kelvin: Double) -> Color {
    let minK: Double = 253.15
    let maxK: Double = 323.15
    let clampedK = min(max(kelvin, minK), maxK)
    
    let hue = clampedK.map(from: minK...maxK, to: 0.75...0)
    
    let comfortK: Double = 293.15
    let delta = abs(clampedK - comfortK)
    let maxDelta: Double = 20.0
    let sat = min(delta.map(from: 0.0...maxDelta, to: 0.2...0.9), 1.0)
    
    return Color(hue: hue, saturation: sat, brightness: 0.9)
}
