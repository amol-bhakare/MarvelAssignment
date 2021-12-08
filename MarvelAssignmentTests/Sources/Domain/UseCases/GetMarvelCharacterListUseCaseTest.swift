import XCTest
@testable import MarvelAssignment

class GetMarvelCharacterListUseCaseTest: XCTestCase {
    
    struct MarvelCharactersListRepositoryMock: MarvelCharactersListRepositoryProtocol {
        var result: Result<MarvelInfoModel, MarvelCharactersListUseCaseError>
        func fetchCharacterList(limit: Int, completion: @escaping (Result<MarvelInfoModel,
                                                                   MarvelCharactersListUseCaseError>) -> Void) {
            completion(result)
        }
    }

    func testMarvelCharacterListUseCase_SuccessfullyFetchesMarvelCharactersList() {
        // Arrange
        let expectation = self.expectation(description: "Succesfully fetched marvel list")
        let marvelResponse = MarvelInfoModel(code: 200,
                                            status: "success",
                                            copyright: "",
                                            attributionText: "",
                                            attributionHTML: "",
                                            etag: "",
                                            data: MarvelResultInfoModel(offset: 0,
                                                            limit: 30,
                                                            total: 100,
                                                            count: 30,
                                                            results: []))
        let marvelCharactersListRepositoryMock = MarvelCharactersListRepositoryMock(result: .success(marvelResponse))
        let useCase = GetAllMarvelCharactersUseCase(marvelCharacterListRepository: marvelCharactersListRepositoryMock)
        //Act
        useCase.getMarvelCharactersList(limit: 20) { result in
            switch result {
            // Assert
            case .success(let responseModel):
                XCTAssertNotNil(responseModel)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testMarvelCharacterListUseCase_FailedToFetchesMarvelCharactersList() {
        // Arrange
        let expectation = self.expectation(description: "Failed fetching marvel list")
        let marvelCharactersListRepositoryMock = MarvelCharactersListRepositoryMock(result: .failure(MarvelCharactersListUseCaseError.genericError))
        let useCase = GetAllMarvelCharactersUseCase(marvelCharacterListRepository: marvelCharactersListRepositoryMock)
        //Act
        useCase.getMarvelCharactersList(limit: 20) { result in
            switch result {
            // Assert
            case .success(let responseModel):
                XCTAssertNil(responseModel)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
