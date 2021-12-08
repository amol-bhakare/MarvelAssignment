import Foundation
import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(navController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let makeMarvelCharacterLisDIContainer = appDIContainer.makeMarvelCharacterListDIContainer()
        let view = makeMarvelCharacterLisDIContainer.makeMarvelCharacterListViewController()
        self.navigationController.setViewControllers([view], animated: true)
    }
}
