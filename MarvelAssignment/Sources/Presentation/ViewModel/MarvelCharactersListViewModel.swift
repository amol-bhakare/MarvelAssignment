import Foundation
import UIKit

struct MarvelCharacterListConstants {
    static let limit = 20
    static let totalEntries = 110
    static let paginationLimit = 10
}

final class MarvelCharactersListViewModel {

    let useCaseGetAllMarvelCharacters: GetMarvelCharactersUseCaseProtocol
    var limit = MarvelCharacterListConstants.limit
    let totalEntries = MarvelCharacterListConstants.totalEntries
    var marvelResponse: MarvelInfoModel?
    var errorTitle = ""
    var errorMessage = ""
    var loadMarvelCharactersList: (() -> Void)?
    var showMarvelCharactersListError: (() -> Void)?

    var marvelCharacters: [MarvelCharacterModel] = [] {
        didSet {
            self.loadMarvelCharactersList?()
        }
    }

    var error: Error? {
        didSet {
            self.showMarvelCharactersListError?()
        }
    }

    init(useCaseGetAllMarvelCharacters: GetMarvelCharactersUseCaseProtocol) {
        self.useCaseGetAllMarvelCharacters = useCaseGetAllMarvelCharacters
    }

    func getMarvelCharacterDetails(indexPath: IndexPath) -> MarvelCharacterDetailsModel {
        return marvelCharacters[indexPath.row].characterDetails
    }

    func getMarvelCharactersCount() -> Int {
        return marvelCharacters.count
    }

    func getDataForMarvelCell(indexPath: IndexPath) -> MarvelCharacterCellViewModel {
        let character = marvelCharacters[indexPath.row]
        let cellData = MarvelCharacterCellViewModel(thumbnail: character.characterDetails.thumbnail,
                                               name: character.characterDetails.name)
        return cellData
    }

    func showCharacterDetails(navigationController: UINavigationController?,
                              characterID: String) {
        let marvelCharacterListFlowCordinator =  MarvelCharacterListFlowCoordinator(navigationController: navigationController)
        marvelCharacterListFlowCordinator.showMarvelCharacterDetails(characterID: characterID)
    }

    func loadMoreCharacters(indexPath: IndexPath) {
        if indexPath.row == marvelCharacters.count - 1 {
            if marvelCharacters.count < totalEntries {
                fetchAllCharacters()
            }
        }
    }

    fileprivate func handleMarvelCharactersListUseCaseError(_ responseError: MarvelCharactersListUseCaseError) {
        switch responseError {
        case .maximumFetchLimitReached:
            self.errorTitle = "Message".localized
            self.errorMessage = "Couldnt_load_more_characters_You_have_reached_to_maximum_limit".localized
        case .genericError, .mappingError:
            self.errorTitle = "Error".localized
            self.errorMessage = "Something_went_wrong_please_try_again".localized
        case .networkError(let error):
            switch error {
            case .internetOffline:
                self.errorTitle = "Message".localized
                self.errorMessage = "The_Internet_connection_appears_to_be_offline".localized
            case .genericError:
                self.errorTitle = "Error".localized
                self.errorMessage = "Something_went_wrong_please_try_again".localized
            }
        }
    }

    func fetchAllCharacters() {
        self.limit += MarvelCharacterListConstants.paginationLimit
        useCaseGetAllMarvelCharacters.getMarvelCharactersList(limit: limit) { [weak self] result in
            switch result {
            case .success(let responseModel):
                self?.marvelResponse = responseModel
                self?.marvelCharacters = responseModel.data.results
            case .failure(let error):
                self?.handleMarvelCharactersListUseCaseError(error)
                self?.error = error
            }
        }
    }
}
