import UIKit

public class DrawView: UIView {

  // MARK: - Instance Properties
  public var lineColor: UIColor = .black
  public var lineWidth: CGFloat = 5.0
  public var lines: [LineShape] = []
	
	public lazy var currentState = states[AcceptInputState.identifier]!
	
	public lazy var states = [
		AcceptInputState.identifier: AcceptInputState(drawView: self),
		AnimateState.identifier: AnimateState(drawView: self),
		ClearState.identifier: ClearState(drawView: self),
		CopyState.identifier: CopyState(drawView: self)
	]
	
  @IBInspectable public var scaleX: CGFloat = 1 {
    didSet { applyTransform() }
  }
  @IBInspectable public var scaleY: CGFloat = 1 {
    didSet { applyTransform() }
  }
  private func applyTransform() {
    layer.sublayerTransform = CATransform3DMakeScale(scaleX, scaleY, 1)
  }

	
	
  // MARK: - UIResponder
  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		currentState.touchesBegan(touches, with: event)
  }

  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
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
}
