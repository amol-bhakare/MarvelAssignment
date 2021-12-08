import Foundation

enum MarvelCharacterModelError: Error {
    case mappingError
}

struct MarvelCharacterModel: Equatable {
    let characterDetails: MarvelCharacterDetailsModel
}
