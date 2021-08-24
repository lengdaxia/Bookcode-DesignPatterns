import Foundation

public struct Filter{
	
	public let filter : (Business) -> Bool
	public var businesses: [Business]
	
	public static func identity() -> Filter{
		return Filter(filter: {_ in return true}, businesses: [])
	}
	
	public static func starRating(atLeast starRating: Double) -> Filter{
		return Filter(filter: {$0.rating >= starRating}, businesses: [])
	}
	
	public func filterBusinesses() -> [Business]{
		return businesses.filter(filter)
	}
}


extension Filter: Sequence{
	public func makeIterator() -> some IteratorProtocol {
		return filterBusinesses().makeIterator()
	}
}
