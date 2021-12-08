import Foundation

final class MarvelCharacterListDIContainer {

    func makeMarvelCharacterListRepository() -> MarvelCharacterListRepository {
        return MarvelCharacterListRepository()
    }

    func getAllMarvelCharactersUseCase() -> GetAllMarvelCharactersUseCase {
        return GetAllMarvelCharactersUseCase(marvelCharacterListRepository: makeMarvelCharacterListRepository())
    }

    func makeMarvelCharactersListViewModel() -> MarvelCharactersListViewModel {
        return MarvelCharactersListViewModel(useCaseGetAllMarvelCharacters: getAllMarvelCharactersUseCase())
    }
    
    func makeMarvelCharacterListViewController() -> MarvelCharactersListViewController {
        return MarvelCharactersListViewController.create(with: makeMarvelCharactersListViewModel())
    }
}
