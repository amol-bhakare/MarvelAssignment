import Foundation

protocol MarvelCharacterDetailRepositoryProtocol {
    func fetchMarvelCharacterDetail(characterID: String,
                                    completion: @escaping (Result<MarvelInfoModel, MarvelCharacterDetailsUseCaseError>) -> Void)
}
