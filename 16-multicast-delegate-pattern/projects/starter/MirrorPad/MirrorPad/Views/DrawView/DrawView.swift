import UIKit


@objc public protocol DrawViewDelegate: AnyObject{
	func  drawView(_ source: DrawView, didAddLine line: LineShape)
	func  drawView(_ source: DrawView, didAddPoint point: CGPoint)
}

public class DrawView: UIView {

  // MARK: - Instance Properties
  public var lineColor: UIColor = .black
  public var lineWidth: CGFloat = 5.0
  public var lines: [LineShape] = []

  @IBInspectable public var scaleX: CGFloat = 1 {
    didSet { applyTransform() }
  }
  @IBInspectable public var scaleY: CGFloat = 1 {
    didSet { applyTransform() }
  }
  private func applyTransform() {
    layer.sublayerTransform = CATransform3DMakeScale(scaleX, scaleY, 1)
  }
  
  public lazy var currentState = states[AcceptInputState.identifier]!

  public lazy var states = [
    AcceptInputState.identifier: AcceptInputState(drawView: self),
    AnimateState.identifier: AnimateState(drawView: self),
    ClearState.identifier: ClearState(drawView: self),
    CopyState.identifier: CopyState(drawView: self)
  ]


  // MARK: - UIResponder
  public override func touchesBegan(_ touches: Set<UITouch>,
                                    with event: UIEvent?) {
    currentState.touchesBegan(touches, with: event)
  }

  public override func touchesMoved(_ touches: Set<UITouch>,
                                    with event: UIEvent?) {
    currentState.touchesMoved(touches, with: event)
  }

  // MARK: - Actions
  public func animate() {
    currentState.animate()
  }
  
  public func clear() {
    currentState.clear()
  }
  
  public func copyLines(from source: DrawView) {
    currentState.copyLines(from: source)
  }
	
//	MARK: - Delegate Management
	public let multicastDelegate = MulticastDelegate<DrawViewDelegate>()
	
	public func addDelegate(_ delegate: DrawViewDelegate){
		multicastDelegate.addDelegate(delegate)
	}
	
	public func removeDelegate(_ delegate: DrawViewDelegate){
		multicastDelegate.removeDelegate(delegate)
	}
}

extension DrawView: DrawViewDelegate{
	
	public func drawView(_ source: DrawView, didAddLine line: LineShape) {
		currentState.drawView(source, didAddLine: line)
	}
	
	public func drawView(_ source: DrawView, didAddPoint point: CGPoint) {
		currentState.drawView(source, didAddPoint: point)
	}
}
