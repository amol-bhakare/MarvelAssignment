import Foundation
import Moya
import Alamofire



final class MarvelCharacterListRepository: MarvelCharactersListRepositoryProtocol {

    var provider = MoyaProvider<MarvelAPI>(plugins: [NetworkLoggerPlugin()])

    func fetchAllMarvelCharacters(limit: Int,
                                  completion: @escaping (Result<ResponseDTO, Error>) -> Void) {
        request(target: .marvelCharacter(limit: limit),
                completion: completion)
    }

    private func request(target: MarvelAPI,
                         completion: @escaping (Result<ResponseDTO, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(ResponseDTO.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchCharacterList(limit: Int,
                            completion: @escaping (Result<MarvelInfoModel, MarvelCharactersListUseCaseError>) -> Void) {
        
        fetchAllMarvelCharacters(limit: limit) { result in
            switch result {
            case .success(let response):
                guard let code = response.code else {
                    completion(.failure(MarvelCharactersListUseCaseError.genericError))
                    return
                }
                if code != NetworkHttpCode.httpCode_200 {
                    if code == NetworkHttpCode.httpCode_409 {
                        completion(.failure(MarvelCharactersListUseCaseError.maximumFetchLimitReached))
                    } else {
                        completion(.failure(MarvelCharactersListUseCaseError.genericError))
                    }
                } else {
                    do {
                        let marvelResponse = try response.toDomain()
                        completion(.success(marvelResponse))
                    } catch let error {
                        completion(.failure(MarvelCharactersListUseCaseError.mappingError(error)))
                    }
                }
            case .failure(let error):
                let moyaError: MoyaError? = error as? MoyaError
                if let _ = moyaError?.AfError?.isSessionTaskError {
                    completion(.failure(MarvelCharactersListUseCaseError.networkError(.internetOffline)))
                } else {
                    completion(.failure(MarvelCharactersListUseCaseError.networkError(.genericError)))
                }
            }
        }
    }
}


