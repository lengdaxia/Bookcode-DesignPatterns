import MapKit
import YelpAPI

extension YLPClient: BussinessSearchClient{
	
	public func search(with coordinate: CLLocationCoordinate2D, term: String, limit: UInt, offset: UInt, success: @escaping (([Bussiness]) -> Void), failure: @escaping ((Error?) -> Void)) {
		
		let yelpCoordinate = YLPCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
		
		search(with: yelpCoordinate, term: term, limit: limit, offset: offset, sort: .bestMatched) { searchResult, error in
			
			guard let searchResult = searchResult,
						error == nil else{
				failure(error)
				return
			}
			
			let bussiness = searchResult.businesses.adaptToBusinesses()
			success(bussiness)
		}
	}
}


extension Array where Element:YLPBusiness{
	
	func adaptToBusinesses() -> [Bussiness] {
		return compactMap { yelpBusiness in
				guard let yelpCoordinate =
					yelpBusiness.location.coordinate else {
					return nil
				}
				let coordinate = CLLocationCoordinate2D(
					latitude: yelpCoordinate.latitude,
					longitude: yelpCoordinate.longitude)
					
				return Bussiness(name: yelpBusiness.name,
												rating: yelpBusiness.rating,
												location: coordinate)
			}
	}
}
