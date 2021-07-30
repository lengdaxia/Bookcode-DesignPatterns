//
//  UserViewModel.swift
//  MVVM_demo
//
//  Created by leng on 2021/07/30.
//
import UIKit


public final class UserViewModel {
	
	let user: User = User(name: "mars", age: 28)
	
	init() {
		
	}
}

extension UserViewModel{
	
	public func configureUI(_ view: UserProfileView){
		view.setName(user.name)
		view.setAge(user.age)
	}
	
}
