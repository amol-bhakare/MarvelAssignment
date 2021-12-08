import Foundation
import Moya
import Alamofire

enum MarvelAPI {
    case marvelCharacter(limit: Int)
    case marvelCharacterDetails(characterID: String)
}

extension MarvelAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: ApiParams.urlSchema+ApiParams.baseUrl+ApiParams.apiVersion+ApiParams.apiType) else {
            fatalError()
        }
        return url
    }
    var path: String {
        switch self {
        case .marvelCharacter:
            return ApiEndPoints.MarvelCharacters
        case .marvelCharacterDetails(let characterID):
            return "/characters/\(characterID)"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var sampleData: Data {
        switch self {
        case .marvelCharacter:
            return DataResponseHandler.getJsonResponseData(filename: "MarvelCharactersListResponse")
        case .marvelCharacterDetails:
            return DataResponseHandler.getJsonResponseData(filename: "MarvelCharacterDetailsResponse")
        }
    }
    var task: Task {
        switch self {
        case .marvelCharacter(let limit):
            return .requestParameters(parameters: ["ts": MarvelAssignment.timeStamp,
                                                   "apikey": MarvelAssignment.apiKey,
                                                   "hash": MarvelAssignment.hashKey,
                                                   "limit": limit], encoding: URLEncoding.queryString)
        case .marvelCharacterDetails:
            return .requestParameters(parameters: ["ts": MarvelAssignment.timeStamp,
                                                   "apikey": MarvelAssignment.apiKey,
                                                   "hash": MarvelAssignment.hashKey], encoding: URLEncoding.queryString)
        }
    }
    var headers: [String: String]? {
        return nil
    }
}

extension MoyaError {

    var AfError: AFError? {
        if case let .underlying(uError, _) = self, let afError = uError as? AFError {
            return afError
        }
        return nil
    }
}
