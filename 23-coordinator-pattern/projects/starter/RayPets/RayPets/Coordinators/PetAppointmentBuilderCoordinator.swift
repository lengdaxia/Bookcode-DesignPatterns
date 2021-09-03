import UIKit

public class PetAppointmentBuilderCoordinator: Coordinator{
	
	
	public var children: [Coordinator] = []
	
	public let router: Router
	public let builder = PetAppointmentBuilder()
	
	public init(router: Router){
		self.router = router
	}
	
	public func present(animated: Bool, onDismissed: (() -> Void)?) {
		
		let viewController = SelectVisitTypeViewController.instantiate(delegate: self)
		
		router.present(viewController, animated: animated, onDismissed: onDismissed)
	}
}

// MARK: - SelectVisitTypeViewControllerDelegate
extension PetAppointmentBuilderCoordinator:
	SelectVisitTypeViewControllerDelegate {

	public func selectVisitTypeViewController(
		_ controller: SelectVisitTypeViewController,
		didSelect visitType: VisitType) {

		// 1
		builder.visitType = visitType
		
		// 2
		switch visitType {
		case .well:
			// 3
			presentNoAppointmentViewController()
		case .sick:
			// 4
			presentSelectPainLevelCoordinator()
		}
	}

	private func presentNoAppointmentViewController() {
		let viewController =
			NoAppointmentRequiredViewController.instantiate(
				delegate: self)
		router.present(viewController, animated: true)
	}

	private func presentSelectPainLevelCoordinator() {
		let viewController =
			SelectPainLevelViewController.instantiate(delegate: self)
		router.present(viewController, animated: true)
	}
}

// MARK: - SelectPainLevelViewControllerDelegate
extension PetAppointmentBuilderCoordinator:
	SelectPainLevelViewControllerDelegate {

	public func selectPainLevelViewController(
		_ controller: SelectPainLevelViewController,
		didSelect painLevel: PainLevel) {

		// 1
		builder.painLevel = painLevel

		// 2
		switch painLevel {

		// 3
		case .none, .little:
			presentFakingItViewController()

		// 4
		case .moderate, .severe, .worstPossible:
			presentNoAppointmentViewController()
		}
	}

	private func presentFakingItViewController() {
		let viewController =
			FakingItViewController.instantiate(delegate: self)
		router.present(viewController, animated: true)
	}
}

// MARK: - FakingItViewControllerDelegate
extension PetAppointmentBuilderCoordinator:
	FakingItViewControllerDelegate {

	public func fakingItViewControllerPressedIsFake(
		_ controller: FakingItViewController) {
		router.dismiss(animated: true)
	}

	public func fakingItViewControllerPressedNotFake(
		_ controller: FakingItViewController) {
		presentNoAppointmentViewController()
	}
}


// MARK: - NoAppointmentRequiredViewControllerDelegate
extension PetAppointmentBuilderCoordinator:
	NoAppointmentRequiredViewControllerDelegate {

	public func noAppointmentViewControllerDidPressOkay(
		_ controller: NoAppointmentRequiredViewController) {
		router.dismiss(animated: true)
	}
}
