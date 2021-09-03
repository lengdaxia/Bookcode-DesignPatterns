import UIKit


public class HomeCoordinate: Coordinator{
	
	public var children: [Coordinator] = []
	public let router: Router
	
	public init(router: Router){
		self.router = router
	}
	
	public func present(animated: Bool, onDismissed: (() -> Void)?) {
		let viewController = HomeViewController.instantiate(delegate: self)
		
		router.present(viewController, animated: animated, onDismissed: onDismissed)
	}
}

extension HomeCoordinate: HomeViewControllerDelegate{
	public func homeViewControllerDidPressScheduleAppointment(_ viewController: HomeViewController) {

		
		let router =
			ModalNavigationRouter(parentViewController: viewController)
		let coordinator =
			PetAppointmentBuilderCoordinator(router: router)
		presentChild(coordinator, animated: true)
	}
}
