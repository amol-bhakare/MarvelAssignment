import Foundation

struct ThumbnailDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case filePath = "path"
        case fileExtension = "extension"
    }
    let filePath: String?
    let fileExtension: String?
}
extension ThumbnailDTO {
    func toDomain() throws -> URL? {
        
        guard let path = filePath, let ext = fileExtension else {
            throw MarvelModelError.mappingError
        }

        return URL(string: path+"."+ext) ?? nil
    }
}
