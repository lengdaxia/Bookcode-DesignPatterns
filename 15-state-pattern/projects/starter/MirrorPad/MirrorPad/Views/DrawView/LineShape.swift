import UIKit

public class LineShape: CAShapeLayer, Copying {

  // MARK: - Instance Properties
  private let bezierPath: UIBezierPath

  // MARK: - Object Lifecycle
  public init(color: UIColor, width: CGFloat, startPoint: CGPoint) {
    bezierPath = UIBezierPath()
    bezierPath.move(to: startPoint)
    super.init()

    fillColor = nil
    lineWidth = width
    path = bezierPath.cgPath
    strokeColor = color.cgColor
  }

  public override convenience init(layer: Any) {
    let lineShape = layer as! LineShape
    self.init(lineShape)
  }

  public required init(_ prototype: LineShape) {
    bezierPath = prototype.bezierPath.copy() as! UIBezierPath
    super.init(layer: prototype)

    fillColor = nil
    lineWidth = prototype.lineWidth
    path = bezierPath.cgPath
    strokeColor = prototype.strokeColor
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not supported")
  }

  // MARK: - Instance Methods
  public func addPoint(_ point: CGPoint) {
    bezierPath.addLine(to: point)
    path = bezierPath.cgPath
  }
}
