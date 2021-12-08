import Foundation

final class MarvelCharacterDetailsDIContainer {

    func makeMarvelCharacterDetailViewController(characterID: String) -> MarvelCharacterDetailsViewController {
        return MarvelCharacterDetailsViewController.create(with: makeMarvelCharacterDetailsViewModel(characterID: characterID))
    }

    func makeMarvelCharacterDetailsViewModel(characterID: String) -> MarvelCharacterDetailsViewModel {
        return MarvelCharacterDetailsViewModel(useCaseGetMarvelCharacterDetail: makeGetMarvelCharacterDetailUseCase(),
                                               characterID: characterID)
    }

    func makeGetMarvelCharacterDetailUseCase() -> GetMarvelCharacterDetailsUseCase {
        return GetMarvelCharacterDetailsUseCase(marvelCharacterDetailRepository: makeMarvelCharacterDetailRepository())
    }
    
    func makeMarvelCharacterDetailRepository() -> MarvelCharacterDetailRepository {
        return MarvelCharacterDetailRepository()
    }
}
