import Foundation

protocol GetMarvelCharacterDetailUseCaseProtocol {
    func getMarvelCharacterDetail(characterID: String,
                                  completion: @escaping (Result<MarvelInfoModel, MarvelCharacterDetailsUseCaseError>) -> Void)
}

final class GetMarvelCharacterDetailsUseCase: GetMarvelCharacterDetailUseCaseProtocol {

    private let marvelCharacterDetailRepository: MarvelCharacterDetailRepositoryProtocol

    init(marvelCharacterDetailRepository: MarvelCharacterDetailRepositoryProtocol) {
        self.marvelCharacterDetailRepository = marvelCharacterDetailRepository
    }
    
    func getMarvelCharacterDetail(characterID: String,
                                  completion: @escaping (Result<MarvelInfoModel, MarvelCharacterDetailsUseCaseError>) -> Void) {
        marvelCharacterDetailRepository.fetchMarvelCharacterDetail(characterID: characterID) { result in
           completion( result)
        }
    }
}
