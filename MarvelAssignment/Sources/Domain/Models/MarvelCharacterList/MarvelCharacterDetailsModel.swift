import Foundation

struct MarvelCharacterDetailsModel: Equatable {
    let id: String
    let name: String
    let description: String?
    let modified: String
    let thumbnail: URL?
}
