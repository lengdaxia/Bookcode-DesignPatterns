//
//  UserProfileView.swift
//  MVVM_demo
//
//  Created by leng on 2021/07/30.
//

import UIKit

public class UserProfileView: UIView {
	
	private lazy var nameLabel:UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 25)
		label.textColor = UIColor.darkText
		label.text = "name"
		
		return label
	}()
	
	private lazy var ageLabel:UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 15)
		label.textColor = UIColor.darkText
		label.text = "age"
		return label
	}()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupUI()
	}
	

	func setupUI() {
		
		addSubview(nameLabel)
		addSubview(ageLabel)
		
		nameLabel.frame = CGRect(x: 20, y: 20, width: 200, height: 40)
		ageLabel.frame = CGRect(x: 20, y: 70, width: 100, height: 40)
	}
	
	public func setName(_ name:String){
		nameLabel.text = "姓名：\(name)"
	}
	
	public func setAge(_ age: Int){
		ageLabel.text = "年龄：\(age)"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
