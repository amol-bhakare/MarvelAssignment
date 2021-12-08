import Foundation
import XCTest
@testable import MarvelAssignment

class MarvelCharachterDetailViewModelTests: XCTestCase {
    
    var marvelCharacters = [MarvelCharacterModel(characterDetails: MarvelCharacterDetailsModel(id: "1011334",
                                                                                     name: "3-D-Man",
                                                                                     description: "",
                                                                                     modified: "",
                                                                                     thumbnail: nil))]
    
    func test_FetchMarvelCharacterDetailsUsingValidRequest_Returns_Success_Response_And_Default_Limit() {
        
        // Arrange
        let marvelCharacterDetailsUseCaseMock = MarvelCharacterDetailsUseCaseMock()
        marvelCharacterDetailsUseCaseMock.expectation = self.expectation(description: "Api Returns Success")
        marvelCharacterDetailsUseCaseMock.marvelResponse = MarvelInfoModel(code: 200,
                                                                          status: "success",
                                                                          copyright: "",
                                                                          attributionText: "",
                                                                          attributionHTML: "",
                                                                          etag: "",
                                                                          data: MarvelResultInfoModel(offset: 0,
                                                                                          limit: DefaultTestParams.defaultCharactersLimit,
                                                                                          total: 100,
                                                                                          count: 30,
                                                                                          results: marvelCharacters))
        let viewModel = MarvelCharacterDetailsViewModel(useCaseGetMarvelCharacterDetail: marvelCharacterDetailsUseCaseMock,
                                                        characterID: DefaultCharacter.CharacterID)
        // Act
        viewModel.fetchCharacterDetails()
        // Assert
        XCTAssertEqual(viewModel.marvelResponse?.data.limit, DefaultTestParams.defaultCharactersLimit)
        XCTAssertNil(viewModel.error)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_FetchMarvelCharacterDetailsUsingValidRequest_Returns_Failure() {
        
        // Arrange
        let marvelCharacterDetailsUseCaseMock = MarvelCharacterDetailsUseCaseMock()
        marvelCharacterDetailsUseCaseMock.expectation = self.expectation(description: "Api Returns error")
        marvelCharacterDetailsUseCaseMock.error = MarvelCharacterDetailsUseCaseError.genericError
        let viewModel = MarvelCharacterDetailsViewModel(useCaseGetMarvelCharacterDetail: marvelCharacterDetailsUseCaseMock,
                                                        characterID: DefaultCharacter.CharacterID)
        // Act
        viewModel.fetchCharacterDetails()
        // Assert
        XCTAssertNil(viewModel.marvelResponse)
        XCTAssertNotNil(viewModel.error)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
