import UIKit

public class ClearState: DrawViewState {
	public override func clear() {
		drawView.lines = []
		drawView.layer.sublayers?.removeAll()
		
		transitionToState(matching: AcceptInputState.identifier)
	}
}
