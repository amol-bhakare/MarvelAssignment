import XCTest
@testable import MarvelAssignment

class GetMarvelCharacterDetailsUseCaseTest: XCTestCase {
    
    struct MarvelCharacterDetailRepositoryMock: MarvelCharacterDetailRepositoryProtocol {
        var result: Result<MarvelInfoModel, MarvelCharacterDetailsUseCaseError>
        func fetchMarvelCharacterDetail(characterID: String, completion: @escaping (Result<MarvelInfoModel, MarvelCharacterDetailsUseCaseError>) -> Void) {
            completion(result)
        }
    }
    
    func testMarvelCharacterListUseCase_SuccessfullyFetchesMarvelCharacterDetails() {
        // Arrange
        let expectation = self.expectation(description: "Succesfully fetched marvel Details")
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
        
        let marvelCharacterDetailRepositoryMock = MarvelCharacterDetailRepositoryMock(result: .success(marvelResponse))
        let useCase = GetMarvelCharacterDetailsUseCase(marvelCharacterDetailRepository: marvelCharacterDetailRepositoryMock)
        //Act
        useCase.getMarvelCharacterDetail(characterID: DefaultCharacter.CharacterID) { result in
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

    func testMarvelCharacterListUseCase_FailedToFetchesMarvelCharacterDetails() {
        // Arrange
        let expectation = self.expectation(description: "Failed fetching marvel Details")
        let marvelCharacterDetailRepositoryMock = MarvelCharacterDetailRepositoryMock(result: .failure(MarvelCharacterDetailsUseCaseError.genericError))
        let useCase = GetMarvelCharacterDetailsUseCase(marvelCharacterDetailRepository: marvelCharacterDetailRepositoryMock)
        //Act
        useCase.getMarvelCharacterDetail(characterID: DefaultCharacter.CharacterID) { result in
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
