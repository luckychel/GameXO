//
//  OView.swift
//  XO-game
//
//  Created by Кукоба Александр on 08/04/2023.
//  Copyright © 2023 Кукоба Александр. All rights reserved.
//

import UIKit

public class OView: MarkView {
    
    internal override func updateShapeLayer() {
        super.updateShapeLayer()
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = 0.3 * min(bounds.width, bounds.height)
        shapeLayer.path = UIBezierPath(arcCenter: center,
                                       radius: radius,
                                       startAngle: 330 * CGFloat.pi / 180,
                                       endAngle: -30 * CGFloat.pi / 180,
                                       clockwise: false).cgPath
    }
}
