import UIKit
import SDWebImage

final class MarvelCharacterTableViewCell: UITableViewCell {

    @IBOutlet private weak var imageViewCharacter: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var viewCellBackground: UIView!

    var marvelCharacterCellData: MarvelCharacterCellViewModel? {
        didSet {
            configureCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellUI()
    }

    private func setUpCellUI() {
        viewCellBackground.layer.cornerRadius = 5
        viewCellBackground.layer.masksToBounds = true
        viewCellBackground.layer.shadowColor = UIColor.black.cgColor
        viewCellBackground.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewCellBackground.layer.shadowRadius = 3
        viewCellBackground.layer.shadowOpacity = 0.5
        labelName.font = MarvelFonts.semibold
    }
    
    private func configureCell() {
        labelName.text = marvelCharacterCellData?.name
        imageViewCharacter.sd_setImage(with: marvelCharacterCellData?.thumbnail,
                                            placeholderImage: UIImage(named: MarvelAssignmentAsset.placeholder.name))
    }
}
