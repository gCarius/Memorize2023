//
//  Pie.swift
//  Memorize2023
//
//  Created by Guilherme Carius on 2025-07-16.
//

import SwiftUI
import CoreGraphics

struct Pie: Shape {
    var startAngle: Angle = .zero
    var clockWise: Bool = true
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2.0
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.x + radius * sin(startAngle.radians)
        )

        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockWise
        )
        p.addLine(to: center)
        return p
    }
}

