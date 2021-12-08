import Foundation

struct DataDTO: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [MarvelCharacterDTO]?
}

extension DataDTO {
    func toDomain() throws -> MarvelResultInfoModel {
        
        guard let offset = offset, let limit = limit, let total = total, let count = count, let results = results else {
            throw MarvelResultInfoModelError.mappinngError
        }

        return MarvelResultInfoModel(offset: offset,
                     limit: limit,
                     total: total,
                     count: count,
                     results: results.map{ return try! $0.toDomain()
        })
    }
}
