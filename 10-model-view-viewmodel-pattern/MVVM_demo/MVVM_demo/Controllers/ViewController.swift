//
//  ViewController.swift
//  MVVM_demo
//
//  Created by leng on 2021/07/30.
//

import UIKit

class ViewController: UIViewController {
	
	let userViewModel = UserViewModel()
	
	let userView = UserProfileView(frame: CGRect.init(x:0, y: 0, width: 370, height: 500	))

	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		view.addSubview(userView)
		
		userView.frame = CGRect(x: 0, y: 50, width: 375, height: 400)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		userViewModel.configureUI(userView)
	}

}

