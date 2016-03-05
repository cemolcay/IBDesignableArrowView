//
//  IBDesignableArrowView.swift
//  IBDesignableArrowView
//
//  Created by Cem Olcay on 04/03/16.
//  Copyright © 2016 MovieLaLa. All rights reserved.
//

import UIKit

public enum IBDesignableArrowDirection: String, CustomStringConvertible {
  case Left = "Left"
  case Right = "Right"
  case Up = "Up"
  case Down = "Down"

  public var description: String {
    return rawValue
  }
}

@IBDesignable
public class IBDesignableArrowView: UIView {

  public var type: IBDesignableArrowDirection = .Left

  // properties
  @IBInspectable public var lineCapRounded: Bool = true
  @IBInspectable public var lineWidth: CGFloat = 1
  @IBInspectable public var color: UIColor = UIColor.blackColor()
  @IBInspectable public var typeAdapter: String = IBDesignableArrowDirection.Left.description {
    didSet {
      type = IBDesignableArrowDirection(rawValue: typeAdapter) ?? type
    }
  }

  // insets
  @IBInspectable public var leftInset: CGFloat = 0
  @IBInspectable public var rightInset: CGFloat = 0
  @IBInspectable public var topInset: CGFloat = 0
  @IBInspectable public var bottomInset: CGFloat = 0

  // shape layer
  private lazy var shapeLayer: CAShapeLayer = {
    let shape = CAShapeLayer()
    self.layer.addSublayer(shape)
    return shape
  }()

  // render
  public override func layoutSubviews() {
    super.layoutSubviews()

    shapeLayer.frame = CGRect(
      x: leftInset,
      y: topInset,
      width: frame.size.width - leftInset - rightInset,
      height: frame.size.height - topInset - bottomInset)
    shapeLayer.lineCap = lineCapRounded ? kCALineCapRound : kCALineCapButt
    shapeLayer.strokeColor = color.CGColor
    shapeLayer.lineWidth = lineWidth
    shapeLayer.fillColor = UIColor.clearColor().CGColor

    let path = UIBezierPath()
    let width = shapeLayer.frame.size.width
    let height = shapeLayer.frame.size.height

    switch type {
    case .Left:
      path.moveToPoint(CGPoint(x: width, y: 0))
      path.addLineToPoint(CGPoint(x: 0, y: height/2))
      path.addLineToPoint(CGPoint(x: width, y: height))

    case .Right:
      path.moveToPoint(CGPoint(x: 0, y: 0))
      path.addLineToPoint(CGPoint(x: width, y: height/2))
      path.addLineToPoint(CGPoint(x: 0, y: height))

    case .Up:
      path.moveToPoint(CGPoint(x: 0, y: height))
      path.addLineToPoint(CGPoint(x: width/2, y: 0))
      path.addLineToPoint(CGPoint(x: width, y: height))

    case .Down:
      path.moveToPoint(CGPoint(x: 0, y: 0))
      path.addLineToPoint(CGPoint(x: width/2, y: height))
      path.addLineToPoint(CGPoint(x: width, y: 0))
    }

    shapeLayer.path = path.CGPath
  }
}
