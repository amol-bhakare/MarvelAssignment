import Foundation

final class AppDIContainer {

    func makeMarvelCharacterListDIContainer() -> MarvelCharacterListDIContainer {
        return MarvelCharacterListDIContainer()
    }
    
    func makeMarvelCharacterDetailsDIContainer() -> MarvelCharacterDetailsDIContainer {
        return MarvelCharacterDetailsDIContainer()
    }
}
