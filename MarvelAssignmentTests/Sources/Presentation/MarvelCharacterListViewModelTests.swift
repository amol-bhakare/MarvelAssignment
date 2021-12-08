import Foundation
import XCTest
@testable import MarvelAssignment

class MarvelCharacterListViewModelTests: XCTestCase {
    
    var marvelCharacters = [MarvelCharacterModel(characterDetails: MarvelCharacterDetailsModel(id: "1011334",
                                                                                     name: "3-D-Man",
                                                                                     description: "",
                                                                                     modified: "",
                                                                                     thumbnail: nil)),
                            MarvelCharacterModel(characterDetails: MarvelCharacterDetailsModel(id: "1009144",
                                                                                     name: "A.I.M.",
                                                                                     description: "",
                                                                                     modified: "",
                                                                                     thumbnail: nil))]
    
    func test_FetchMarvelCharacteresUsingValidRequest_Returns_Success_Response_And_Default_Limit() {
        
        // Arrange
        let marvelCharactersUseCaseMock = MarvelCharactersUseCaseMock()
        marvelCharactersUseCaseMock.expectation = self.expectation(description: "Api Returns Success")
        marvelCharactersUseCaseMock.marvelResponse = MarvelInfoModel(code: 200,
                                                                    status: "success",
                                                                    copyright: "",
                                                                    attributionText: "",
                                                                    attributionHTML: "",
                                                                    etag: "",
                                                                    data: MarvelResultInfoModel(offset: 0,
                                                                                    limit: 30,
                                                                                    total: 100,
                                                                                    count: 30,
                                                                                    results: marvelCharacters))
        let viewModel = MarvelCharactersListViewModel(useCaseGetAllMarvelCharacters: marvelCharactersUseCaseMock)
        // Act
        viewModel.fetchAllCharacters()
        // Assert
        XCTAssertEqual(viewModel.marvelResponse?.data.limit, DefaultTestParams.defaultCharactersLimit)
        XCTAssertNil(viewModel.error)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_FetchMarvelCharacteresUsingValidRequest_Returns_Failure() {
        
        // Arrange
        let marvelCharactersUseCaseMock = MarvelCharactersUseCaseMock()
        marvelCharactersUseCaseMock.expectation = self.expectation(description: "Api Returns error")
        marvelCharactersUseCaseMock.error = MarvelCharactersListUseCaseError.genericError
        let viewModel = MarvelCharactersListViewModel(useCaseGetAllMarvelCharacters: marvelCharactersUseCaseMock)
        // Act
        viewModel.fetchAllCharacters()
        // Assert
        XCTAssertNil(viewModel.marvelResponse)
        XCTAssertNotNil(viewModel.error)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_FetchMarvelCharactersUsingValidRequest_returns_BlankMarvelCharactersList() {
        
        // Arrange
        let marvelCharactersUseCaseMock = MarvelCharactersUseCaseMock()
        marvelCharactersUseCaseMock.expectation = self.expectation(description: "Api Returns Success With Result Blank")
        marvelCharactersUseCaseMock.marvelResponse = MarvelInfoModel(code: 200,
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
        let viewModel = MarvelCharactersListViewModel(useCaseGetAllMarvelCharacters: marvelCharactersUseCaseMock)
        // Act
        viewModel.fetchAllCharacters()
        // Assert
        XCTAssertTrue(viewModel.marvelResponse?.data.results.count == 0)
        XCTAssertNil(viewModel.error)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
