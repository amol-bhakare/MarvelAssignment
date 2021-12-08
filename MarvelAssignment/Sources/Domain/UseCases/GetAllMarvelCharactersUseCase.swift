import Foundation

protocol GetMarvelCharactersUseCaseProtocol {
    func getMarvelCharactersList(limit: Int,
                                 completion: @escaping (Result<MarvelInfoModel, MarvelCharactersListUseCaseError>) -> Void)
}

final class GetAllMarvelCharactersUseCase: GetMarvelCharactersUseCaseProtocol {

    private let marvelCharacterListRepository: MarvelCharactersListRepositoryProtocol

    init(marvelCharacterListRepository: MarvelCharactersListRepositoryProtocol) {
        self.marvelCharacterListRepository = marvelCharacterListRepository
    }
    
    func getMarvelCharactersList(limit: Int,
                                 completion: @escaping (Result<MarvelInfoModel, MarvelCharactersListUseCaseError>) -> Void) {
        marvelCharacterListRepository.fetchCharacterList(limit: limit) { result in
            completion( result)
        }
    }
}
