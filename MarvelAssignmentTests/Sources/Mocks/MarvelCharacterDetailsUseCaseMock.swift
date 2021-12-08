import Foundation
import XCTest
@testable import MarvelAssignment

class MarvelCharacterDetailsUseCaseMock: GetMarvelCharacterDetailUseCaseProtocol {

    var expectation: XCTestExpectation?
    var error: MarvelCharacterDetailsUseCaseError?
    var marvelResponse = MarvelInfoModel(code: 0, status: "", copyright: "", attributionText: "", attributionHTML: "", etag: "",
                                        data: MarvelResultInfoModel(offset: 0, limit: 0, total: 0, count: 0, results: []))
    
    func getMarvelCharacterDetail(characterID: String, completion: @escaping (Result<MarvelInfoModel,
                                                                              MarvelCharacterDetailsUseCaseError>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(marvelResponse))
        }
        expectation?.fulfill()
    }
}
