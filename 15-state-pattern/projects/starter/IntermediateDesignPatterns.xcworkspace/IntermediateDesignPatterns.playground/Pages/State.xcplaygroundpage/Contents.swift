

import UIKit
import PlaygroundSupport

// MARK: - Context
public class TrafficLight: UIView {

	// MARK: - Instance Properties
	// 1
	public private(set) var canisterLayers: [CAShapeLayer] = []
	
	public private(set) var currentState: TrafficLightState
	public private(set) var states: [TrafficLightState]
	
	// MARK: - Object Lifecycle
	// 2
	@available(*, unavailable,
		message: "Use init(canisterCount: frame:) instead")
	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) is not supported")
	}

	// 3
	public init(canisterCount: Int = 3,
							frame: CGRect =
								CGRect(x: 0, y: 0, width: 160, height: 420),  states: [TrafficLightState]) {
		super.init(frame: frame)
		// 1
		guard !states.isEmpty else {
			fatalError("states should not be empty")
		}
		self.currentState = states.first!
		self.states = states
		
		backgroundColor =
			UIColor(red: 0.86, green: 0.64, blue: 0.25, alpha: 1)
		createCanisterLayers(count: canisterCount)
		
		transition(to: currentState)
		nextState.apply(to: self, after: currentState.delay)
	}

	// 4
	private func createCanisterLayers(count: Int) {
		// 1
		let paddingPercentage: CGFloat = 0.2
		let yTotalPadding = paddingPercentage * bounds.height
		let yPadding = yTotalPadding / CGFloat(count + 1)

		// 2
		let canisterHeight = (bounds.height - yTotalPadding) / CGFloat(count)
		let xPadding = (bounds.width - canisterHeight) / 2.0
		var canisterFrame = CGRect(x: xPadding,
															 y: yPadding,
															 width: canisterHeight,
															 height: canisterHeight)

		// 3
		for _ in 0 ..< count {
			let canisterShape = CAShapeLayer()
			canisterShape.path = UIBezierPath(
				ovalIn: canisterFrame).cgPath
			canisterShape.fillColor = UIColor.black.cgColor

			layer.addSublayer(canisterShape)
			canisterLayers.append(canisterShape)

			canisterFrame.origin.y += (canisterFrame.height + yPadding)
		}
	}
	
	public func transition(to state: TrafficLightState) {
		removeCanisterSublayers()
	currentState = state
	currentState.apply(to: self)
}
	
	
	private func removeCanisterSublayers() {
	 canisterLayers.forEach {
		 $0.sublayers?.forEach {
			 $0.removeFromSuperlayer()
		 }
	 }
 }
	
	public var nextState: TrafficLightState {
		guard let index = states.firstIndex(where: {
				$0 === currentState
			}),
			index + 1 < states.count else {
				return states.first!
		}
		return states[index + 1]
	}
}




//let trafficLight = TrafficLight()
//PlaygroundPage.current.liveView = trafficLight
//
//public protocol TrafficLightState: AnyObject{
//	var delay: TimeInterval{get}
//
//	func apply(to context: TrafficLight)
//}

// MARK: - State Protocol
public protocol TrafficLightState: AnyObject {

	// MARK: - Properties
	// 1
	var delay: TimeInterval { get }

	// MARK: - Instance Methods
	// 2
	func apply(to context: TrafficLight)
}

// MARK: - Transitioning
extension TrafficLightState {
	public func apply(to context: TrafficLight,
										after delay: TimeInterval) {
		let queue = DispatchQueue.main
		let dispatchTime = DispatchTime.now() + delay
		queue.asyncAfter(deadline: dispatchTime) {
			[weak self, weak context] in
			guard let self = self, let context = context else {
				return
			}
			context.transition(to: self)
		}
	}
}



public class SolidTrafficLightState{
	
	public let canisterIndex: Int
	public let color: UIColor
	public let delay: TimeInterval
	
	public init(canisterIndex: Int, color: UIColor, delay: TimeInterval){
		
		self.canisterIndex = canisterIndex
		self.color = color
		self.delay = delay
	}
}

extension SolidTrafficLightState: TrafficLightState{
	
	public func apply(to context: TrafficLight) {
		let canisterLayer = context.canisterLayers[canisterIndex]
		
		let circleShape = CAShapeLayer()
		
		circleShape.path = canisterLayer.path!
		circleShape.fillColor = color.cgColor
		circleShape.strokeColor = color.cgColor
		canisterLayer.addSublayer(circleShape)
	}
}

// MARK: - Convenience Constructors
extension SolidTrafficLightState {
	public class func greenLight(
		color: UIColor =
			UIColor(red: 0.21, green: 0.78, blue: 0.35, alpha: 1),
		canisterIndex: Int = 2,
		delay: TimeInterval = 1.0) -> SolidTrafficLightState {
		return SolidTrafficLightState(canisterIndex: canisterIndex,
																	color: color,
																	delay: delay)
	}

	public class func yellowLight(
		color: UIColor =
			UIColor(red: 0.98, green: 0.91, blue: 0.07, alpha: 1),
		canisterIndex: Int = 1,
		delay: TimeInterval = 0.5) -> SolidTrafficLightState {
		return SolidTrafficLightState(canisterIndex: canisterIndex,
																	color: color,
																	delay: delay)
	}

	public class func redLight(
		color: UIColor =
			UIColor(red: 0.88, green: 0, blue: 0.04, alpha: 1),
		canisterIndex: Int = 0,
		delay: TimeInterval = 2.0) -> SolidTrafficLightState {
		return SolidTrafficLightState(canisterIndex: canisterIndex,
																	color: color,
																	delay: delay)
	}
}


let greenYellowRed: [SolidTrafficLightState] =
	[.greenLight(), .yellowLight(), .redLight()]

let trafficLight = TrafficLight(states: greenYellowRed)
PlaygroundPage.current.liveView = trafficLight
