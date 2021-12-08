import Foundation
import UIKit

final class MarvelCharacterDetailsViewModel {

    private let useCaseGetMarvelCharacterDetail: GetMarvelCharacterDetailUseCaseProtocol
    var characterID: String
    var marvelResponse: MarvelInfoModel?
    var errorTitle = ""
    var errorMessage = ""
    var loadMarvelCharactersDetails: (() -> Void)?
    var showMarvelCharacterDetailsError: (() -> Void)?

    var character: MarvelCharacterModel? {
        didSet {
            self.loadMarvelCharactersDetails?()
        }
    }

    var error: Error? {
        didSet {
            self.showMarvelCharacterDetailsError?()
        }
    }

    init(useCaseGetMarvelCharacterDetail: GetMarvelCharacterDetailUseCaseProtocol, characterID: String) {
        self.useCaseGetMarvelCharacterDetail = useCaseGetMarvelCharacterDetail
        self.characterID = characterID
    }

    func getMarvelDescription() -> String {
        guard let character = character, let characterDescription = character.characterDetails.description else {
            return "No_description_found_for_this_character".localized
        }

        return  characterDescription.isEmpty ? "No_description_found_for_this_character".localized : characterDescription
    }

    func showMarvelCharactersList(navigationController: UINavigationController?) {
        let marvelCharacterDetailsFlowCoordinator = MarvelCharacterDetailsFlowCoordinator(navigationController: navigationController)
        marvelCharacterDetailsFlowCoordinator.showMarvelCharactersList()
    }

    fileprivate func handleMarvelCharacterDetailUseCaseError(_ responseError: (MarvelCharacterDetailsUseCaseError)) {
        switch responseError {
        case .characterDetailsLoadingFailed:
            self.errorTitle = "Message".localized
            self.errorMessage = "Couldnt_load_character_details".localized
        case .genericError, .mappingError :
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

    func fetchCharacterDetails() {
        useCaseGetMarvelCharacterDetail.getMarvelCharacterDetail(characterID: characterID) { [weak self] result in
            switch result {
            case .success(let responseModel):
                self?.marvelResponse = responseModel
                self?.character = !responseModel.data.results.isEmpty ? responseModel.data.results[0] : nil
            case .failure(let error):
                self?.handleMarvelCharacterDetailUseCaseError(error)
                self?.error = error
            }
        }
    }
}
