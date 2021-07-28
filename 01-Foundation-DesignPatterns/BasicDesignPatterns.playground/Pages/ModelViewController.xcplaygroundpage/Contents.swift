//: [Previous](@previous)

import UIKit
import PlaygroundSupport

struct Model{
	var greeting = "Hello, playground"
}

class BodyView: UIView{
	
	private lazy var label:UILabel = {
		let label = UILabel()
		label.text = "PlaceHolder"
		label.textColor = UIColor.blue
		label.font = UIFont.systemFont(ofSize: 20)
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .red
		addSubview(label)
		
	}
	
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		label.frame = CGRect(origin: self.center, size: CGSize.init(width: 200, height: 100))
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

class ViewController: UIViewController{
	
	let model = Model(greeting: "Hello MVC!")
	let bodyView = BodyView(frame: CGRect(x: 100, y: 0, width: 0, height: 200))

	
	override func viewDidLoad() {
		
		view.addSubview(bodyView)
	}
	
	
}

PlaygroundPage.current.liveView = ViewController()

//: [Next](@next)
