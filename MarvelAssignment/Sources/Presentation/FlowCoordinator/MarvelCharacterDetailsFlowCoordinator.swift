import UIKit

final class MarvelCharacterDetailsFlowCoordinator {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func showMarvelCharactersList() {
        self.navigationController?.popViewController(animated: true)
    }
}
