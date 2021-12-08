import Foundation
import XCTest
@testable import MarvelAssignment

class MarvelCharactersUseCaseMock: GetMarvelCharactersUseCaseProtocol {

    var expectation: XCTestExpectation?
    var error: MarvelCharactersListUseCaseError?
    var marvelResponse = MarvelInfoModel(code: 0, status: "", copyright: "", attributionText: "", attributionHTML: "", etag: "",
                                        data: MarvelResultInfoModel(offset: 0, limit: 0, total: 0, count: 0, results: []))
    
    func getMarvelCharactersList(limit: Int, completion: @escaping (Result<MarvelInfoModel,
                                                                    MarvelCharactersListUseCaseError>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(marvelResponse))
        }
        expectation?.fulfill()
    }
}
