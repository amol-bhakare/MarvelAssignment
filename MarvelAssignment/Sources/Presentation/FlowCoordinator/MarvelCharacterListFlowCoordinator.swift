import UIKit

final class MarvelCharacterListFlowCoordinator {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func showMarvelCharacterDetails(characterID: String) {
        let makeMarvelCharacterDetailDIContainer = MarvelCharacterDetailsDIContainer()
        let view = makeMarvelCharacterDetailDIContainer.makeMarvelCharacterDetailViewController(characterID: characterID)
        self.navigationController?.pushViewController(view, animated: true)
    }
}
