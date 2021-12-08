import UIKit
import RappleProgressHUD

final class MarvelCharacterDetailsViewController: UIViewController, Alertable {

    @IBOutlet private weak var buttonBack: UIButton!
    @IBOutlet private weak var imageCharacter: UIImageView!
    @IBOutlet private weak var labelCharacterDescription: UILabel!
    @IBOutlet private weak var labelCharacterName: UILabel!
    var marvelCharacterDetailsViewModel: MarvelCharacterDetailsViewModel?

    @IBAction func backButtonClicked(_ sender: Any) {
        marvelCharacterDetailsViewModel?.showMarvelCharactersList(navigationController: self.navigationController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getMarvelCharacterDetail()
        marvelCharacterDetailsViewModel?.loadMarvelCharactersDetails = { [weak self] in
            self?.loadMarvelCharactersDetailsView()
        }
        marvelCharacterDetailsViewModel?.showMarvelCharacterDetailsError = { [weak self] in
            self?.showMarvelCharacterDetailsError()
        }
    }

    private func loadMarvelCharactersDetailsView() {
        RappleActivityIndicatorView.stopAnimation(completionIndicator: .success,
                                                  completionLabel: "Completed".localized,
                                                  completionTimeout: 1.0)
        imageCharacter.sd_setImage(with: marvelCharacterDetailsViewModel?.character?.characterDetails.thumbnail,
                                    placeholderImage: UIImage(named: MarvelAssignmentAsset.placeholder.name))
        labelCharacterName.text = marvelCharacterDetailsViewModel?.character?.characterDetails.name
        labelCharacterDescription.text = marvelCharacterDetailsViewModel?.getMarvelDescription()
    }

    private func showMarvelCharacterDetailsError() {
        RappleActivityIndicatorView.stopAnimation(completionIndicator: .failed,
                                                  completionLabel: "Completed".localized,
                                                  completionTimeout: 0.5)
        showError(marvelCharacterDetailsViewModel?.errorTitle ?? "",
                       marvelCharacterDetailsViewModel?.errorMessage ?? "")
    }
    
    private func getMarvelCharacterDetail() {
        RappleActivityIndicatorView.startAnimating()
        marvelCharacterDetailsViewModel?.fetchCharacterDetails()
    }

    private func showError(_ errorTitle: String, _ errorMessage: String) {
        guard !errorTitle.isEmpty else { return }
        showAlert(title: errorTitle, message: errorMessage)
    }

    static func create(with viewModel: MarvelCharacterDetailsViewModel) -> MarvelCharacterDetailsViewController {
        let view = MarvelCharacterDetailsViewController(nibName: MarvelNibNames.ViewControllers.MarvelCharacterDetailsViewController,
                                                        bundle: nil)
        view.marvelCharacterDetailsViewModel = viewModel
        return view
    }
}
