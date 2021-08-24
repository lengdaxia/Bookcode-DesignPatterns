import MapKit

public protocol BussinessSearchClient{
	
	func search(with coordinate: CLLocationCoordinate2D,
							term: String,
							limit: UInt,
							offset: UInt,
							success: @escaping(([Bussiness]) -> Void),
							failure: @escaping((Error?) -> Void)
							)
}
