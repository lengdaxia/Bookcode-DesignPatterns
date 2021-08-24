/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Adapter
 - - - - - - - - - -
 ![Adapter Diagram](Adapter_Diagram.png)
 
 The adapter pattern allows incompatible types to work together. It involves four components:
 
 1. An **object using an adapter** is the object that depends on the new protocol.
 
 2. The **new protocol** that is desired to be used.
 
 3. A **legacy object** that existed before the protocol was made and cannot be modified directly to conform to it.
 
 4. An **adapter** that's created to conform to the protocol and passes calls onto the legacy object.
 
 ## Code Example
 */
import UIKit

// MARK: - Legacy Object
public  class GoogleAuthenticator {
	public func login(
		email: String,
		password: String,
		completion: @escaping (GoogleUser?, Error?) -> Void) {
		
		// Make networking calls that return a token string
		let token = "special-token-value"
		
		let user = GoogleUser(email: email,
													password: password,
													token: token)
		completion(user, nil)
	}
}

public struct GoogleUser {
	public var email: String
	public var password: String
	public var token: String
}

// MARK: - protocol
public protocol AuthenticationService{
	func login(email:String,
						 password: String,
						 success: @escaping(User, Token) -> Void,
						 failure: @escaping(Error?) -> Void
						 )
}

public struct User{
	public let email: String
	public let password: String
}

public struct Token{
	public let value: String
}


//Adapter
public class GoogleAuthenticatorAdapter: AuthenticationService{
	
	private var authenticator = GoogleAuthenticator()
	
	public func login(email: String, password: String, success: @escaping (User, Token) -> Void, failure: @escaping (Error?) -> Void) {
		authenticator.login(email: email, password: password) { googleuser, error in
			
			guard let googleUser = googleuser else {
				failure(error)
				return
			}
			
			let user = User(email: googleUser.email, password: googleUser.password)
			
			let token = Token(value: googleUser.token)
			
			success(user, token)
		}
	}
}


// MARK: - 使用适配器模式
public class LoginViewController: UIViewController{
	
//	MARK: - Properties
	public var authService:AuthenticationService!
	
//	views
	var emailTextField = UITextField()
	var passwordTextfield = UITextField()
	
	public class func instance(with authService: AuthenticationService) -> LoginViewController{
		
		let viewController = LoginViewController()
		viewController.authService = authService
		return viewController
	}
	
	
	public func login(){
		guard let email = emailTextField.text,
					let password = passwordTextfield.text
					else {
			return
		}
		
		authService.login(email: email, password: password) { user, token in
			print("Auth succeeded: \(user.email), \(token.value)")
		} failure: { error in
			print("\(error.debugDescription)")
		}
	}
}

let viewController = LoginViewController.instance(with: GoogleAuthenticatorAdapter())

viewController.emailTextField.text = "user@example.com"
viewController.passwordTextfield.text = "password"
viewController.login()

