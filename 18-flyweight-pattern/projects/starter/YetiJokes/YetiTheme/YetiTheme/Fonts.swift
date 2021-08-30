import Foundation

public final class Fonts{

	public static let large = loadFont(name: fontName, size: 45)
	public static let medium = loadFont(name: fontName,
																			size: 25.0)
	public static let small = loadFont(name: fontName,
																		 size: 12.0)
	
	// 2
	private static let fontName = "coolstory-regular"
	
	private static func loadFont(name: String, size: CGFloat) -> UIFont{
		
//		如果已经注册到系统的font中去，则可以直接取
		if let font = UIFont(name: name, size: size){
			return font
		}
		
		let bundle = Bundle(for: Fonts.self)
		
		guard let url = bundle.url(forResource: name, withExtension: "ttf"),
					let fontData = NSData(contentsOf: url),
					let provider = CGDataProvider(data: fontData),
					let cgFont = CGFont(provider),
					let fontName = cgFont.postScriptName as String?
					else {
			preconditionFailure("unable to load font named \(name)")
		}
		
//		注册到系统的font中去
		CTFontManagerRegisterGraphicsFont(cgFont, nil)
		return UIFont(name: fontName, size: size)!
	}
	
}
