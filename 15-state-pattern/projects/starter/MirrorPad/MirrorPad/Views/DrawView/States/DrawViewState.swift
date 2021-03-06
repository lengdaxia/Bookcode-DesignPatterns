import UIKit

public class DrawViewState {
	
	public class var identifier: AnyHashable{
		return ObjectIdentifier(self)
	}
	
	
	public unowned let drawView: DrawView
	

	
	public init(drawView: DrawView){
		self.drawView = drawView
	}
	
	public func animate(){}
	public func copyLines(from source: DrawView){}
	public func clear(){}
	public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){}
	public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){}

	@discardableResult internal func transitionToState(matching identifier: AnyHashable) -> DrawViewState{
		
		let state = drawView.states[identifier]!
		drawView.currentState = state
		return state
	}
}
