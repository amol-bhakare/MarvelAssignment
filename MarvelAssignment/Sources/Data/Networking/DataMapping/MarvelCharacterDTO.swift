import Foundation

struct MarvelCharacterDTO: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let thumbnail: ThumbnailDTO?
}

extension MarvelCharacterDTO {
    func toDomain() throws -> MarvelCharacterModel {
        
        guard let id = id, let name = name, let description = description,
              let modified = modified, let thumbnail = thumbnail,
              let thumbnailtoDomain = try? thumbnail.toDomain() else {
            throw MarvelCharacterModelError.mappingError
        }

        return MarvelCharacterModel(characterDetails: MarvelCharacterDetailsModel(id: String(id),
                                                                                  name: name,
                                                                                  description: description,
                                                                                  modified: modified,
                                                                                  thumbnail: thumbnailtoDomain))
    }
}
