import Foundation

enum MarvelResultInfoModelError: Error {
    case mappinngError
}

struct MarvelResultInfoModel: Equatable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [MarvelCharacterModel]
}
