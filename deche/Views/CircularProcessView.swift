//
//  CircularProcessBar.swift
//  deche
//
//  Created by Doğukan Çatmakaş on 20.02.2024.
//

import SwiftUI

public struct CircularProcessBar: View {
    /// Total Value of Circular Process Bar.
    @Binding var total: Double
    
    /// Current Value of Circular Process Bar.
    @Binding var current: Double
    
    // Other Parameters
    var percentColor: Color = .black
    var circleLineWidth: CGFloat = 10
    var barBackgroundColor: Color = .gray
    var barForegroundColor: Color = .blue
    var isPercentageTextVisible: Bool = true
    
    public init(total: Binding<Double>, current: Binding<Double>) {
        self._total = total
        self._current = current
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    // Background Circle
                    Circle()
                        .stroke(lineWidth: circleLineWidth)
                        .opacity(0.3)
                        .foregroundColor(barBackgroundColor)
                    
                    // User Circle
                    Circle()
                        .trim(from: 0, to: CGFloat(current / total))
                        .stroke(style: StrokeStyle(lineWidth: circleLineWidth, lineCap: .round, lineJoin: .round))
                        .foregroundColor(barForegroundColor)
                        .rotationEffect(Angle(degrees: -90))
                    
                    // Visible Control
                    if isPercentageTextVisible {
                        // Percentage Text of Process Bar
                        Text(String(format: "%.0f%%", (current / total) * 100))
                            .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.2))
                            .bold()
                            .foregroundColor(percentColor)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    /// Use to change the color of the percentage text.
    public func percentColor(_ percentColor: Color) -> CircularProcessBar {
        var bar = self
        bar.percentColor = percentColor
        return bar
    }
    
    /// Use to change the line width of the process bar.
    public func circleLineWidth(_ lineWidth: CGFloat) -> CircularProcessBar {
        var line = self
        line.circleLineWidth = lineWidth
        return line
    }
    
    /// Use to chance the background color of the process bar.
    public func barBackgroundColor(_ color: Color) -> CircularProcessBar {
        var bar = self
        bar.barBackgroundColor = color
        return bar
    }
    
    /// Use to chance the foreground color of the process bar.
    public func barForegroundColor(_ color: Color) -> CircularProcessBar {
        var bar = self
        bar.barForegroundColor = color
        return bar
    }
    
    /// Use to change the visibility of the percentage text.
    public func isPercentageTextVisible(_ isVisible: Bool) -> CircularProcessBar {
        var percentageText = self
        percentageText.isPercentageTextVisible = isVisible
        return percentageText
    }
    
}

// Preview
struct CircularProcessBar_Preview: PreviewProvider {
    static var previews: some View {
        CircularProcessBar(total: .constant(100), current: .constant(30))
            .frame(width: 300, height: 300)
    }
}
