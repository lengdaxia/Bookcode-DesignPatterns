import UIKit

public class AnimateState: DrawViewState {
	
	
	public override func animate() {
		guard let sublayers = drawView.layer.sublayers,
			sublayers.count > 0 else {
			// 1
			transitionToState(
				matching: AcceptInputState.identifier)
			return
		}
		sublayers.forEach { $0.removeAllAnimations() }
		UIView.animate(withDuration: 0.3) {
			CATransaction.begin()
			CATransaction.setCompletionBlock { [weak self] in
				// 2
				self?.transitionToState(
					matching: AcceptInputState.identifier)
			}
			self.setSublayersStrokeEnd(to: 0.0)
			self.animateStrokeEnds(of: sublayers, at: 0)
			CATransaction.commit()
		}
	}

	private func setSublayersStrokeEnd(to value: CGFloat) {
		drawView.layer.sublayers?.forEach {
			guard let shapeLayer = $0 as? CAShapeLayer else { return }
			shapeLayer.strokeEnd = 0.0
			let animation = CABasicAnimation(keyPath: "strokeEnd")
			animation.fromValue = value
			animation.toValue = value
			animation.fillMode =  .forwards
			shapeLayer.add(animation, forKey: nil)
		}
	}

	private func animateStrokeEnds(of layers: [CALayer], at index: Int) {
		guard index < layers.count else { return }
		let currentLayer = layers[index]
		CATransaction.begin()
		CATransaction.setCompletionBlock { [weak self] in
			currentLayer.removeAllAnimations()
			self?.animateStrokeEnds(of: layers, at: index + 1)
		}
		if let shapeLayer = currentLayer as? CAShapeLayer {
			shapeLayer.strokeEnd = 1.0
			let animation = CABasicAnimation(keyPath: "strokeEnd")
			animation.duration = 1.0
			animation.fillMode =  .forwards
			animation.fromValue = 0.0
			animation.toValue = 1.0
			shapeLayer.add(animation, forKey: nil)
		}
		CATransaction.commit()
	}
}
