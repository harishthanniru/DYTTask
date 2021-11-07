//
//  CircleProfressView.swift
//  DYTTask
//
//  Created by apple on 05/11/21.
//

import Foundation
import UIKit

class CircularPrgressBar: UIView {
    var bgPath: UIBezierPath!
    var shapeLayer: CAShapeLayer!
    var progressLayer: CAShapeLayer!

    var progress: Float = 0 {
        willSet(newValue) {
            progressLayer.strokeEnd = CGFloat(newValue)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        bgPath = UIBezierPath()
        simpleShape()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bgPath = UIBezierPath()
        simpleShape()
    }

    func simpleShape() {
        createCirclePath()
        shapeLayer = CAShapeLayer()
        shapeLayer.path = bgPath.cgPath
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        progressLayer = CAShapeLayer()
        progressLayer.path = bgPath.cgPath
        progressLayer.lineWidth = 3
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.primary.cgColor
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(shapeLayer)
        layer.addSublayer(progressLayer)
    }

    private func createCirclePath() {
        let width = frame.width / 2
        let height = frame.height / 2
        let center = CGPoint(x: width, y: height)
        print(width, height, center)
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2), radius: (frame.size.width - 1.5) / 2, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        bgPath.append(circularPath)
        bgPath.close()
    }
}

