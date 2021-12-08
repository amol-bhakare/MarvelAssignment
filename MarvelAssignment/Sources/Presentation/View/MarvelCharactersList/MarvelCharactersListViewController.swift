import UIKit
import RappleProgressHUD

final class MarvelCharactersListViewController: UIViewController, Alertable {

    @IBOutlet private weak var tableMarvelCharacterList: UITableView!
    var marvelCharacterViewModel: MarvelCharactersListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        registerTableCells()
        loadAllMarvelCharacters()
        marvelCharacterViewModel?.loadMarvelCharactersList = { [weak self] in
            self?.loadMarvelCharactersListView()
        }
        marvelCharacterViewModel?.showMarvelCharactersListError = { [weak self] in
            self?.showMarvelCharactersListError()
        }
    }

    private func loadMarvelCharactersListView(){
        RappleActivityIndicatorView.stopAnimation(completionIndicator: .success,
                                                  completionLabel: "Completed".localized,
                                                  completionTimeout: 1.0)
        tableMarvelCharacterList.reloadData()
    }

    private func showMarvelCharactersListError(){
        RappleActivityIndicatorView.stopAnimation(completionIndicator: .failed,
                                                  completionLabel: "Completed".localized,
                                                  completionTimeout: 0.5)
        showError(marvelCharacterViewModel?.errorTitle ?? "" ,
                  marvelCharacterViewModel?.errorMessage ?? "")
    }

    private func showError(_ errorTitle: String, _ errorMessage: String) {
        guard !errorTitle.isEmpty else { return }
        showAlert(title: errorTitle, message: errorMessage)
    }

    static func create(with viewModel: MarvelCharactersListViewModel) -> MarvelCharactersListViewController {
        let view = MarvelCharactersListViewController(nibName: MarvelNibNames.ViewControllers.MarvelCharactersListViewController,
                                                      bundle: nil)
        view.marvelCharacterViewModel = viewModel
        return view
    }
}

extension MarvelCharactersListViewController {

    fileprivate func setUpTableView() {
        tableMarvelCharacterList.dataSource = self
        tableMarvelCharacterList.delegate = self
        tableMarvelCharacterList.backgroundColor = MarvelColors.AppBackgroundColor
        tableMarvelCharacterList.separatorStyle = .none
        self.navigationController?.navigationBar.isHidden = true
    }

    fileprivate func registerTableCells() {
        tableMarvelCharacterList.register(UINib(nibName: MarvelNibNames.TableCells.MarvelCharacterTableViewCell,
                                                bundle: nil),
                                          forCellReuseIdentifier: MarvelNibNames.TableCells.MarvelCharacterTableViewCell)
    }
}

extension MarvelCharactersListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelCharacterViewModel?.getMarvelCharactersCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MarvelNibNames.TableCells.MarvelCharacterTableViewCell) as? MarvelCharacterTableViewCell {
            cell.marvelCharacterCellData = marvelCharacterViewModel?.getDataForMarvelCell(indexPath: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension MarvelCharactersListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        marvelCharacterViewModel?.showCharacterDetails(navigationController: self.navigationController,
                                                       characterID: marvelCharacterViewModel?.getMarvelCharacterDetails(indexPath: indexPath).id ?? "")
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        marvelCharacterViewModel?.loadMoreCharacters(indexPath: indexPath)
    }
}

fileprivate extension MarvelCharactersListViewController {
    
    func loadAllMarvelCharacters() {
        RappleActivityIndicatorView.startAnimating()
        marvelCharacterViewModel?.fetchAllCharacters()
    }
}
