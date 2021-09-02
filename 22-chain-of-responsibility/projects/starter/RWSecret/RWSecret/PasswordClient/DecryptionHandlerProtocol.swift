import Foundation

public protocol DecryptionHandlerProtocol {
	var next: DecryptionHandlerProtocol? { get }
	func decrypt(data encryptedData: Data) -> String?
}
