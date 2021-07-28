/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Builder
 - - - - - - - - - -
 ![Builder Diagram](Builder_Diagram.png)
 
 The builder pattern allows complex objects to be created step-by-step instead of all-at-once via a large initializer.
 
 The builder pattern involves three parts:
 
 (1) The **product** is the complex object to be created.
 
 (2) The **builder** accepts inputs step-by-step and ultimately creates the product.
 
 (3) The **director** supplies the builder with step-by-step inputs and requests the builder create the product once everything has been provided.
 
 ## Code Example
 */
import Foundation

// MARK: - Product
// 1
public struct Hamburger {
	public let meat: Meat
	public let sauce: Sauces
	public let toppings: Toppings
}

extension Hamburger: CustomStringConvertible {
	public var description: String {
		return meat.rawValue + " burger"
	}
}


// 2
public enum Meat: String {
	case beef
	case chicken
	case kitten
	case tofu
}

// 3
public struct Sauces: OptionSet {
	public static let mayonnaise = Sauces(rawValue: 1 << 0)
	public static let mustard = Sauces(rawValue: 1 << 1)
	public static let ketchup = Sauces(rawValue: 1 << 2)
	public static let secret = Sauces(rawValue: 1 << 3)

	public let rawValue: Int
	public init(rawValue: Int) {
		self.rawValue = rawValue
	}
}

// 4
public struct Toppings: OptionSet {
	public static let cheese = Toppings(rawValue: 1 << 0)
	public static let lettuce = Toppings(rawValue: 1 << 1)
	public static let pickles = Toppings(rawValue: 1 << 2)
	public static let tomatoes = Toppings(rawValue: 1 << 3)

	public let rawValue: Int
	public init(rawValue: Int) {
		self.rawValue = rawValue
	}
}



public struct Smells: OptionSet{
	public static let apple = Smells(rawValue: 1 << 0)
	public static let beer = Smells(rawValue: 1 << 1)
	public static let banana = Smells(rawValue: 1 << 2)

	public let rawValue: Int
	public init(rawValue: Int) {
		self.rawValue = rawValue
	}
}


// MARK: - Builder

public enum Error: Swift.Error {
	case soldOut
}

public class HamburgerBuilder {
	// 1 属性值是公开的，但是set方式是私有的
	public private(set) var meat: Meat = .beef
	public private(set) var sauces: Sauces = []
	public private(set) var toppings: Toppings = []
	
	private var soldOutMeats: [Meat] = [.kitten]
	
	// 2
	public func addSauces(_ sauce: Sauces) {
		sauces.insert(sauce)
	}

	public func removeSauces(_ sauce: Sauces) {
		sauces.remove(sauce)
	}

	public func addToppings(_ topping: Toppings) {
		toppings.insert(topping)
	}

	public func removeToppings(_ topping: Toppings) {
		toppings.remove(topping)
	}

	public func setMeat(_ meat: Meat) throws {
		guard isAvailable(meat) else {
			throw Error.soldOut
		}
		
		self.meat = meat
	}
	
	public func isAvailable(_ meat: Meat) -> Bool {
		return !soldOutMeats.contains(meat)
	}

	// 3
	public func build() -> Hamburger {
		return Hamburger(meat: meat,
										 sauce: sauces,
										 toppings: toppings)
	}
}


// MARK: - Director
public class Employee {

	public func createCombo1() throws -> Hamburger {
		let builder = HamburgerBuilder()
		try builder.setMeat(.beef)
		builder.addSauces(.secret)
		builder.addToppings([.lettuce, .tomatoes, .pickles])
		return builder.build()
	}

	public func createKittenSpecial() throws -> Hamburger {
		let builder = HamburgerBuilder()
		try builder.setMeat(.kitten)
		builder.addSauces(.mustard)
		builder.addToppings([.lettuce, .tomatoes])
		return builder.build()
	}
}


// MARK: - Example
let burgerFlipper = Employee()

if let combo1 = try? burgerFlipper.createCombo1() {
	print("Nom nom " + combo1.description)
}
