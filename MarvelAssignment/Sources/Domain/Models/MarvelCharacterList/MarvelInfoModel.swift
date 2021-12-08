import Foundation

enum MarvelModelError: Error {
    case mappingError
    case responseErrorWithMessage(String)
    case genericError
}

struct MarvelInfoModel: Equatable {
    let code: Int
    let status: String
    let copyright: String
    let attributionText: String
    let attributionHTML: String
    let etag: String
    let data: MarvelResultInfoModel
}
