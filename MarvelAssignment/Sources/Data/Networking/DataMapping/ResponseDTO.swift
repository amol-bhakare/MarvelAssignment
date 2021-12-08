import Foundation

struct ResponseDTO: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: DataDTO?
}
extension ResponseDTO {
    func toDomain() throws -> MarvelInfoModel {
        
        guard let code = code, let status = status, let copyright = copyright,
              let attributionText = attributionText, let attributionHTML = attributionHTML,
              let etag = etag, let dataOptional = data, let dataToDomain = try? dataOptional.toDomain() else {
            throw MarvelModelError.mappingError
        }

        return MarvelInfoModel(code: code, status: status,
                     copyright: copyright,
                     attributionText: attributionText,
                     attributionHTML: attributionHTML,
                     etag: etag,
                     data: dataToDomain)
    }
}
