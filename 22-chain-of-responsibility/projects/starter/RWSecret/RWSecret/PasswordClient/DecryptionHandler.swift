import  RNCryptor

public class DecryptionHandler{
	
	public var next: DecryptionHandlerProtocol?
	public let password: String
	
	public init(password: String){
		self.password = password
	}
	
}

extension DecryptionHandler: DecryptionHandlerProtocol{
	
	public func decrypt(data encryptedData: Data) -> String? {
		
		guard let data = try? RNCryptor.decrypt(
			data: encryptedData,
			withPassword: password),
			let text = String(data: data, encoding: .utf8) else {
			
				return next?.decrypt(data: encryptedData)
		}
		return text
	}
	
}
