/*
required关键字只能用于修饰类初始化方法。
当子类含有异于父类的初始化方法时（初始化方法参数类型和数量异于父类），子类必须要实现父类的required初始化方法，并且也要使用required修饰符而不是override
当子类没有初始化方法时，可以不用实现父类的required初始化方法。
如果父类的初始化方法使用required修饰时，子类如果重写异于父类的初始化方法，那么必须实现required修饰的父类的方法。

required作用就是让子类实现父类指定的构造器

如果子类没有实现任何的init方法，那么默认调用父类的init方法

指定构造器在一个类中必须至少有一个, 而便利构造器的数量没有限制.

convenience
便利构造器:
convenience方法中必须调用self.init（或者其他的指定构造器都可以）来保证非optional的实例变量被赋值初始化。
————————————————

*/

import UIKit

public class LineShape: CAShapeLayer ,Copying{

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
		
    let prototype = layer as! LineShape
		self.init(prototype)
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
