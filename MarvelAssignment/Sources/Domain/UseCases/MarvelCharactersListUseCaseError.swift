import Foundation

enum MarvelCharactersListUseCaseError: Error {
    case maximumFetchLimitReached
    case mappingError(Error)
    case networkError(NetworkError)
    case genericError
}
