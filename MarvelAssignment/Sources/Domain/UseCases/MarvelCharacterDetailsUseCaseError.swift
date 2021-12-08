import Foundation

enum MarvelCharacterDetailsUseCaseError: Error {
    case characterDetailsLoadingFailed
    case mappingError(Error)
    case networkError(NetworkError)
    case genericError
}
