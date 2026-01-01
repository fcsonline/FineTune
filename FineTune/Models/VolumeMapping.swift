// FineTune/Models/VolumeMapping.swift
import Foundation

/// Utility for converting between slider position and audio gain.
/// Uses cubic (x^3) curve for natural feel matching Apple's approach.
enum VolumeMapping {
    /// Cubic exponent - "punchier" feel, good for media players
    static let exponent: Double = 3.0

    /// Maximum gain multiplier (200% = 2.0)
    static let maxGain: Double = 2.0

    /// Convert slider position (0-1) to linear gain (0-maxGain)
    /// - Parameter slider: Normalized slider position 0.0 to 1.0
    /// - Returns: Linear gain multiplier 0.0 to 2.0
    static func sliderToGain(_ slider: Double) -> Float {
        Float(pow(slider, exponent) * maxGain)
    }

    /// Convert linear gain (0-maxGain) to slider position (0-1)
    /// - Parameter gain: Linear gain multiplier 0.0 to 2.0
    /// - Returns: Normalized slider position 0.0 to 1.0
    static func gainToSlider(_ gain: Float) -> Double {
        pow(Double(gain) / maxGain, 1.0 / exponent)
    }

    /// Format gain as percentage for display
    /// - Parameter gain: Linear gain multiplier
    /// - Returns: Integer percentage (0-200)
    static func gainToPercentage(_ gain: Float) -> Int {
        Int(gain * 100)
    }
}
