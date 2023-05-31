//
//  DiamondShape.swift
//  Gestor manada
//
//  Created by LAalex.ulloa on 30/5/23.
//

import Foundation
import SwiftUI

struct Diamond: Shape {
    let radius: CGFloat = 20
    func path(in rect: CGRect) -> Path {
        Path() { p in
            let p1 = CGPoint(x: rect.midX, y: rect.minY)
            let p2 = CGPoint(x: rect.maxX, y: rect.midY)
            let p3 = CGPoint(x: rect.midX, y: rect.maxY)
            let p4 = CGPoint(x: rect.minX, y: rect.midY)
            
            p.move(to: p4)
            p.addArc(tangent1End: p1, tangent2End: p2, radius: radius)
            p.addArc(tangent1End: p2, tangent2End: p3, radius: radius)
            p.addArc(tangent1End: p3, tangent2End: p4, radius: radius)
            p.addArc(tangent1End: p4, tangent2End: p1, radius: radius)
        }
    }
}
