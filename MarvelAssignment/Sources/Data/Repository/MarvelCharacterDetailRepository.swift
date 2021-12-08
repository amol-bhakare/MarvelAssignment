import Foundation
import Moya
import Alamofire

final class MarvelCharacterDetailRepository: MarvelCharacterDetailRepositoryProtocol {

    var provider = MoyaProvider<MarvelAPI>(plugins: [NetworkLoggerPlugin()])

    func fetchMarvelCharacterDetails(characterID: String,
                                     completion: @escaping (Result<ResponseDTO, Error>) -> Void) {
        request(target: .marvelCharacterDetails(characterID: characterID),
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
    
    func fetchMarvelCharacterDetail(characterID: String,
                                    completion: @escaping (Result<MarvelInfoModel, MarvelCharacterDetailsUseCaseError>) -> Void) {
        
        fetchMarvelCharacterDetails(characterID: characterID) { result in
            switch result {
            case .success(let response):
                guard let code = response.code else {
                    completion(.failure(MarvelCharacterDetailsUseCaseError.genericError))
                    return
                }
                if code != NetworkHttpCode.httpCode_200 {
                    if code == NetworkHttpCode.httpCode_404 {
                        completion(.failure(MarvelCharacterDetailsUseCaseError.characterDetailsLoadingFailed))
                    } else {
                        completion(.failure(MarvelCharacterDetailsUseCaseError.genericError))
                    }
                } else {
                    do {
                        let marvelResponse = try response.toDomain()
                        completion(.success(marvelResponse))
                    } catch let error {
                        completion(.failure(MarvelCharacterDetailsUseCaseError.mappingError(error)))
                    }
                }
            case .failure(let error):
                let moyaError: MoyaError? = error as? MoyaError
                if let _ = moyaError?.AfError?.isSessionTaskError {
                    completion(.failure(MarvelCharacterDetailsUseCaseError.networkError(.internetOffline)))
                } else {
                    completion(.failure(MarvelCharacterDetailsUseCaseError.networkError(.genericError)))
                }
            }
        }
    }
}
