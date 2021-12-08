import Foundation

protocol MarvelCharactersListRepositoryProtocol {
    func fetchCharacterList(limit: Int,
                            completion: @escaping (Result<MarvelInfoModel, MarvelCharactersListUseCaseError>) -> Void)
}
